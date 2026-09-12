import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE — STEP 34
/// HSE DOCUMENT & RECORDS CENTER
///
/// 34A Document Master
/// 34B HSE Records Register
/// 34C Document Category & Type
/// 34D Issue / Revision / Review Control
/// 34E Expiry & Renewal Tracking
/// 34F Approval & Status Control
/// 34G Responsible Person / Owner
/// 34H Document Reference & Integration
/// 34I Search & Advanced Filters
/// 34J Review / Renewal Follow-up
/// 34K Audit History
/// 34L Document Intelligence Dashboard
///
/// Storage: SharedPreferences
/// Language: English + Malayalam ready
/// ===============================================================

class SafeNexusStep34DocumentsRecordsPage extends StatefulWidget {
  const SafeNexusStep34DocumentsRecordsPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep34DocumentsRecordsPage> createState() =>
      _SafeNexusStep34DocumentsRecordsPageState();
}

class _SafeNexusStep34DocumentsRecordsPageState
    extends State<SafeNexusStep34DocumentsRecordsPage> {
  static const String storageKey =
      'safenexus_hse_step34_documents_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> statuses = [
    'Draft',
    'Under Review',
    'Approved',
    'Rejected',
    'Active',
    'Superseded',
    'Archived',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> categories = [
    'Policy',
    'Procedure',
    'SOP',
    'RAMS',
    'Risk Assessment',
    'JSA / JHA / HIRA',
    'PTW',
    'Inspection',
    'Training',
    'Incident',
    'Emergency',
    'Audit',
    'Certificate',
    'Legal / Authority',
    'Other',
  ];

  static const List<String> documentTypes = [
    'Controlled Document',
    'HSE Record',
    'Certificate',
    'Permit',
    'Inspection Record',
    'Training Record',
    'Audit Record',
    'Incident Record',
    'Other',
  ];

  static const List<String> referenceTypes = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 33 Communication',
    'Risk / HIRA / JSA / JHA',
    'RAMS',
    'PTW',
    'Workforce / Competency',
    'Equipment',
    'Incident',
    'Action Center',
  ];

  static const List<String> expiryFilters = [
    'All',
    'No Expiry',
    'Valid',
    'Due Soon',
    'Expired',
  ];

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  bool _loading = true;

  String _statusFilter = 'All';
  String _categoryFilter = 'All';
  String _priorityFilter = 'All';
  String _expiryFilter = 'All';

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_refreshView);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw != null && raw.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _records = decoded
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        }
      } catch (_) {
        _records = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  void _refreshView() {
    if (mounted) setState(() {});
  }

  String _expiryState(Map<String, dynamic> record) {
    final text = '${record['expiryDate'] ?? ''}'.trim();
    if (text.isEmpty) return 'No Expiry';

    final expiry = DateTime.tryParse(text);
    if (expiry == null) return 'No Expiry';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(expiry.year, expiry.month, expiry.day);

    if (date.isBefore(today)) return 'Expired';
    if (!date.isAfter(today.add(const Duration(days: 30)))) {
      return 'Due Soon';
    }
    return 'Valid';
  }

  bool _reviewDue(Map<String, dynamic> record) {
    final value = DateTime.tryParse('${record['reviewDate'] ?? ''}');
    if (value == null) return false;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final review = DateTime(value.year, value.month, value.day);
    final status = '${record['status'] ?? ''}';

    return review.isBefore(today) &&
        status != 'Archived' &&
        status != 'Superseded';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      if (_statusFilter != 'All' &&
          '${record['status'] ?? ''}' != _statusFilter) {
        return false;
      }
      if (_categoryFilter != 'All' &&
          '${record['category'] ?? ''}' != _categoryFilter) {
        return false;
      }
      if (_priorityFilter != 'All' &&
          '${record['priority'] ?? ''}' != _priorityFilter) {
        return false;
      }
      if (_expiryFilter != 'All' &&
          _expiryState(record) != _expiryFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = [
        record['title'],
        record['documentId'],
        record['category'],
        record['documentType'],
        record['project'],
        record['site'],
        record['location'],
        record['owner'],
        record['reviewer'],
        record['approver'],
        record['department'],
        record['description'],
        record['revision'],
        record['revisionNotes'],
        record['referenceType'],
        record['referenceId'],
        record['notes'],
        record['status'],
        record['priority'],
      ].map((value) => '$value').join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _count(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _activeCount =>
      _count((r) => '${r['status'] ?? ''}' == 'Active');

  int get _reviewCount =>
      _count((r) => '${r['status'] ?? ''}' == 'Under Review');

  int get _approvedCount =>
      _count((r) => '${r['status'] ?? ''}' == 'Approved');

  int get _criticalCount =>
      _count((r) => '${r['priority'] ?? ''}' == 'Critical');

  int get _dueSoonCount =>
      _count((r) => _expiryState(r) == 'Due Soon');

  int get _expiredCount =>
      _count((r) => _expiryState(r) == 'Expired');

  int get _reviewDueCount => _count(_reviewDue);

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _DocumentForm(existing: existing),
    );

    if (result == null) return;

    final record = Map<String, dynamic>.from(result);
    final existingId = existing?['id'];
    final now = DateTime.now().toIso8601String();

    if (existingId != null) {
      final index = _records.indexWhere((r) => r['id'] == existingId);
      if (index >= 0) {
        final oldHistory = List<dynamic>.from(
          _records[index]['history'] ?? const [],
        );
        record['id'] = existingId;
        record['createdAt'] = _records[index]['createdAt'] ?? now;
        record['updatedAt'] = now;
        record['history'] = [
          ...oldHistory,
          {'event': 'Updated', 'at': now},
        ];
        _records[index] = record;
      }
    } else {
      record['id'] = 'DOC-${DateTime.now().millisecondsSinceEpoch}';
      record['createdAt'] = now;
      record['updatedAt'] = now;
      record['history'] = [
        {'event': 'Created', 'at': now},
      ];
      _records.insert(0, record);
    }

    await _saveRecords();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete document record?'),
        content: Text(
          'Remove "${record['title'] ?? 'this document'}" from the register?',
        ),
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

    if (confirmed != true) return;

    _records.removeWhere((r) => r['id'] == record['id']);
    await _saveRecords();

    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> record) {
    final history = List<dynamic>.from(record['history'] ?? const []);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Audit History • ${record['id'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: history.isEmpty
                      ? const Center(child: Text('No history available.'))
                      : ListView.separated(
                          itemCount: history.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (_, index) {
                            final item =
                                Map<String, dynamic>.from(history[index] as Map);
                            return ListTile(
                              leading: const Icon(
                                Icons.history,
                                color: primaryGreen,
                              ),
                              title: Text('${item['event'] ?? 'Update'}'),
                              subtitle: Text(
                                _formatDateTime(item['at']),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openSource(Map<String, dynamic> record) {
    final opener = widget.sourceOpener;
    if (opener == null) return;

    opener(
      '${record['referenceType'] ?? ''}',
      '${record['referenceId'] ?? ''}',
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 34 • Documents & Records'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Document'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _header(),
                  const SizedBox(height: 12),
                  _dashboard(),
                  const SizedBox(height: 12),
                  _filters(),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    _emptyState()
                  else
                    ...filtered.map(_recordCard),
                ],
              ),
            ),
    );
  }

  Widget _header() {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [darkGreen, primaryGreen],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.folder_copy_outlined, color: Colors.white, size: 34),
            SizedBox(height: 8),
            Text(
              'HSE Document & Records Center',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Control • Review • Expiry • Approval • Traceability',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboard() {
    final metrics = [
      ('Total', _records.length, Icons.folder),
      ('Active', _activeCount, Icons.check_circle_outline),
      ('Review', _reviewCount, Icons.rate_review_outlined),
      ('Approved', _approvedCount, Icons.verified_outlined),
      ('Critical', _criticalCount, Icons.priority_high),
      ('Due Soon', _dueSoonCount, Icons.event_available),
      ('Expired', _expiredCount, Icons.warning_amber),
      ('Review Due', _reviewDueCount, Icons.fact_check_outlined),
    ];

    return GridView.builder(
      itemCount: metrics.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.05,
      ),
      itemBuilder: (_, index) {
        final item = metrics[index];
        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(child: Icon(item.$3, size: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.$2}',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        item.$1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search documents',
                hintText: 'Title, ID, owner, project, reference...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _filterDropdown(
                  label: 'Status',
                  value: _statusFilter,
                  values: ['All', ...statuses],
                  onChanged: (v) =>
                      setState(() => _statusFilter = v ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Category',
                  value: _categoryFilter,
                  values: ['All', ...categories],
                  onChanged: (v) =>
                      setState(() => _categoryFilter = v ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Priority',
                  value: _priorityFilter,
                  values: ['All', ...priorities],
                  onChanged: (v) =>
                      setState(() => _priorityFilter = v ?? 'All'),
                ),
                _filterDropdown(
                  label: 'Expiry',
                  value: _expiryFilter,
                  values: expiryFilters,
                  onChanged: (v) =>
                      setState(() => _expiryFilter = v ?? 'All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> values,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 165,
      child: DropdownButtonFormField<String>(
        initialValue: values.contains(value) ? value : 'All',
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final expiry = _expiryState(record);
    final status = '${record['status'] ?? 'Draft'}';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _details(record),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${record['title'] ?? 'Untitled Document'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  Chip(label: Text(status)),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '${record['id'] ?? ''} • ${record['category'] ?? ''}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                '${record['description'] ?? ''}',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 9),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  Chip(
                    avatar: const Icon(Icons.event, size: 15),
                    label: Text(expiry),
                    visualDensity: VisualDensity.compact,
                  ),
                  Chip(
                    avatar: const Icon(Icons.person_outline, size: 15),
                    label: Text('${record['owner'] ?? 'Unassigned'}'),
                    visualDensity: VisualDensity.compact,
                  ),
                  Chip(
                    avatar: const Icon(Icons.flag_outlined, size: 15),
                    label: Text('${record['priority'] ?? 'Medium'}'),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Icon(Icons.folder_open, size: 54),
            const SizedBox(height: 10),
            const Text(
              'No document records found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a document or adjust the filters.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('New Document'),
            ),
          ],
        ),
      ),
    );
  }

  void _details(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Document Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: darkGreen,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                _detail('ID', record['id']),
                _detail('Title', record['title']),
                _detail('Type', record['documentType']),
                _detail('Category', record['category']),
                _detail('Status', record['status']),
                _detail('Priority', record['priority']),
                _detail('Project', record['project']),
                _detail('Site', record['site']),
                _detail('Location', record['location']),
                _detail('Owner', record['owner']),
                _detail('Reviewer', record['reviewer']),
                _detail('Approver', record['approver']),
                _detail('Department', record['department']),
                _detail('Revision', record['revision']),
                _detail('Revision Notes', record['revisionNotes']),
                _detail('Issue Date', _formatDate(record['issueDate'])),
                _detail('Review Date', _formatDate(record['reviewDate'])),
                _detail('Expiry Date', _formatDate(record['expiryDate'])),
                _detail('Reference Type', record['referenceType']),
                _detail('Reference ID', record['referenceId']),
                _detail('Description', record['description']),
                _detail('Notes', record['notes']),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _openForm(existing: record);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showHistory(record);
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('History'),
                    ),
                    if (widget.sourceOpener != null)
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _openSource(record);
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open Source'),
                      ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteRecord(record);
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detail(String label, dynamic value) {
    final text = value == null ? '' : '$value';
    if (text.isEmpty || text == 'null') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black87, height: 1.3),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}

class _DocumentForm extends StatefulWidget {
  const _DocumentForm({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_DocumentForm> createState() => _DocumentFormState();
}

class _DocumentFormState extends State<_DocumentForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _documentId;
  late final TextEditingController _project;
  late final TextEditingController _site;
  late final TextEditingController _location;
  late final TextEditingController _owner;
  late final TextEditingController _reviewer;
  late final TextEditingController _approver;
  late final TextEditingController _department;
  late final TextEditingController _revision;
  late final TextEditingController _revisionNotes;
  late final TextEditingController _description;
  late final TextEditingController _referenceId;
  late final TextEditingController _notes;

  String _type = _SafeNexusStep34DocumentsRecordsPageState.documentTypes.first;
  String _category = _SafeNexusStep34DocumentsRecordsPageState.categories.first;
  String _status = 'Draft';
  String _priority = 'Medium';
  String _referenceType =
      _SafeNexusStep34DocumentsRecordsPageState.referenceTypes.first;

  DateTime? _issueDate;
  DateTime? _reviewDate;
  DateTime? _expiryDate;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;

    _title = TextEditingController(text: '${e?['title'] ?? ''}');
    _documentId = TextEditingController(text: '${e?['documentId'] ?? ''}');
    _project = TextEditingController(text: '${e?['project'] ?? ''}');
    _site = TextEditingController(text: '${e?['site'] ?? ''}');
    _location = TextEditingController(text: '${e?['location'] ?? ''}');
    _owner = TextEditingController(text: '${e?['owner'] ?? ''}');
    _reviewer = TextEditingController(text: '${e?['reviewer'] ?? ''}');
    _approver = TextEditingController(text: '${e?['approver'] ?? ''}');
    _department = TextEditingController(text: '${e?['department'] ?? ''}');
    _revision = TextEditingController(text: '${e?['revision'] ?? 'Rev 0'}');
    _revisionNotes =
        TextEditingController(text: '${e?['revisionNotes'] ?? ''}');
    _description =
        TextEditingController(text: '${e?['description'] ?? ''}');
    _referenceId =
        TextEditingController(text: '${e?['referenceId'] ?? ''}');
    _notes = TextEditingController(text: '${e?['notes'] ?? ''}');

    _type = _safe(
      '${e?['documentType'] ?? _type}',
      _SafeNexusStep34DocumentsRecordsPageState.documentTypes,
      _type,
    );
    _category = _safe(
      '${e?['category'] ?? _category}',
      _SafeNexusStep34DocumentsRecordsPageState.categories,
      _category,
    );
    _status = _safe(
      '${e?['status'] ?? _status}',
      _SafeNexusStep34DocumentsRecordsPageState.statuses,
      _status,
    );
    _priority = _safe(
      '${e?['priority'] ?? _priority}',
      _SafeNexusStep34DocumentsRecordsPageState.priorities,
      _priority,
    );
    _referenceType = _safe(
      '${e?['referenceType'] ?? _referenceType}',
      _SafeNexusStep34DocumentsRecordsPageState.referenceTypes,
      _referenceType,
    );

    _issueDate = DateTime.tryParse('${e?['issueDate']}');
    _reviewDate = DateTime.tryParse('${e?['reviewDate']}');
    _expiryDate = DateTime.tryParse('${e?['expiryDate']}');
  }

  String _safe(String value, List<String> values, String fallback) =>
      values.contains(value) ? value : fallback;

  @override
  void dispose() {
    _title.dispose();
    _documentId.dispose();
    _project.dispose();
    _site.dispose();
    _location.dispose();
    _owner.dispose();
    _reviewer.dispose();
    _approver.dispose();
    _department.dispose();
    _revision.dispose();
    _revisionNotes.dispose();
    _description.dispose();
    _referenceId.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate(String field) async {
    final current = field == 'issue'
        ? _issueDate
        : field == 'review'
            ? _reviewDate
            : _expiryDate;

    final selected = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected == null) return;

    setState(() {
      if (field == 'issue') {
        _issueDate = selected;
      } else if (field == 'review') {
        _reviewDate = selected;
      } else {
        _expiryDate = selected;
      }
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, {
      'title': _title.text.trim(),
      'documentId': _documentId.text.trim(),
      'project': _project.text.trim(),
      'site': _site.text.trim(),
      'location': _location.text.trim(),
      'owner': _owner.text.trim(),
      'reviewer': _reviewer.text.trim(),
      'approver': _approver.text.trim(),
      'department': _department.text.trim(),
      'revision': _revision.text.trim(),
      'revisionNotes': _revisionNotes.text.trim(),
      'description': _description.text.trim(),
      'referenceId': _referenceId.text.trim(),
      'notes': _notes.text.trim(),
      'documentType': _type,
      'category': _category,
      'status': _status,
      'priority': _priority,
      'referenceType': _referenceType,
      'issueDate': _issueDate?.toIso8601String(),
      'reviewDate': _reviewDate?.toIso8601String(),
      'expiryDate': _expiryDate?.toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existing == null
            ? 'New Document / Record'
            : 'Edit Document / Record',
      ),
      content: SizedBox(
        width: 620,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _text(_title, 'Title', requiredField: true),
                _text(_documentId, 'Document Number / ID'),
                _dropdown(
                  'Document Type',
                  _type,
                  _SafeNexusStep34DocumentsRecordsPageState.documentTypes,
                  (v) => setState(() => _type = v!),
                ),
                _dropdown(
                  'Category',
                  _category,
                  _SafeNexusStep34DocumentsRecordsPageState.categories,
                  (v) => setState(() => _category = v!),
                ),
                _dropdown(
                  'Status',
                  _status,
                  _SafeNexusStep34DocumentsRecordsPageState.statuses,
                  (v) => setState(() => _status = v!),
                ),
                _dropdown(
                  'Priority',
                  _priority,
                  _SafeNexusStep34DocumentsRecordsPageState.priorities,
                  (v) => setState(() => _priority = v!),
                ),
                _text(_project, 'Project'),
                _text(_site, 'Site'),
                _text(_location, 'Location'),
                _text(_owner, 'Responsible Person / Owner'),
                _text(_reviewer, 'Reviewer'),
                _text(_approver, 'Approver'),
                _text(_department, 'Department / Contractor'),
                _text(_revision, 'Revision'),
                _text(_revisionNotes, 'Revision Notes', maxLines: 2),
                _text(
                  _description,
                  'Description',
                  requiredField: true,
                  maxLines: 4,
                ),
                _dropdown(
                  'Reference Type',
                  _referenceType,
                  _SafeNexusStep34DocumentsRecordsPageState.referenceTypes,
                  (v) => setState(() => _referenceType = v!),
                ),
                _text(_referenceId, 'Reference ID'),
                _dateButton('Issue Date', _issueDate, () => _pickDate('issue')),
                _dateButton(
                  'Review Date',
                  _reviewDate,
                  () => _pickDate('review'),
                ),
                _dateButton(
                  'Expiry Date',
                  _expiryDate,
                  () => _pickDate('expiry'),
                ),
                _text(_notes, 'Notes', maxLines: 3),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      ],
    );
  }

  Widget _text(
    TextEditingController controller,
    String label, {
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: requiredField
            ? (value) =>
                value == null || value.trim().isEmpty ? 'Required field' : null
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> values,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: DropdownButtonFormField<String>(
        initialValue: values.contains(value) ? value : values.first,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateButton(
    String label,
    DateTime? value,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        title: Text(label),
        subtitle: Text(
          value == null ? 'Not set' : _formatDate(value.toIso8601String()),
        ),
        trailing: const Icon(Icons.edit_calendar),
        onTap: onTap,
      ),
    );
  }
}

String _formatDate(dynamic value) {
  if (value == null) return 'Not set';
  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/'
      '${date.year}';
}

String _formatDateTime(dynamic value) {
  if (value == null) return '';
  final date = DateTime.tryParse('$value');
  if (date == null) return '$value';
  return '${_formatDate(date.toIso8601String())} '
      '${date.hour.toString().padLeft(2, '0')}:'
      '${date.minute.toString().padLeft(2, '0')}';
}
