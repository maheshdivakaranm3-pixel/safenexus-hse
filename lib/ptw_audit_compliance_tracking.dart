import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PtwAuditComplianceTrackingPage extends StatefulWidget {
  const PtwAuditComplianceTrackingPage({super.key});

  @override
  State<PtwAuditComplianceTrackingPage> createState() =>
      _PtwAuditComplianceTrackingPageState();
}

class _PtwAuditComplianceTrackingPageState
    extends State<PtwAuditComplianceTrackingPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_ptw_audit_compliance_tracking';

  final permitTypes = const [
    'General Work Permit',
    'Hot Work Permit',
    'Confined Space Entry Permit',
    'Work at Height Permit',
    'Excavation / Trenching Permit',
    'Electrical / LOTO Permit',
    'Lifting / Critical Lift Permit',
    'Line Breaking / Breaking Containment Permit',
    'Cold Work Permit',
    'Other',
  ];

  final auditTypes = const [
    'Routine PTW Audit',
    'Permit Spot Check',
    'Pre-Work Verification',
    'Field Compliance Audit',
    'Post-Work Audit',
    'Management Audit',
    'Client Audit',
    'Incident / Near Miss Triggered Audit',
    'Revalidation Audit',
    'Other',
  ];

  final triggers = const [
    'Scheduled',
    'New Permit',
    'High-Risk Activity',
    'Permit Extension',
    'Permit Suspension',
    'Permit Revalidation',
    'Field Observation',
    'Incident / Near Miss',
    'Management Direction',
    'Client Requirement',
    'Other',
  ];

  final classifications = const [
    'Conforming',
    'Observation',
    'Minor Non-Compliance',
    'Major Non-Compliance',
    'Critical Non-Compliance',
    'Opportunity for Improvement',
  ];

  final statuses = const [
    'Draft',
    'Open',
    'Under Review',
    'Non-Compliant',
    'Action Required',
    'Verification Pending',
    'Compliant',
    'Closed',
    'Cancelled',
  ];

  final frequencies = const [
    'One-Time',
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'As Required',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String classificationFilter = 'All';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    if (!mounted) return;
    setState(() {
      records = raw.map(_decode).toList();
      loading = false;
    });
  }

  Map<String, dynamic> _decode(String value) {
    final parts = value.split('\u001f');
    final result = <String, dynamic>{};
    for (var i = 0; i + 1 < parts.length; i += 2) {
      result[parts[i]] = parts[i + 1];
    }
    return result;
  }

  String _encode(Map<String, dynamic> record) {
    final parts = <String>[];
    record.forEach((key, value) {
      parts.add(key);
      parts.add(value?.toString() ?? '');
    });
    return parts.join('\u001f');
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(storageKey, records.map(_encode).toList());
  }

  List<Map<String, dynamic>> get filteredRecords {
    final q = search.trim().toLowerCase();

    return records.where((record) {
      final searchable = [
        record['auditNo'],
        record['permitNo'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['permitType'],
        record['auditType'],
        record['auditor'],
        record['classification'],
        record['status'],
        record['finding'],
        record['actionOwner'],
      ].join(' ').toLowerCase();

      final matchesSearch = q.isEmpty || searchable.contains(q);
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesClassification = classificationFilter == 'All' ||
          record['classification'] == classificationFilter;

      return matchesSearch && matchesStatus && matchesClassification;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get totalCount => records.length;
  int get compliantCount => _count('Compliant');
  int get actionCount => _count('Action Required');
  int get nonCompliantCount => _count('Non-Compliant');
  int get verificationCount => _count('Verification Pending');
  int get closedCount => _count('Closed');

  bool _isOverdue(Map<String, dynamic> record) {
    final dateText = record['actionDueDate']?.toString() ?? '';
    final date = DateTime.tryParse(dateText);
    if (date == null) return false;

    final status = record['status']?.toString() ?? '';
    final actionClosed =
        record['correctiveActionClosed']?.toString() == 'true';

    return date.isBefore(DateTime.now()) &&
        !actionClosed &&
        !['Closed', 'Cancelled', 'Compliant'].contains(status);
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({
    Map<String, dynamic>? existing,
    int? index,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _PtwAuditForm(
        existing: existing,
        permitTypes: permitTypes,
        auditTypes: auditTypes,
        triggers: triggers,
        classifications: classifications,
        statuses: statuses,
        frequencies: frequencies,
      ),
    );

    if (result == null) return;

    setState(() {
      if (index == null) {
        result['createdAt'] = DateTime.now().toIso8601String();
        result['updatedAt'] = result['createdAt'];
        records.insert(0, result);
      } else {
        result['createdAt'] =
            records[index]['createdAt'] ?? DateTime.now().toIso8601String();
        result['updatedAt'] = DateTime.now().toIso8601String();
        records[index] = result;
      }
    });

    await _save();
  }

  Future<void> _delete(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Audit'),
        content: const Text(
          'Delete this PTW audit and compliance record?',
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

    setState(() => records.removeAt(index));
    await _save();
  }

  void _details(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _PtwAuditDetails(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PTW Audit & Compliance Tracking'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.fact_check),
        label: const Text('New Audit'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _AuditDashboard(
                  total: totalCount,
                  compliant: compliantCount,
                  actions: actionCount,
                  nonCompliant: nonCompliantCount,
                  verification: verificationCount,
                  closed: closedCount,
                  overdue: overdueCount,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search PTW audits',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => search = value),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: statusFilter,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...statuses.map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ),
                                ),
                              ],
                              onChanged: (value) => setState(
                                () => statusFilter = value ?? 'All',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: classificationFilter,
                              decoration: const InputDecoration(
                                labelText: 'Finding',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...classifications.map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => setState(
                                () => classificationFilter = value ?? 'All',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredRecords.isEmpty
                      ? const Center(
                          child: Text('No PTW audit records found.'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, index) {
                            final record = filteredRecords[index];
                            final realIndex = records.indexOf(record);
                            final overdue = _isOverdue(record);

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                onTap: () => _details(record),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      overdue ? Colors.red : primaryGreen,
                                  foregroundColor: Colors.white,
                                  child: const Icon(Icons.fact_check),
                                ),
                                title: Text(
                                  record['auditNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['auditNo'].toString()
                                      : 'PTW Audit',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['permitNo'] ?? ''} • '
                                  '${record['permitType'] ?? ''}\n'
                                  '${record['classification'] ?? ''} • '
                                  '${record['status'] ?? ''}'
                                  '${overdue ? ' • OVERDUE' : ''}',
                                ),
                                isThreeLine: true,
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _openForm(
                                        existing: record,
                                        index: realIndex,
                                      );
                                    } else if (value == 'delete') {
                                      _delete(realIndex);
                                    } else {
                                      _details(record);
                                    }
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                      value: 'details',
                                      child: Text('Details'),
                                    ),
                                    PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class _AuditDashboard extends StatelessWidget {
  final int total;
  final int compliant;
  final int actions;
  final int nonCompliant;
  final int verification;
  final int closed;
  final int overdue;

  const _AuditDashboard({
    required this.total,
    required this.compliant,
    required this.actions,
    required this.nonCompliant,
    required this.verification,
    required this.closed,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _DashboardTile(
            label: 'Total',
            value: total,
            icon: Icons.assignment,
          ),
          _DashboardTile(
            label: 'Compliant',
            value: compliant,
            icon: Icons.check_circle,
          ),
          _DashboardTile(
            label: 'Actions',
            value: actions,
            icon: Icons.assignment_late,
          ),
          _DashboardTile(
            label: 'Non-Compliant',
            value: nonCompliant,
            icon: Icons.warning,
          ),
          _DashboardTile(
            label: 'Verification',
            value: verification,
            icon: Icons.verified,
          ),
          _DashboardTile(
            label: 'Closed',
            value: closed,
            icon: Icons.lock,
          ),
          _DashboardTile(
            label: 'Overdue',
            value: overdue,
            icon: Icons.schedule,
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _DashboardTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PtwAuditForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> permitTypes;
  final List<String> auditTypes;
  final List<String> triggers;
  final List<String> classifications;
  final List<String> statuses;
  final List<String> frequencies;

  const _PtwAuditForm({
    required this.existing,
    required this.permitTypes,
    required this.auditTypes,
    required this.triggers,
    required this.classifications,
    required this.statuses,
    required this.frequencies,
  });

  @override
  State<_PtwAuditForm> createState() => _PtwAuditFormState();
}

class _PtwAuditFormState extends State<_PtwAuditForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String permitType;
  late String auditType;
  late String trigger;
  late String classification;
  late String status;
  late String frequency;

  bool permitDocumentVerified = false;
  bool authorizationVerified = false;
  bool riskAssessmentVerified = false;
  bool jsaVerified = false;
  bool ramsVerified = false;
  bool competencyVerified = false;
  bool equipmentCertificatesVerified = false;
  bool isolationLotoVerified = false;
  bool gasTestVerified = false;
  bool ppeControlsVerified = false;
  bool siteConditionsVerified = false;
  bool toolboxTalkVerified = false;
  bool extensionSuspensionRevalidationVerified = false;
  bool closureHandoverVerified = false;
  bool correctiveActionRequired = false;
  bool correctiveActionClosed = false;
  bool effectivenessVerified = false;

  @override
  void initState() {
    super.initState();

    const fields = [
      'auditNo',
      'permitNo',
      'project',
      'location',
      'department',
      'activity',
      'auditor',
      'auditDate',
      'nextAuditDate',
      'permitIssueDate',
      'permitExpiryDate',
      'workStatus',
      'permitHolder',
      'issuingAuthority',
      'auditScope',
      'documentFindings',
      'authorizationFindings',
      'riskFindings',
      'jsaFindings',
      'ramsFindings',
      'competencyFindings',
      'equipmentFindings',
      'isolationFindings',
      'gasTestFindings',
      'ppeFindings',
      'siteFindings',
      'toolboxFindings',
      'extensionFindings',
      'closureFindings',
      'finding',
      'findingDetails',
      'rootCause',
      'immediateAction',
      'correctiveAction',
      'preventiveAction',
      'actionOwner',
      'actionDueDate',
      'verificationDate',
      'verifiedBy',
      'effectivenessEvidence',
      'supportingDocuments',
      'auditRemarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    permitType =
        widget.existing?['permitType']?.toString() ?? widget.permitTypes.first;
    auditType =
        widget.existing?['auditType']?.toString() ?? widget.auditTypes.first;
    trigger =
        widget.existing?['trigger']?.toString() ?? widget.triggers.first;
    classification = widget.existing?['classification']?.toString() ??
        widget.classifications.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';
    frequency =
        widget.existing?['frequency']?.toString() ?? widget.frequencies.first;

    permitDocumentVerified =
        widget.existing?['permitDocumentVerified']?.toString() == 'true';
    authorizationVerified =
        widget.existing?['authorizationVerified']?.toString() == 'true';
    riskAssessmentVerified =
        widget.existing?['riskAssessmentVerified']?.toString() == 'true';
    jsaVerified = widget.existing?['jsaVerified']?.toString() == 'true';
    ramsVerified = widget.existing?['ramsVerified']?.toString() == 'true';
    competencyVerified =
        widget.existing?['competencyVerified']?.toString() == 'true';
    equipmentCertificatesVerified =
        widget.existing?['equipmentCertificatesVerified']?.toString() ==
            'true';
    isolationLotoVerified =
        widget.existing?['isolationLotoVerified']?.toString() == 'true';
    gasTestVerified =
        widget.existing?['gasTestVerified']?.toString() == 'true';
    ppeControlsVerified =
        widget.existing?['ppeControlsVerified']?.toString() == 'true';
    siteConditionsVerified =
        widget.existing?['siteConditionsVerified']?.toString() == 'true';
    toolboxTalkVerified =
        widget.existing?['toolboxTalkVerified']?.toString() == 'true';
    extensionSuspensionRevalidationVerified =
        widget.existing?['extensionSuspensionRevalidationVerified']
                ?.toString() ==
            'true';
    closureHandoverVerified =
        widget.existing?['closureHandoverVerified']?.toString() == 'true';
    correctiveActionRequired =
        widget.existing?['correctiveActionRequired']?.toString() == 'true';
    correctiveActionClosed =
        widget.existing?['correctiveActionClosed']?.toString() == 'true';
    effectivenessVerified =
        widget.existing?['effectivenessVerified']?.toString() == 'true';
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _text(String name) => controllers[name]!.text.trim();

  Future<String?> _pickDateTime(String current) async {
    final initial = DateTime.tryParse(current) ?? DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );

    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ).toIso8601String();
  }

  Widget _field(
    String name,
    String label, {
    int maxLines = 1,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[name],
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
            : null,
      ),
    );
  }

  Widget _dateField(
    String name,
    String label, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[name],
        readOnly: true,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_month),
        ),
        onTap: () async {
          final value = await _pickDateTime(controllers[name]!.text);
          if (value != null) {
            setState(() => controllers[name]!.text = value);
          }
        },
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
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
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem(
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

  Widget _switch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      activeThumbColor: primaryGreen,
      onChanged: onChanged,
    );
  }

  void _error(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _validateBusinessRules() {
    final auditDate = DateTime.tryParse(_text('auditDate'));
    final nextAuditDate = DateTime.tryParse(_text('nextAuditDate'));
    final dueDate = DateTime.tryParse(_text('actionDueDate'));
    final verificationDate = DateTime.tryParse(_text('verificationDate'));

    if (auditDate != null &&
        nextAuditDate != null &&
        nextAuditDate.isBefore(auditDate)) {
      _error('Next audit date cannot be before the audit date.');
      return false;
    }

    if (dueDate != null &&
        verificationDate != null &&
        verificationDate.isBefore(dueDate)) {
      _error('Verification date cannot be before action due date.');
      return false;
    }

    if (!permitDocumentVerified ||
        !authorizationVerified ||
        !riskAssessmentVerified ||
        !jsaVerified ||
        !ramsVerified ||
        !competencyVerified ||
        !equipmentCertificatesVerified ||
        !ppeControlsVerified ||
        !siteConditionsVerified ||
        !toolboxTalkVerified) {
      _error(
        'All mandatory PTW compliance verification checks must be completed.',
      );
      return false;
    }

    if (isolationLotoVerified && _text('isolationFindings').isEmpty) {
      _error('Isolation / LOTO verification details are required.');
      return false;
    }

    if (gasTestVerified && _text('gasTestFindings').isEmpty) {
      _error('Gas-test verification details are required.');
      return false;
    }

    if (correctiveActionRequired) {
      if (_text('correctiveAction').isEmpty ||
          _text('actionOwner').isEmpty ||
          _text('actionDueDate').isEmpty) {
        _error(
          'Corrective action, owner and due date are required.',
        );
        return false;
      }
    }

    if (correctiveActionClosed && !effectivenessVerified) {
      _error(
        'Effectiveness verification is required before action closure.',
      );
      return false;
    }

    if (status == 'Verification Pending' && _text('verificationDate').isEmpty) {
      _error('Verification date is required.');
      return false;
    }

    if (status == 'Closed') {
      if (correctiveActionRequired && !correctiveActionClosed) {
        _error('Corrective actions must be closed before audit closure.');
        return false;
      }
      if (!effectivenessVerified && correctiveActionRequired) {
        _error('Action effectiveness must be verified before closure.');
        return false;
      }
    }

    if (['Compliant', 'Closed'].contains(status) &&
        _text('finding').isEmpty) {
      _error('Audit finding / conclusion is required.');
      return false;
    }

    if (['Non-Compliant', 'Action Required'].contains(status) &&
        !correctiveActionRequired) {
      _error('Corrective action is required for this status.');
      return false;
    }

    if (classification != 'Conforming' &&
        _text('findingDetails').isEmpty) {
      _error('Finding details are required for non-conforming results.');
      return false;
    }

    return true;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;
    if (!_validateBusinessRules()) return;

    final record = <String, dynamic>{
      'auditNo': _text('auditNo'),
      'permitNo': _text('permitNo'),
      'project': _text('project'),
      'location': _text('location'),
      'department': _text('department'),
      'permitType': permitType,
      'auditType': auditType,
      'trigger': trigger,
      'classification': classification,
      'status': status,
      'frequency': frequency,
      'auditor': _text('auditor'),
      'auditDate': _text('auditDate'),
      'nextAuditDate': _text('nextAuditDate'),
      'permitIssueDate': _text('permitIssueDate'),
      'permitExpiryDate': _text('permitExpiryDate'),
      'workStatus': _text('workStatus'),
      'permitHolder': _text('permitHolder'),
      'issuingAuthority': _text('issuingAuthority'),
      'auditScope': _text('auditScope'),
      'documentFindings': _text('documentFindings'),
      'authorizationFindings': _text('authorizationFindings'),
      'riskFindings': _text('riskFindings'),
      'jsaFindings': _text('jsaFindings'),
      'ramsFindings': _text('ramsFindings'),
      'competencyFindings': _text('competencyFindings'),
      'equipmentFindings': _text('equipmentFindings'),
      'isolationFindings': _text('isolationFindings'),
      'gasTestFindings': _text('gasTestFindings'),
      'ppeFindings': _text('ppeFindings'),
      'siteFindings': _text('siteFindings'),
      'toolboxFindings': _text('toolboxFindings'),
      'extensionFindings': _text('extensionFindings'),
      'closureFindings': _text('closureFindings'),
      'finding': _text('finding'),
      'findingDetails': _text('findingDetails'),
      'rootCause': _text('rootCause'),
      'immediateAction': _text('immediateAction'),
      'correctiveAction': _text('correctiveAction'),
      'preventiveAction': _text('preventiveAction'),
      'actionOwner': _text('actionOwner'),
      'actionDueDate': _text('actionDueDate'),
      'verificationDate': _text('verificationDate'),
      'verifiedBy': _text('verifiedBy'),
      'effectivenessEvidence': _text('effectivenessEvidence'),
      'supportingDocuments': _text('supportingDocuments'),
      'auditRemarks': _text('auditRemarks'),
      'permitDocumentVerified': permitDocumentVerified,
      'authorizationVerified': authorizationVerified,
      'riskAssessmentVerified': riskAssessmentVerified,
      'jsaVerified': jsaVerified,
      'ramsVerified': ramsVerified,
      'competencyVerified': competencyVerified,
      'equipmentCertificatesVerified': equipmentCertificatesVerified,
      'isolationLotoVerified': isolationLotoVerified,
      'gasTestVerified': gasTestVerified,
      'ppeControlsVerified': ppeControlsVerified,
      'siteConditionsVerified': siteConditionsVerified,
      'toolboxTalkVerified': toolboxTalkVerified,
      'extensionSuspensionRevalidationVerified':
          extensionSuspensionRevalidationVerified,
      'closureHandoverVerified': closureHandoverVerified,
      'correctiveActionRequired': correctiveActionRequired,
      'correctiveActionClosed': correctiveActionClosed,
      'effectivenessVerified': effectivenessVerified,
    };

    Navigator.pop(context, record);
  }

  Widget _section(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.only(
          top: 12,
          left: 12,
          right: 12,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'PTW Audit & Compliance Tracking',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    _section(
                      '1. Audit & Permit Details',
                      Icons.fact_check,
                      [
                        _field('auditNo', 'Audit No.', required: true),
                        _field('permitNo', 'Permit No.', required: true),
                        _dropdown(
                          'Permit Type',
                          permitType,
                          widget.permitTypes,
                          (value) => setState(
                            () => permitType = value ?? permitType,
                          ),
                        ),
                        _dropdown(
                          'Audit Type',
                          auditType,
                          widget.auditTypes,
                          (value) => setState(
                            () => auditType = value ?? auditType,
                          ),
                        ),
                        _dropdown(
                          'Audit Trigger',
                          trigger,
                          widget.triggers,
                          (value) => setState(
                            () => trigger = value ?? trigger,
                          ),
                        ),
                        _dropdown(
                          'Audit Frequency',
                          frequency,
                          widget.frequencies,
                          (value) => setState(
                            () => frequency = value ?? frequency,
                          ),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location', required: true),
                        _field('department', 'Department'),
                        _field(
                          'activity',
                          'Activity / Work',
                          required: true,
                        ),
                        _field('auditor', 'Auditor / HSE Auditor', required: true),
                        _field('permitHolder', 'Permit Holder'),
                        _field('issuingAuthority', 'Issuing Authority'),
                        _field(
                          'workStatus',
                          'Work Status at Audit',
                          maxLines: 2,
                        ),
                        _field(
                          'auditScope',
                          'Audit Scope',
                          maxLines: 4,
                          required: true,
                        ),
                        _dateField(
                          'auditDate',
                          'Audit Date',
                          required: true,
                        ),
                        _dateField(
                          'nextAuditDate',
                          'Next Audit Date',
                        ),
                        _dateField(
                          'permitIssueDate',
                          'Permit Issue Date',
                        ),
                        _dateField(
                          'permitExpiryDate',
                          'Permit Expiry Date',
                        ),
                      ],
                    ),
                    _section(
                      '2. PTW Document & Authorization Verification',
                      Icons.description,
                      [
                        _switch(
                          'Permit Document Verified',
                          permitDocumentVerified,
                          (value) => setState(
                            () => permitDocumentVerified = value,
                          ),
                        ),
                        _field(
                          'documentFindings',
                          'Permit Document Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Permit Authorization Verified',
                          authorizationVerified,
                          (value) => setState(
                            () => authorizationVerified = value,
                          ),
                        ),
                        _field(
                          'authorizationFindings',
                          'Authorization Findings',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '3. Risk & Work Planning Verification',
                      Icons.health_and_safety,
                      [
                        _switch(
                          'Risk Assessment / HIRA Verified',
                          riskAssessmentVerified,
                          (value) => setState(
                            () => riskAssessmentVerified = value,
                          ),
                        ),
                        _field(
                          'riskFindings',
                          'Risk Assessment Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'JSA / JHA Verified',
                          jsaVerified,
                          (value) =>
                              setState(() => jsaVerified = value),
                        ),
                        _field(
                          'jsaFindings',
                          'JSA / JHA Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'RAMS Verified',
                          ramsVerified,
                          (value) =>
                              setState(() => ramsVerified = value),
                        ),
                        _field(
                          'ramsFindings',
                          'RAMS Findings',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '4. Competency, Equipment & Controls',
                      Icons.engineering,
                      [
                        _switch(
                          'Competency / Training Verified',
                          competencyVerified,
                          (value) => setState(
                            () => competencyVerified = value,
                          ),
                        ),
                        _field(
                          'competencyFindings',
                          'Competency Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Equipment / Certificates Verified',
                          equipmentCertificatesVerified,
                          (value) => setState(
                            () => equipmentCertificatesVerified = value,
                          ),
                        ),
                        _field(
                          'equipmentFindings',
                          'Equipment / Certificate Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'PPE & Critical Controls Verified',
                          ppeControlsVerified,
                          (value) => setState(
                            () => ppeControlsVerified = value,
                          ),
                        ),
                        _field(
                          'ppeFindings',
                          'PPE / Control Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Site Conditions Verified',
                          siteConditionsVerified,
                          (value) => setState(
                            () => siteConditionsVerified = value,
                          ),
                        ),
                        _field(
                          'siteFindings',
                          'Site Condition Findings',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Toolbox Talk / Briefing Verified',
                          toolboxTalkVerified,
                          (value) => setState(
                            () => toolboxTalkVerified = value,
                          ),
                        ),
                        _field(
                          'toolboxFindings',
                          'Toolbox Talk Findings',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '5. Isolation, Gas Test & Permit Lifecycle',
                      Icons.power_settings_new,
                      [
                        _switch(
                          'Isolation / LOTO Verified',
                          isolationLotoVerified,
                          (value) => setState(
                            () => isolationLotoVerified = value,
                          ),
                        ),
                        _field(
                          'isolationFindings',
                          'Isolation / LOTO Findings',
                          maxLines: 3,
                        ),
                        _switch(
                          'Gas Test / Atmospheric Verification',
                          gasTestVerified,
                          (value) => setState(
                            () => gasTestVerified = value,
                          ),
                        ),
                        _field(
                          'gasTestFindings',
                          'Gas Test Findings',
                          maxLines: 3,
                        ),
                        _switch(
                          'Extension / Suspension / Revalidation Verified',
                          extensionSuspensionRevalidationVerified,
                          (value) => setState(
                            () => extensionSuspensionRevalidationVerified =
                                value,
                          ),
                        ),
                        _field(
                          'extensionFindings',
                          'Extension / Suspension / Revalidation Findings',
                          maxLines: 3,
                        ),
                        _switch(
                          'Permit Closure / Handover Verified',
                          closureHandoverVerified,
                          (value) => setState(
                            () => closureHandoverVerified = value,
                          ),
                        ),
                        _field(
                          'closureFindings',
                          'Closure / Handover Findings',
                          maxLines: 3,
                        ),
                      ],
                    ),
                    _section(
                      '6. Audit Finding & Compliance Result',
                      Icons.rule,
                      [
                        _dropdown(
                          'Finding Classification',
                          classification,
                          widget.classifications,
                          (value) => setState(
                            () => classification =
                                value ?? classification,
                          ),
                        ),
                        _field(
                          'finding',
                          'Audit Conclusion / Finding',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'findingDetails',
                          'Finding Details / Evidence',
                          maxLines: 5,
                        ),
                        _field(
                          'rootCause',
                          'Root Cause',
                          maxLines: 4,
                        ),
                        _field(
                          'immediateAction',
                          'Immediate Action Taken',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '7. Corrective & Preventive Action',
                      Icons.build_circle,
                      [
                        _switch(
                          'Corrective Action Required',
                          correctiveActionRequired,
                          (value) => setState(
                            () => correctiveActionRequired = value,
                          ),
                        ),
                        _field(
                          'correctiveAction',
                          'Corrective Action',
                          maxLines: 4,
                        ),
                        _field(
                          'preventiveAction',
                          'Preventive Action',
                          maxLines: 4,
                        ),
                        _field(
                          'actionOwner',
                          'Action Owner',
                        ),
                        _dateField(
                          'actionDueDate',
                          'Action Due Date',
                        ),
                        _switch(
                          'Corrective Action Closed',
                          correctiveActionClosed,
                          (value) => setState(
                            () => correctiveActionClosed = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '8. Verification & Effectiveness',
                      Icons.verified_user,
                      [
                        _dateField(
                          'verificationDate',
                          'Verification Date',
                        ),
                        _field(
                          'verifiedBy',
                          'Verified By',
                        ),
                        _field(
                          'effectivenessEvidence',
                          'Effectiveness Evidence / Verification',
                          maxLines: 4,
                        ),
                        _switch(
                          'Effectiveness Verified',
                          effectivenessVerified,
                          (value) => setState(
                            () => effectivenessVerified = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '9. Status & Final Record',
                      Icons.assignment_turned_in,
                      [
                        _dropdown(
                          'Status',
                          status,
                          widget.statuses,
                          (value) => setState(
                            () => status = value ?? status,
                          ),
                        ),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents / Evidence',
                          maxLines: 3,
                        ),
                        _field(
                          'auditRemarks',
                          'Audit Remarks',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                        onPressed: _submit,
                        icon: const Icon(Icons.save),
                        label: Text(
                          widget.existing == null
                              ? 'Save Audit'
                              : 'Update Audit',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PtwAuditDetails extends StatelessWidget {
  final Map<String, dynamic> record;

  const _PtwAuditDetails({required this.record});

  String _label(String key) {
    const labels = {
      'auditNo': 'Audit No.',
      'permitNo': 'Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'permitType': 'Permit Type',
      'auditType': 'Audit Type',
      'trigger': 'Audit Trigger',
      'classification': 'Finding Classification',
      'status': 'Status',
      'frequency': 'Audit Frequency',
      'auditor': 'Auditor',
      'auditDate': 'Audit Date',
      'nextAuditDate': 'Next Audit Date',
      'permitIssueDate': 'Permit Issue Date',
      'permitExpiryDate': 'Permit Expiry Date',
      'workStatus': 'Work Status',
      'permitHolder': 'Permit Holder',
      'issuingAuthority': 'Issuing Authority',
      'auditScope': 'Audit Scope',
      'documentFindings': 'Document Findings',
      'authorizationFindings': 'Authorization Findings',
      'riskFindings': 'Risk Findings',
      'jsaFindings': 'JSA / JHA Findings',
      'ramsFindings': 'RAMS Findings',
      'competencyFindings': 'Competency Findings',
      'equipmentFindings': 'Equipment Findings',
      'isolationFindings': 'Isolation / LOTO Findings',
      'gasTestFindings': 'Gas Test Findings',
      'ppeFindings': 'PPE / Control Findings',
      'siteFindings': 'Site Findings',
      'toolboxFindings': 'Toolbox Talk Findings',
      'extensionFindings': 'Lifecycle Findings',
      'closureFindings': 'Closure Findings',
      'finding': 'Audit Conclusion',
      'findingDetails': 'Finding Details',
      'rootCause': 'Root Cause',
      'immediateAction': 'Immediate Action',
      'correctiveAction': 'Corrective Action',
      'preventiveAction': 'Preventive Action',
      'actionOwner': 'Action Owner',
      'actionDueDate': 'Action Due Date',
      'verificationDate': 'Verification Date',
      'verifiedBy': 'Verified By',
      'effectivenessEvidence': 'Effectiveness Evidence',
      'supportingDocuments': 'Supporting Documents',
      'auditRemarks': 'Audit Remarks',
    };

    return labels[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    const excluded = {
      'createdAt',
      'updatedAt',
      'permitDocumentVerified',
      'authorizationVerified',
      'riskAssessmentVerified',
      'jsaVerified',
      'ramsVerified',
      'competencyVerified',
      'equipmentCertificatesVerified',
      'isolationLotoVerified',
      'gasTestVerified',
      'ppeControlsVerified',
      'siteConditionsVerified',
      'toolboxTalkVerified',
      'extensionSuspensionRevalidationVerified',
      'closureHandoverVerified',
      'correctiveActionRequired',
      'correctiveActionClosed',
      'effectivenessVerified',
    };

    final visible = record.entries.where((entry) {
      return !excluded.contains(entry.key) &&
          entry.value.toString().trim().isNotEmpty;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'PTW Audit Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: visible.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final item = visible[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      _label(item.key),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(item.value.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
