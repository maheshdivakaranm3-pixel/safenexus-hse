import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep155Page extends StatefulWidget {
  const SafeNexusStep155Page({super.key});

  @override
  State<SafeNexusStep155Page> createState() => _SafeNexusStep155ageState();
}

class _SafeNexusStep155ageState extends State<SafeNexusStep155Page> {
  static const String _storageKey = 'workhub_hse_actions_v1';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  String _statusFilter = 'All';
  bool _loading = true;

  final List<String> _statuses = const <String>[
    'Open',
    'In Progress',
    'Pending Verification',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_storageKey);

    List<Map<String, dynamic>> loaded = <Map<String, dynamic>>[];

    if (raw != null && raw.isNotEmpty) {
      try {
        final dynamic decoded = jsonDecode(raw);
        if (decoded is List) {
          loaded = decoded
              .whereType<Map>()
              .map((Map item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        loaded = <Map<String, dynamic>>[];
      }
    }

    if (!mounted) return;

    setState(() {
      _records = loaded;
      _loading = false;
    });
  }

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  List<Map<String, dynamic>> get _visibleRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> record) {
      final String status = (record['status'] ?? 'Open').toString();

      final String searchable = <dynamic>[
        record['title'],
        record['description'],
        record['assignedTo'],
        record['priority'],
        record['module'],
        record['source'],
      ].map((dynamic item) => item.toString().toLowerCase()).join(' ');

      final bool searchMatch =
          query.isEmpty || searchable.contains(query);
      final bool statusMatch =
          _statusFilter == 'All' || status == _statusFilter;

      return searchMatch && statusMatch;
    }).toList();
  }

  int _countStatus(String status) {
    return _records.where(
      (Map<String, dynamic> record) =>
          (record['status'] ?? 'Open').toString() == status,
    ).length;
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final DateTime? due =
        DateTime.tryParse((record['dueDate'] ?? '').toString());

    if (due == null) return false;

    return due.isBefore(DateTime.now()) &&
        (record['status'] ?? 'Open').toString() != 'Closed';
  }

  Future<void> _addRecord() async {
    final TextEditingController titleController =
        TextEditingController();
    final TextEditingController descriptionController =
        TextEditingController();
    final TextEditingController assignedController =
        TextEditingController();
    final TextEditingController dueDateController =
        TextEditingController();

    String priority = 'Medium';

    final bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setDialogState,
          ) {
            return AlertDialog(
              title: const Text('Add HSE Record'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Details',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: assignedController,
                      decoration: const InputDecoration(
                        labelText: 'Responsible Person',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: dueDateController,
                      decoration: const InputDecoration(
                        labelText: 'Due Date (YYYY-MM-DD)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(),
                      ),
                      items: const <String>[
                        'Low',
                        'Medium',
                        'High',
                        'Critical',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        if (value == null) return;
                        setDialogState(() {
                          priority = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty) return;
                    Navigator.of(dialogContext).pop(true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != true || titleController.text.trim().isEmpty) {
      titleController.dispose();
      descriptionController.dispose();
      assignedController.dispose();
      dueDateController.dispose();
      return;
    }

    final String now = DateTime.now().toIso8601String();

    _records.insert(0, <String, dynamic>{
      'id': 'SN-155-${DateTime.now().millisecondsSinceEpoch}',
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'assignedTo': assignedController.text.trim().isEmpty
          ? 'Unassigned'
          : assignedController.text.trim(),
      'status': 'Open',
      'priority': priority,
      'dueDate': dueDateController.text.trim(),
      'createdAt': now,
      'updatedAt': now,
      'step': 155,
      'module': 'HSE Management Control',
      'source': 'SafeNexus HSE',
    });

    await _saveRecords();

    titleController.dispose();
    descriptionController.dispose();
    assignedController.dispose();
    dueDateController.dispose();

    if (mounted) setState(() {});
  }

  Future<void> _changeStatus(Map<String, dynamic> record) async {
    final String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Change Status'),
          children: _statuses.map((String status) {
            return SimpleDialogOption(
              onPressed: () => Navigator.of(context).pop(status),
              child: Text(status),
            );
          }).toList(),
        );
      },
    );

    if (selected == null) return;

    final String now = DateTime.now().toIso8601String();

    record['status'] = selected;
    record['updatedAt'] = now;

    if (selected == 'Closed') {
      record['verifiedAt'] = now;
      record['closureNote'] = 'Closed through SafeNexus HSE';
    }

    await _saveRecords();

    if (mounted) setState(() {});
  }

  Future<void> _copyRecord(Map<String, dynamic> record) async {
    final String text =
        const JsonEncoder.withIndent('  ').convert(record);

    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record copied')),
    );
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete record?'),
          content: Text((record['title'] ?? '').toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    _records.remove(record);
    await _saveRecords();

    if (mounted) setState(() {});
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  Widget _metric(
    String label,
    int value,
    IconData icon,
  ) {
    return SizedBox(
      width: 105,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Icon(icon, size: 22),
              const SizedBox(height: 4),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final int overdue = _records.where(_isOverdue).length;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _metric('Total', _records.length, Icons.list_alt),
        _metric('Open', _countStatus('Open'), Icons.pending_actions),
        _metric(
          'Progress',
          _countStatus('In Progress'),
          Icons.timelapse,
        ),
        _metric(
          'Verification',
          _countStatus('Pending Verification'),
          Icons.fact_check,
        ),
        _metric(
          'Closed',
          _countStatus('Closed'),
          Icons.check_circle,
        ),
        _metric('Overdue', overdue, Icons.warning),
      ],
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final String status = (record['status'] ?? 'Open').toString();
    final String priority =
        (record['priority'] ?? 'Medium').toString();
    final bool overdue = _isOverdue(record);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    (record['title'] ?? 'Untitled').toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'status') {
                      _changeStatus(record);
                    } else if (value == 'copy') {
                      _copyRecord(record);
                    } else if (value == 'delete') {
                      _deleteRecord(record);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return const <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'status',
                        child: Text('Change status'),
                      ),
                      PopupMenuItem<String>(
                        value: 'copy',
                        child: Text('Copy JSON'),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ];
                  },
                ),
              ],
            ),
            if ((record['description'] ?? '').toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  (record['description'] ?? '').toString(),
                ),
              ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                Chip(label: Text(status)),
                Chip(
                  avatar: Icon(
                    Icons.flag,
                    size: 16,
                    color: _priorityColor(priority),
                  ),
                  label: Text(priority),
                ),
                if (overdue)
                  const Chip(
                    avatar: Icon(Icons.warning, size: 16),
                    label: Text('Overdue'),
                  ),
              ],
            ),
            const Divider(),
            Text(
              'Responsible: '
              '${(record['assignedTo'] ?? 'Unassigned').toString()}',
            ),
            if ((record['dueDate'] ?? '').toString().isNotEmpty)
              Text(
                'Due: ${(record['dueDate'] ?? '').toString()}',
              ),
            Text(
              'Module: ${(record['module'] ?? '').toString()}',
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _changeStatus(record),
                icon: const Icon(Icons.sync),
                label: const Text('Update Status'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visible = _visibleRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 155 — HSE Management Control'),
        actions: <Widget>[
          IconButton(
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addRecord,
        icon: const Icon(Icons.add_task),
        label: const Text('Add'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Text(
                    'HSE Management Control',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSummary(),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search HSE records',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: _searchController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 42,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <String>[
                        'All',
                        ..._statuses,
                      ].map((String status) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(status),
                            selected: _statusFilter == status,
                            onSelected: (_) {
                              setState(() {
                                _statusFilter = status;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (visible.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(28),
                        child: Center(
                          child: Text('No records found'),
                        ),
                      ),
                    )
                  else
                    ...visible.map(_buildRecordCard),
                  const SizedBox(height: 90),
                ],
              ),
            ),
    );
  }
}
