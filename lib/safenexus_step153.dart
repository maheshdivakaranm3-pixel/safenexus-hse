
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep153Page extends StatefulWidget {{
  const SafeNexusStep153Page({{super.key}});

  @override
  State<SafeNexusStep153Page> createState() => _SafeNexusStep153PageState();
}}

class _SafeNexusStep153PageState extends State<SafeNexusStep153Page> {{
  static const String _storageKey = 'workhub_hse_actions_v1';
  static const String _stepPurpose = 'Track risk-related actions and verification.';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _statusFilter = 'All';
  bool _loading = true;

  static const List<String> _statuses = <String>[
    'Open',
    'In Progress',
    'Pending Verification',
    'Closed',
  ];

  @override
  void initState() {{
    super.initState();
    _loadRecords();
    _searchController.addListener(() {{
      if (mounted) setState(() {{}});
    }});
  }}

  @override
  void dispose() {{
    _searchController.dispose();
    super.dispose();
  }}

  Future<void> _loadRecords() async {{
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {{
      try {{
        final decoded = jsonDecode(raw);
        if (decoded is List) {{
          _records = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        }}
      }} catch (_) {{
        _records = [];
      }}
    }}

    if (mounted) {{
      setState(() => _loading = false);
    }}
  }}

  Future<void> _saveRecords() async {{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }}

  List<Map<String, dynamic>> get _visibleRecords {{
    final q = _searchController.text.trim().toLowerCase();

    return _records.where((record) {{
      final status = (record['status'] ?? 'Open').toString();
      final haystack = [
        record['title'],
        record['description'],
        record['assignedTo'],
        record['module'],
        record['source'],
        record['priority'],
      ].map((e) => e.toString().toLowerCase()).join(' ');

      final matchesSearch = q.isEmpty || haystack.contains(q);
      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;

      return matchesSearch && matchesStatus;
    }}).toList();
  }}

  int _count(String status) {{
    return _records
        .where((r) => (r['status'] ?? 'Open').toString() == status)
        .length;
  }}

  bool _isOverdue(Map<String, dynamic> record) {{
    final due = DateTime.tryParse((record['dueDate'] ?? '').toString());
    if (due == null) return false;
    return due.isBefore(DateTime.now()) &&
        (record['status'] ?? 'Open') != 'Closed';
  }}

  Future<void> _addRecord() async {{
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final assignedController = TextEditingController();
    final dueController = TextEditingController();

    String priority = 'Medium';

    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {{
        return StatefulBuilder(
          builder: (context, setDialogState) {{
            return AlertDialog(
              title: const Text('Add HSE Follow-up'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                        labelText: 'Details / Requirement',
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
                      controller: dueController,
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
                      items: const ['Low', 'Medium', 'High', 'Critical']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {{
                        if (value != null) {{
                          setDialogState(() => priority = value);
                        }}
                      }},
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: const Text('Save'),
                ),
              ],
            );
          }},
        );
      }},
    );

    if (created != true || titleController.text.trim().isEmpty) {{
      titleController.dispose();
      descriptionController.dispose();
      assignedController.dispose();
      dueController.dispose();
      return;
    }}

    final now = DateTime.now().toIso8601String();

    _records.insert(0, {{
      'id': 'SN-153-${{DateTime.now().millisecondsSinceEpoch}}',
      'title': titleController.text.trim(),
      'description': descriptionController.text.trim(),
      'assignedTo': assignedController.text.trim().isEmpty
          ? 'Unassigned'
          : assignedController.text.trim(),
      'status': 'Open',
      'priority': priority,
      'dueDate': dueController.text.trim(),
      'createdAt': now,
      'updatedAt': now,
      'step': 153,
      'module': 'HSE Risk Follow-up',
      'source': 'SafeNexus HSE',
    }});

    await _saveRecords();

    titleController.dispose();
    descriptionController.dispose();
    assignedController.dispose();
    dueController.dispose();

    if (mounted) setState(() {{}});
  }}

  Future<void> _changeStatus(Map<String, dynamic> record) async {{
    final current = (record['status'] ?? 'Open').toString();

    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Change Status'),
        children: _statuses
            .map(
              (status) => SimpleDialogOption(
                onPressed: () => Navigator.pop(context, status),
                child: Row(
                  children: [
                    if (status == current)
                      const Icon(Icons.check, size: 18),
                    if (status == current) const SizedBox(width: 8),
                    Text(status),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );

    if (selected == null) return;

    record['status'] = selected;
    record['updatedAt'] = DateTime.now().toIso8601String();

    if (selected == 'Closed') {{
      record['verifiedAt'] = DateTime.now().toIso8601String();
      record['closureNote'] = 'Closed through SafeNexus HSE';
    }}

    await _saveRecords();
    if (mounted) setState(() {{}});
  }}

  Future<void> _copyRecord(Map<String, dynamic> record) async {{
    await Clipboard.setData(
      ClipboardData(text: const JsonEncoder.withIndent('  ').convert(record)),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record copied')),
    );
  }}

  Future<void> _deleteRecord(Map<String, dynamic> record) async {{
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete record?'),
        content: Text(record['title'].toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok != true) return;

    _records.remove(record);
    await _saveRecords();
    if (mounted) setState(() {{}});
  }}

  Color _priorityColor(String priority) {{
    switch (priority) {{
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.orange;
    }}
  }}

  @override
  Widget build(BuildContext context) {{
    final visible = _visibleRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 153 — HSE Risk Follow-up'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
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
                children: [
                  _buildSummary(),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search HSE follow-up records',
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
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        'All',
                        ..._statuses,
                      ].map((status) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(status),
                            selected: _statusFilter == status,
                            onSelected: (_) {
                              setState(() => _statusFilter = status);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (visible.isEmpty)
                    _buildEmpty()
                  else
                    ...visible.map(_buildRecordCard),
                  const SizedBox(height: 90),
                ],
              ),
            ),
    );
  }}

  Widget _buildSummary() {{
    final overdue = _records.where(_isOverdue).length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _metric('Total', _records.length, Icons.list_alt),
            _metric('Open', _count('Open'), Icons.radio_button_unchecked),
            _metric(
              'Progress',
              _count('In Progress'),
              Icons.timelapse,
            ),
            _metric(
              'Verification',
              _count('Pending Verification'),
              Icons.fact_check,
            ),
            _metric('Closed', _count('Closed'), Icons.check_circle),
            _metric('Overdue', overdue, Icons.warning),
          ],
        ),
      ),
    );
  }}

  Widget _metric(String label, int value, IconData icon) {{
    return Container(
      width: 105,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 4),
          Text(
            '$value',
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
    );
  }}

  Widget _buildEmpty() {{
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Icon(Icons.assignment_turned_in_outlined, size: 52),
            const SizedBox(height: 12),
            const Text(
              'No records found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Add a follow-up record for HSE Risk Follow-up.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }}

  Widget _buildRecordCard(Map<String, dynamic> record) {{
    final status = (record['status'] ?? 'Open').toString();
    final priority = (record['priority'] ?? 'Medium').toString();
    final overdue = _isOverdue(record);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  onSelected: (value) {{
                    if (value == 'status') _changeStatus(record);
                    if (value == 'copy') _copyRecord(record);
                    if (value == 'delete') _deleteRecord(record);
                  }},
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'status',
                      child: Text('Change status'),
                    ),
                    PopupMenuItem(
                      value: 'copy',
                      child: Text('Copy JSON'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            if ((record['description'] ?? '').toString().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(record['description'].toString()),
            ],
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
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
              'Responsible: ${(record['assignedTo'] ?? 'Unassigned').toString()}',
            ),
            if ((record['dueDate'] ?? '').toString().isNotEmpty)
              Text('Due: ${record['dueDate']}'),
            Text('Source: ${(record['source'] ?? 'SafeNexus HSE').toString()}'),
            const SizedBox(height: 10),
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
  }}
}}
