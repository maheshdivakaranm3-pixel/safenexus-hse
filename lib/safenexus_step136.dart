import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 136
/// HSE Action Prioritisation
///
/// Minimum-change extension of the locked HSE Action store.
/// Shared store: workhub_hse_actions_v1
///
/// This module does not modify the existing 117–135 data model.
/// Existing fields are preserved and Step 136 fields are additive.

class SafeNexusStep136Page extends StatefulWidget {
  const SafeNexusStep136Page({super.key});

  @override
  State<SafeNexusStep136Page> createState() =>
      _SafeNexusStep136PageState();
}

class _SafeNexusStep136PageState
    extends State<SafeNexusStep136Page> {
  static const String _storeKey = 'workhub_hse_actions_v1';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _actions = <Map<String, dynamic>>[];
  bool _loading = true;
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    final loaded = <Map<String, dynamic>>[];

    if (raw != null && raw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          loaded.addAll(
            decoded
                .whereType<Map>()
                .map((item) => Map<String, dynamic>.from(item)),
          );
        }
      } catch (_) {}
    }

    if (!mounted) return;

    setState(() {
      _actions = loaded;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storeKey, jsonEncode(_actions));
  }

  String _value(
    Map<String, dynamic> item,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = item[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return '';
  }

  String _id(Map<String, dynamic> item) =>
      _value(item, <String>['id', 'actionId']);

  String _title(Map<String, dynamic> item) =>
      _value(item, <String>['title', 'actionTitle', 'description']);

  String _status(Map<String, dynamic> item) {
    final value = _value(item, <String>['status']);
    return value.isEmpty ? 'Open' : value;
  }

  String _priority(Map<String, dynamic> item) {
    final value = _value(item, <String>['priority']);
    return value.isEmpty ? 'Medium' : value;
  }

  String _owner(Map<String, dynamic> item) =>
      _value(item, <String>['assignedTo', 'owner', 'responsiblePerson']);

  bool _isOverdue(Map<String, dynamic> item) {
    if (_status(item).toLowerCase() == 'closed') return false;

    final raw = _value(item, <String>['dueDate', 'targetDate']);
    final due = DateTime.tryParse(raw);
    if (due == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(due.year, due.month, due.day);

    return target.isBefore(today);
  }

  List<Map<String, dynamic>> get _visible {
    final query = _searchController.text.trim().toLowerCase();

    return _actions.where((item) {
      if (_filter == 'Overdue' && !_isOverdue(item)) return false;
      if (_filter != 'All' &&
          _filter != 'Overdue' &&
          _status(item) != _filter) {
        return false;
      }

      if (query.isEmpty) return true;

      return jsonEncode(item).toLowerCase().contains(query);
    }).toList();
  }

  int _count(String status) =>
      _actions.where((item) => _status(item) == status).length;

  int get _overdueCount =>
      _actions.where(_isOverdue).length;

  Future<void> _addControlRecord() async {
    final titleController = TextEditingController();
    final notesController = TextEditingController();
    final ownerController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add HSE Control Record'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Action / control title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: notesController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Details / remarks',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: ownerController,
                  decoration: const InputDecoration(
                    labelText: 'Responsible person',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) return;

                Navigator.pop(
                  context,
                  <String, String>{
                    'title': titleController.text.trim(),
                    'notes': notesController.text.trim(),
                    'owner': ownerController.text.trim(),
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    titleController.dispose();
    notesController.dispose();
    ownerController.dispose();

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    final record = <String, dynamic>{
      'id': 'ACT-136-${DateTime.now().millisecondsSinceEpoch}',
      'title': result['title'],
      'description': result['notes'],
      'assignedTo': result['owner'],
      'status': 'Open',
      'priority': 'Medium',
      'createdAt': now,
      'updatedAt': now,
      'step': 136,
      'module': 'HSE Action Prioritisation',
      'source': 'SafeNexus HSE Step 136',
    };

    setState(() {
      _actions.add(record);
    });

    await _save();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('HSE control record saved.')),
    );
  }

  Future<void> _changeStatus(
    Map<String, dynamic> item,
  ) async {
    const statuses = <String>[
      'Open',
      'In Progress',
      'Pending Verification',
      'Closed',
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Action Status'),
          children: statuses
              .map(
                (status) => ListTile(
                  title: Text(status),
                  onTap: () => Navigator.pop(context, status),
                ),
              )
              .toList(),
        );
      },
    );

    if (selected == null) return;

    final index = _actions.indexWhere(
      (record) => _id(record) == _id(item),
    );

    if (index < 0) return;

    final now = DateTime.now().toIso8601String();

    setState(() {
      _actions[index]['status'] = selected;
      _actions[index]['updatedAt'] = now;

      if (selected == 'Closed') {
        _actions[index]['closedAt'] = now;
        _actions[index]['closureVerified'] = true;
      }
    });

    await _save();
  }

  Future<void> _copyRecord(
    Map<String, dynamic> item,
  ) async {
    final text = const JsonEncoder.withIndent('  ').convert(item);
    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record copied.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Step 136 — HSE Action Prioritisation',
        ),
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            onPressed: _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: _addControlRecord,
        icon: const Icon(Icons.add_task),
        label: const Text('Add Record'),
      ),
      body: Column(
        children: <Widget>[
          _summary(),
          _filters(),
          Expanded(
            child: _visible.isEmpty
                ? _empty()
                : _list(),
          ),
        ],
      ),
    );
  }

  Widget _summary() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          _metric('Total', _actions.length),
          _metric('Open', _count('Open')),
          _metric('In Progress', _count('In Progress')),
          _metric('Closed', _count('Closed')),
          _metric('Overdue', _overdueCount),
        ],
      ),
    );
  }

  Widget _metric(
    String label,
    int value,
  ) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search HSE actions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: _filter,
            items: const <String>[
              'All',
              'Open',
              'In Progress',
              'Pending Verification',
              'Closed',
              'Overdue',
            ]
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                _filter = value ?? 'All';
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
      itemCount: _visible.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = _visible[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFEAF6EF),
              child: Icon(
                _isOverdue(item)
                    ? Icons.warning_amber_outlined
                    : Icons.task_alt_outlined,
                color: _isOverdue(item)
                    ? Colors.red
                    : primaryGreen,
              ),
            ),
            title: Text(
              _title(item).isEmpty
                  ? 'HSE Action'
                  : _title(item),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: Text(
              '${_status(item)} • ${_priority(item)}\n'
              'Responsible: ${_owner(item).isEmpty ? 'Not assigned' : _owner(item)}',
            ),
            isThreeLine: true,
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'status') {
                  _changeStatus(item);
                } else if (value == 'copy') {
                  _copyRecord(item);
                }
              },
              itemBuilder: (_) => const <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'status',
                  child: Text('Change Status'),
                ),
                PopupMenuItem<String>(
                  value: 'copy',
                  child: Text('Copy Record'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _empty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.fact_check_outlined,
            size: 56,
            color: primaryGreen,
          ),
          SizedBox(height: 10),
          Text(
            'No HSE records found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text('Add a control record to begin.'),
        ],
      ),
    );
  }
}
