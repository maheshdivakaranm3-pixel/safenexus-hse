import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 129
/// HSE Action Evidence
///
/// Minimum-change module for the locked 117–125 baseline.
/// Shared action store: workhub_hse_actions_v1
///
/// Step 129 focus:
/// HSE Action Evidence

class SafeNexusStep129Page extends StatefulWidget {
  const SafeNexusStep129Page({super.key});

  @override
  State<SafeNexusStep129Page> createState() => _SafeNexusStep129PageState();
}

class _SafeNexusStep129PageState extends State<SafeNexusStep129Page> {
  static const String _storeKey = 'workhub_hse_actions_v1';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final TextEditingController _search = TextEditingController();
  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  bool _loading = true;
  String _filter = 'All';

  @override
  void initState() {
    super.initState();
    _load();
    _search.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storeKey);
    final List<Map<String, dynamic>> result = <Map<String, dynamic>>[];

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          result.addAll(
            decoded
                .whereType<Map>()
                .map((e) => Map<String, dynamic>.from(e)),
          );
        }
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() {
      _records = result;
      _loading = false;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storeKey, jsonEncode(_records));
  }

  String _value(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return '';
  }

  String _status(Map<String, dynamic> item) {
    final value = _value(item, <String>['status']);
    return value.isEmpty ? 'Open' : value;
  }

  String _priority(Map<String, dynamic> item) {
    final value = _value(item, <String>['priority']);
    return value.isEmpty ? 'Medium' : value;
  }

  String _title(Map<String, dynamic> item) {
    final value = _value(
      item,
      <String>['title', 'actionTitle', 'description'],
    );
    return value.isEmpty ? 'HSE Action' : value;
  }

  String _id(Map<String, dynamic> item) {
    return _value(item, <String>['id', 'actionId']);
  }

  List<Map<String, dynamic>> get _visible {
    final query = _search.text.trim().toLowerCase();

    return _records.where((item) {
      if (_filter != 'All' && _status(item) != _filter) {
        return false;
      }

      if (query.isEmpty) return true;
      return jsonEncode(item).toLowerCase().contains(query);
    }).toList();
  }

  int _count(String status) {
    return _records.where((item) => _status(item) == status).length;
  }

  Future<void> _addRecord() async {
    final title = TextEditingController();
    final description = TextEditingController();
    final owner = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add HSE Action'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: 'Action title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Details / requirement',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: owner,
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
                if (title.text.trim().isEmpty) return;
                Navigator.pop(
                  context,
                  <String, String>{
                    'title': title.text.trim(),
                    'description': description.text.trim(),
                    'owner': owner.text.trim(),
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    title.dispose();
    description.dispose();
    owner.dispose();

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    final record = <String, dynamic>{
      'id': 'ACT-129-${DateTime.now().millisecondsSinceEpoch}',
      'title': result['title'],
      'description': result['description'],
      'assignedTo': result['owner'],
      'status': 'Open',
      'priority': 'Medium',
      'createdAt': now,
      'updatedAt': now,
      'step': 129,
      'module': 'HSE Action Evidence',
      'source': 'SafeNexus HSE Step 129',
    };

    setState(() => _records.add(record));
    await _save();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('HSE action saved.')),
    );
  }

  Future<void> _changeStatus(Map<String, dynamic> item) async {
    const states = <String>[
      'Open',
      'In Progress',
      'Pending Verification',
      'Closed',
    ];

    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Change Status'),
        children: states
            .map(
              (state) => ListTile(
                title: Text(state),
                onTap: () => Navigator.pop(context, state),
              ),
            )
            .toList(),
      ),
    );

    if (selected == null) return;

    final index = _records.indexWhere((record) => _id(record) == _id(item));
    if (index < 0) return;

    final now = DateTime.now().toIso8601String();

    setState(() {
      _records[index]['status'] = selected;
      _records[index]['updatedAt'] = now;

      if (selected == 'Closed') {
        _records[index]['closedAt'] = now;
        _records[index]['closureVerified'] = true;
      }
    });

    await _save();
  }

  Future<void> _copyRecord(Map<String, dynamic> item) async {
    final text = const JsonEncoder.withIndent('  ').convert(item);
    await Clipboard.setData(ClipboardData(text: text));

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Action record copied.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text('Step 129 — HSE Action Evidence'),
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
        onPressed: _addRecord,
        icon: const Icon(Icons.add_task),
        label: const Text('Add Action'),
      ),
      body: Column(
        children: <Widget>[
          _summary(),
          _filters(),
          Expanded(
            child: _visible.isEmpty ? _empty() : _list(),
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
          _metric('Total', _records.length),
          _metric('Open', _count('Open')),
          _metric('In Progress', _count('In Progress')),
          _metric('Closed', _count('Closed')),
        ],
      ),
    );
  }

  Widget _metric(String label, int value) {
    return Container(
      width: 135,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F8F7),
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
          Text(label, style: const TextStyle(fontSize: 11)),
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
              controller: _search,
              decoration: const InputDecoration(
                hintText: 'Search actions...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
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
            ]
                .map(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() => _filter = value ?? 'All');
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
            leading: const CircleAvatar(
              backgroundColor: Color(0xFFEAF6EF),
              child: Icon(Icons.task_alt, color: primaryGreen),
            ),
            title: Text(
              _title(item),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              '${_status(item)} • ${_priority(item)}\n'
              '${_value(item, <String>['assignedTo', 'owner'])}',
            ),
            isThreeLine: true,
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'status') _changeStatus(item);
                if (value == 'copy') _copyRecord(item);
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
            Icons.task_alt_outlined,
            size: 56,
            color: primaryGreen,
          ),
          SizedBox(height: 10),
          Text(
            'No HSE action records',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text('Add an action to begin.'),
        ],
      ),
    );
  }
}
