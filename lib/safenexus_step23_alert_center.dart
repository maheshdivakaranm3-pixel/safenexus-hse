import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 23
/// HSE Notification & Alert Center
///
/// Purpose:
/// - Central local HSE alert register.
/// - Expiry, overdue, critical-risk and due-date alerts.
/// - Alert search/filtering.
/// - Read/unread and priority handling.
/// - Opens the originating module/record through callbacks.
/// - Safe SharedPreferences persistence.
/// - Does not modify existing Phase 1-16 or Step 17-22 files.
///
/// This module is intentionally event-driven. Existing modules can create
/// alerts by calling SafeNexusAlertCenter.createAlert(...) or by registering
/// records with SafeNexusAlertRuleEngine.

enum SafeNexusAlertPriority {
  low,
  medium,
  high,
  critical,
}

enum SafeNexusAlertType {
  expiry,
  overdue,
  criticalRisk,
  permit,
  training,
  medical,
  equipment,
  legal,
  emergency,
  environment,
  incident,
  action,
  report,
  general,
}

class SafeNexusAlert {
  final String id;
  final String sourceId;
  final String phase;
  final String module;
  final String recordId;
  final String title;
  final String message;
  final SafeNexusAlertType type;
  final SafeNexusAlertPriority priority;
  final DateTime createdAt;
  final DateTime? dueDate;
  final DateTime? expiryDate;
  final bool read;
  final bool resolved;
  final String project;
  final String site;
  final Map<String, dynamic> metadata;

  const SafeNexusAlert({
    required this.id,
    required this.sourceId,
    required this.phase,
    required this.module,
    required this.recordId,
    required this.title,
    required this.message,
    required this.type,
    required this.priority,
    required this.createdAt,
    required this.dueDate,
    required this.expiryDate,
    required this.read,
    required this.resolved,
    required this.project,
    required this.site,
    required this.metadata,
  });

  SafeNexusAlert copyWith({
    bool? read,
    bool? resolved,
  }) {
    return SafeNexusAlert(
      id: id,
      sourceId: sourceId,
      phase: phase,
      module: module,
      recordId: recordId,
      title: title,
      message: message,
      type: type,
      priority: priority,
      createdAt: createdAt,
      dueDate: dueDate,
      expiryDate: expiryDate,
      read: read ?? this.read,
      resolved: resolved ?? this.resolved,
      project: project,
      site: site,
      metadata: metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceId': sourceId,
      'phase': phase,
      'module': module,
      'recordId': recordId,
      'title': title,
      'message': message,
      'type': type.name,
      'priority': priority.name,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'read': read,
      'resolved': resolved,
      'project': project,
      'site': site,
      'metadata': metadata,
    };
  }

  factory SafeNexusAlert.fromJson(Map<String, dynamic> json) {
    return SafeNexusAlert(
      id: _stringValue(json['id']),
      sourceId: _stringValue(json['sourceId']),
      phase: _stringValue(json['phase']),
      module: _stringValue(json['module']),
      recordId: _stringValue(json['recordId']),
      title: _stringValue(json['title']),
      message: _stringValue(json['message']),
      type: _alertType(json['type']),
      priority: _priority(json['priority']),
      createdAt:
          DateTime.tryParse(_stringValue(json['createdAt'])) ??
          DateTime.now(),
      dueDate: _dateValue(json['dueDate']),
      expiryDate: _dateValue(json['expiryDate']),
      read: json['read'] == true,
      resolved: json['resolved'] == true,
      project: _stringValue(json['project']),
      site: _stringValue(json['site']),
      metadata: json['metadata'] is Map
          ? Map<String, dynamic>.from(json['metadata'] as Map)
          : <String, dynamic>{},
    );
  }

  bool get isOverdue {
    final date = dueDate;
    if (date == null || resolved) return false;

    return _dayOnly(date).isBefore(_dayOnly(DateTime.now()));
  }

  bool get isExpiringSoon {
    final date = expiryDate;
    if (date == null || resolved) return false;

    final today = _dayOnly(DateTime.now());
    final expiry = _dayOnly(date);
    final difference = expiry.difference(today).inDays;

    return difference >= 0 && difference <= 30;
  }

  bool get isCritical {
    return priority == SafeNexusAlertPriority.critical;
  }

  static DateTime _dayOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  static String _stringValue(dynamic value) {
    return value?.toString().trim() ?? '';
  }

  static DateTime? _dateValue(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static SafeNexusAlertType _alertType(dynamic value) {
    return SafeNexusAlertType.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusAlertType.general,
    );
  }

  static SafeNexusAlertPriority _priority(dynamic value) {
    return SafeNexusAlertPriority.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusAlertPriority.medium,
    );
  }
}

typedef SafeNexusAlertOpener = Future<void> Function(
  BuildContext context,
  SafeNexusAlert alert,
);

class SafeNexusAlertCenter {
  static const String storageKey =
      'safenexus_hse_step23_alert_center';

  static Future<List<SafeNexusAlert>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getStringList(storageKey) ?? <String>[];
    final alerts = <SafeNexusAlert>[];

    for (final value in values) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          alerts.add(
            SafeNexusAlert.fromJson(
              Map<String, dynamic>.from(decoded),
            ),
          );
        }
      } catch (_) {
        // Ignore one malformed alert and continue loading others.
      }
    }

    alerts.sort(
      (a, b) => b.createdAt.compareTo(a.createdAt),
    );

    return alerts;
  }

  static Future<void> save(
    List<SafeNexusAlert> alerts,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final values = alerts
        .map((alert) => jsonEncode(alert.toJson()))
        .toList();

    await prefs.setStringList(storageKey, values);
  }

  static Future<void> createAlert({
    required String id,
    required String sourceId,
    required String phase,
    required String module,
    required String recordId,
    required String title,
    required String message,
    required SafeNexusAlertType type,
    SafeNexusAlertPriority priority =
        SafeNexusAlertPriority.medium,
    DateTime? dueDate,
    DateTime? expiryDate,
    String project = '',
    String site = '',
    Map<String, dynamic> metadata =
        const <String, dynamic>{},
  }) async {
    final alerts = await load();

    final existingIndex =
        alerts.indexWhere((alert) => alert.id == id);

    final alert = SafeNexusAlert(
      id: id,
      sourceId: sourceId,
      phase: phase,
      module: module,
      recordId: recordId,
      title: title,
      message: message,
      type: type,
      priority: priority,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      expiryDate: expiryDate,
      read: false,
      resolved: false,
      project: project,
      site: site,
      metadata: metadata,
    );

    if (existingIndex >= 0) {
      alerts[existingIndex] = alert;
    } else {
      alerts.add(alert);
    }

    await save(alerts);
  }

  static Future<void> markRead(String id) async {
    final alerts = await load();
    final index = alerts.indexWhere(
      (alert) => alert.id == id,
    );

    if (index < 0) return;

    alerts[index] = alerts[index].copyWith(read: true);
    await save(alerts);
  }

  static Future<void> markUnread(String id) async {
    final alerts = await load();
    final index = alerts.indexWhere(
      (alert) => alert.id == id,
    );

    if (index < 0) return;

    alerts[index] = alerts[index].copyWith(read: false);
    await save(alerts);
  }

  static Future<void> resolve(String id) async {
    final alerts = await load();
    final index = alerts.indexWhere(
      (alert) => alert.id == id,
    );

    if (index < 0) return;

    alerts[index] = alerts[index].copyWith(
      read: true,
      resolved: true,
    );

    await save(alerts);
  }

  static Future<void> delete(String id) async {
    final alerts = await load();
    alerts.removeWhere((alert) => alert.id == id);
    await save(alerts);
  }

  static Future<void> clearResolved() async {
    final alerts = await load();
    alerts.removeWhere((alert) => alert.resolved);
    await save(alerts);
  }

  static Future<void> seedDemoAlerts() async {
    final existing = await load();
    if (existing.isNotEmpty) return;

    final today = DateTime.now();

    await save([
      SafeNexusAlert(
        id: 'step23-demo-critical-risk',
        sourceId: 'phase3',
        phase: 'Phase 3',
        module: 'Risk & Planning',
        recordId: 'RISK-DEMO-001',
        title: 'Critical risk requires review',
        message:
            'A critical risk record requires HSE review and control verification.',
        type: SafeNexusAlertType.criticalRisk,
        priority: SafeNexusAlertPriority.critical,
        createdAt: today,
        dueDate: today,
        expiryDate: null,
        read: false,
        resolved: false,
        project: 'Demo Project',
        site: 'Demo Site',
        metadata: const <String, dynamic>{},
      ),
      SafeNexusAlert(
        id: 'step23-demo-training',
        sourceId: 'phase6',
        phase: 'Phase 6',
        module: 'Workforce & Competency',
        recordId: 'TRN-DEMO-001',
        title: 'Training certificate expiring',
        message:
            'A worker training certificate is within the 30-day expiry window.',
        type: SafeNexusAlertType.training,
        priority: SafeNexusAlertPriority.high,
        createdAt: today,
        dueDate: today.add(const Duration(days: 15)),
        expiryDate: today.add(const Duration(days: 15)),
        read: false,
        resolved: false,
        project: 'Demo Project',
        site: 'Demo Site',
        metadata: const <String, dynamic>{},
      ),
      SafeNexusAlert(
        id: 'step23-demo-ptw',
        sourceId: 'phase4',
        phase: 'Phase 4',
        module: 'Permit to Work',
        recordId: 'PTW-DEMO-001',
        title: 'Permit review due',
        message:
            'Permit validity requires review before work continues.',
        type: SafeNexusAlertType.permit,
        priority: SafeNexusAlertPriority.high,
        createdAt: today,
        dueDate: today.add(const Duration(days: 1)),
        expiryDate: today.add(const Duration(days: 1)),
        read: false,
        resolved: false,
        project: 'Demo Project',
        site: 'Demo Site',
        metadata: const <String, dynamic>{},
      ),
    ]);
  }
}

class SafeNexusAlertRuleEngine {
  /// Creates an alert when a record is due within [days].
  static Future<void> createExpiryAlert({
    required String id,
    required String sourceId,
    required String phase,
    required String module,
    required String recordId,
    required String title,
    required DateTime expiryDate,
    int days = 30,
    SafeNexusAlertPriority priority =
        SafeNexusAlertPriority.high,
    SafeNexusAlertType type = SafeNexusAlertType.expiry,
    String project = '',
    String site = '',
  }) async {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final expiry = DateTime(
      expiryDate.year,
      expiryDate.month,
      expiryDate.day,
    );

    final difference = expiry.difference(today).inDays;

    if (difference < 0) {
      await SafeNexusAlertCenter.createAlert(
        id: id,
        sourceId: sourceId,
        phase: phase,
        module: module,
        recordId: recordId,
        title: title,
        message: 'Expiry date has passed.',
        type: SafeNexusAlertType.overdue,
        priority: SafeNexusAlertPriority.critical,
        dueDate: expiryDate,
        expiryDate: expiryDate,
        project: project,
        site: site,
      );
      return;
    }

    if (difference <= days) {
      await SafeNexusAlertCenter.createAlert(
        id: id,
        sourceId: sourceId,
        phase: phase,
        module: module,
        recordId: recordId,
        title: title,
        message:
            'Expiry is within the configured alert window.',
        type: type,
        priority: priority,
        dueDate: expiryDate,
        expiryDate: expiryDate,
        project: project,
        site: site,
      );
    }
  }

  static Future<void> createOverdueAlert({
    required String id,
    required String sourceId,
    required String phase,
    required String module,
    required String recordId,
    required String title,
    required DateTime dueDate,
    SafeNexusAlertPriority priority =
        SafeNexusAlertPriority.high,
    SafeNexusAlertType type = SafeNexusAlertType.overdue,
    String project = '',
    String site = '',
  }) async {
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    final due = DateTime(
      dueDate.year,
      dueDate.month,
      dueDate.day,
    );

    if (!due.isBefore(today)) return;

    await SafeNexusAlertCenter.createAlert(
      id: id,
      sourceId: sourceId,
      phase: phase,
      module: module,
      recordId: recordId,
      title: title,
      message: 'Required action is overdue.',
      type: type,
      priority: priority,
      dueDate: dueDate,
      project: project,
      site: site,
    );
  }

  static Future<void> createCriticalRiskAlert({
    required String id,
    required String sourceId,
    required String phase,
    required String module,
    required String recordId,
    required String title,
    required String message,
    String project = '',
    String site = '',
  }) async {
    await SafeNexusAlertCenter.createAlert(
      id: id,
      sourceId: sourceId,
      phase: phase,
      module: module,
      recordId: recordId,
      title: title,
      message: message,
      type: SafeNexusAlertType.criticalRisk,
      priority: SafeNexusAlertPriority.critical,
      project: project,
      site: site,
    );
  }
}

class SafeNexusStep23AlertCenter extends StatefulWidget {
  final SafeNexusAlertOpener? opener;

  const SafeNexusStep23AlertCenter({
    super.key,
    this.opener,
  });

  @override
  State<SafeNexusStep23AlertCenter> createState() =>
      _SafeNexusStep23AlertCenterState();
}

class _SafeNexusStep23AlertCenterState
    extends State<SafeNexusStep23AlertCenter> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController =
      TextEditingController();

  List<SafeNexusAlert> _alerts = <SafeNexusAlert>[];
  String _query = '';
  String _type = 'All';
  String _priority = 'All';
  String _status = 'Active';

  bool _loading = true;

  List<SafeNexusAlert> get _filtered {
    final query = _query.trim().toLowerCase();

    return _alerts.where((alert) {
      final searchable = [
        alert.id,
        alert.phase,
        alert.module,
        alert.recordId,
        alert.title,
        alert.message,
        alert.project,
        alert.site,
        alert.type.name,
        alert.priority.name,
      ].join(' ').toLowerCase();

      final queryMatch =
          query.isEmpty || searchable.contains(query);

      final typeMatch =
          _type == 'All' || alert.type.name == _type;

      final priorityMatch =
          _priority == 'All' ||
          alert.priority.name == _priority;

      final statusMatch = _status == 'All' ||
          (_status == 'Active' && !alert.resolved) ||
          (_status == 'Resolved' && alert.resolved) ||
          (_status == 'Unread' && !alert.read && !alert.resolved);

      return queryMatch &&
          typeMatch &&
          priorityMatch &&
          statusMatch;
    }).toList();
  }

  int get _unreadCount =>
      _alerts.where((alert) => !alert.read && !alert.resolved).length;

  int get _overdueCount =>
      _alerts.where((alert) => alert.isOverdue).length;

  int get _criticalCount =>
      _alerts.where((alert) => alert.isCritical && !alert.resolved).length;

  int get _expiryCount =>
      _alerts.where((alert) => alert.isExpiringSoon).length;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _load();
  }

  void _onSearch() {
    final value = _searchController.text;
    if (value != _query) {
      setState(() => _query = value);
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);

    final alerts = await SafeNexusAlertCenter.load();

    if (!mounted) return;

    setState(() {
      _alerts = alerts;
      _loading = false;
    });
  }

  Future<void> _markRead(SafeNexusAlert alert) async {
    await SafeNexusAlertCenter.markRead(alert.id);
    await _load();
  }

  Future<void> _resolve(SafeNexusAlert alert) async {
    await SafeNexusAlertCenter.resolve(alert.id);
    await _load();
  }

  Future<void> _delete(SafeNexusAlert alert) async {
    await SafeNexusAlertCenter.delete(alert.id);
    await _load();
  }

  Future<void> _clearResolved() async {
    await SafeNexusAlertCenter.clearResolved();
    await _load();
  }

  Future<void> _openAlert(SafeNexusAlert alert) async {
    if (!alert.read) {
      await SafeNexusAlertCenter.markRead(alert.id);
      await _load();
    }

    if (!mounted) return;

    final opener = widget.opener;

    if (opener != null) {
      await opener(context, alert);
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _AlertDetailsPage(alert: alert),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alerts = _filtered;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'HSE Alert Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _load,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clearResolved') {
                _clearResolved();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem<String>(
                value: 'clearResolved',
                child: Text('Clear resolved alerts'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _searchHeader(),
          _filterBar(),
          _summary(),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : alerts.isEmpty
                    ? _empty()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          12,
                          4,
                          12,
                          20,
                        ),
                        itemCount: alerts.length,
                        itemBuilder: (_, index) {
                          return _alertCard(alerts[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _searchHeader() {
    return Container(
      color: darkGreen,
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search HSE alerts...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.clear),
                ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return SizedBox(
      height: 54,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _popupFilter(
            'Type',
            _type,
            [
              'All',
              ...SafeNexusAlertType.values.map(
                (item) => item.name,
              ),
            ],
            (value) {
              setState(() => _type = value);
            },
          ),
          _popupFilter(
            'Priority',
            _priority,
            [
              'All',
              ...SafeNexusAlertPriority.values.map(
                (item) => item.name,
              ),
            ],
            (value) {
              setState(() => _priority = value);
            },
          ),
          _popupFilter(
            'Status',
            _status,
            const [
              'All',
              'Active',
              'Unread',
              'Resolved',
            ],
            (value) {
              setState(() => _status = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _popupFilter(
    String label,
    String selected,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        onSelected: onChanged,
        itemBuilder: (_) => values
            .map(
              (value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        child: Chip(
          avatar: const Icon(
            Icons.filter_list,
            size: 17,
          ),
          label: Text('$label: $selected'),
        ),
      ),
    );
  }

  Widget _summary() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        12,
        3,
        12,
        8,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryItem(
              '$_unreadCount',
              'Unread',
              Icons.mark_email_unread,
            ),
          ),
          Expanded(
            child: _summaryItem(
              '$_overdueCount',
              'Overdue',
              Icons.warning,
            ),
          ),
          Expanded(
            child: _summaryItem(
              '$_criticalCount',
              'Critical',
              Icons.priority_high,
            ),
          ),
          Expanded(
            child: _summaryItem(
              '$_expiryCount',
              'Expiring',
              Icons.schedule,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
    String value,
    String label,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: primaryGreen,
          size: 20,
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _alertCard(SafeNexusAlert alert) {
    final color = _priorityColor(alert.priority);
    final overdue = alert.isOverdue;
    final expiring = alert.isExpiringSoon;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openAlert(alert),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    color.withValues(alpha: 0.10),
                child: Icon(
                  _alertIcon(alert.type),
                  color: color,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: alert.read
                            ? FontWeight.w600
                            : FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${alert.phase} • ${alert.module}',
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: [
                        _badge(
                          alert.priority.name,
                          color,
                        ),
                        _badge(
                          alert.type.name,
                          darkGreen,
                        ),
                        if (!alert.read && !alert.resolved)
                          _badge(
                            'UNREAD',
                            primaryGreen,
                          ),
                        if (overdue)
                          _badge(
                            'OVERDUE',
                            Colors.red,
                          ),
                        if (expiring && !overdue)
                          _badge(
                            'EXPIRING',
                            Colors.orange.shade700,
                          ),
                        if (alert.resolved)
                          _badge(
                            'RESOLVED',
                            primaryGreen,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'read') {
                    _markRead(alert);
                  } else if (value == 'resolve') {
                    _resolve(alert);
                  } else if (value == 'delete') {
                    _delete(alert);
                  }
                },
                itemBuilder: (_) => [
                  if (!alert.read)
                    const PopupMenuItem<String>(
                      value: 'read',
                      child: Text('Mark as read'),
                    ),
                  if (!alert.resolved)
                    const PopupMenuItem<String>(
                      value: 'resolve',
                      child: Text('Resolve'),
                    ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _priorityColor(
    SafeNexusAlertPriority priority,
  ) {
    switch (priority) {
      case SafeNexusAlertPriority.low:
        return Colors.grey.shade700;
      case SafeNexusAlertPriority.medium:
        return Colors.blueGrey;
      case SafeNexusAlertPriority.high:
        return Colors.orange.shade700;
      case SafeNexusAlertPriority.critical:
        return Colors.red;
    }
  }

  IconData _alertIcon(
    SafeNexusAlertType type,
  ) {
    switch (type) {
      case SafeNexusAlertType.expiry:
        return Icons.schedule;
      case SafeNexusAlertType.overdue:
        return Icons.warning;
      case SafeNexusAlertType.criticalRisk:
        return Icons.dangerous;
      case SafeNexusAlertType.permit:
        return Icons.approval;
      case SafeNexusAlertType.training:
        return Icons.school;
      case SafeNexusAlertType.medical:
        return Icons.health_and_safety;
      case SafeNexusAlertType.equipment:
        return Icons.precision_manufacturing;
      case SafeNexusAlertType.legal:
        return Icons.gavel;
      case SafeNexusAlertType.emergency:
        return Icons.emergency;
      case SafeNexusAlertType.environment:
        return Icons.eco;
      case SafeNexusAlertType.incident:
        return Icons.report_problem;
      case SafeNexusAlertType.action:
        return Icons.task_alt;
      case SafeNexusAlertType.report:
        return Icons.bar_chart;
      case SafeNexusAlertType.general:
        return Icons.notifications;
    }
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 55,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No HSE alerts found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _alerts.isEmpty
                  ? 'Alerts will appear here when HSE modules '
                    'create expiry, overdue, risk or action alerts.'
                  : 'Try another filter or search term.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlertDetailsPage extends StatelessWidget {
  final SafeNexusAlert alert;

  const _AlertDetailsPage({
    required this.alert,
  });

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);
    const primaryGreen = Color(0xFF159447);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('HSE Alert Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.notifications_active,
                    color: primaryGreen,
                    size: 34,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    alert.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    alert.message,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _row('Phase', alert.phase),
                  _row('Module', alert.module),
                  _row('Record', alert.recordId),
                  _row('Type', alert.type.name),
                  _row('Priority', alert.priority.name),
                  _row('Project', alert.project),
                  _row('Site', alert.site),
                  if (alert.dueDate != null)
                    _row(
                      'Due Date',
                      _date(alert.dueDate!),
                    ),
                  if (alert.expiryDate != null)
                    _row(
                      'Expiry Date',
                      _date(alert.expiryDate!),
                    ),
                  _row(
                    'Status',
                    alert.resolved ? 'Resolved' : 'Active',
                  ),
                ],
              ),
            ),
          ),
          if (alert.metadata.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text(
              'Additional Data',
              style: TextStyle(
                color: darkGreen,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            ...alert.metadata.entries.map(
              (entry) => Card(
                child: ListTile(
                  title: Text(entry.key),
                  subtitle: Text(
                    entry.value?.toString() ?? '',
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
            ),
          ),
        ],
      ),
    );
  }

  String _date(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }
}

/// Convenience helper for main.dart.
///
/// Example:
///
/// MaterialApp(
///   home: SafeNexusStep23AlertCenter(
///     opener: (context, alert) async {
///       // Navigate to the real originating module here.
///     },
///   ),
/// );
Widget safeNexusStep23AlertCenter({
  SafeNexusAlertOpener? opener,
}) {
  return SafeNexusStep23AlertCenter(
    opener: opener,
  );
}
