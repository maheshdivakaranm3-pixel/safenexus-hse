import 'package:flutter/material.dart';

class EnvironmentalOfficeDocumentsPage extends StatelessWidget {
  const EnvironmentalOfficeDocumentsPage({super.key});

  static const Color green = Color(0xFF0B5D4B);

  static const List<_DocumentGroup> groups = [
    _DocumentGroup('01 • Governance & document control', [
      'Environmental Policy and commitments',
      'Environmental Management Plan (EMP)',
      'Environmental aspects and impacts register',
      'Environmental legal / permit / NOC register',
      'Environmental objectives, targets and action plan',
      'Document master register, revision history and distribution list',
      'Management review minutes and action tracker',
    ]),
    _DocumentGroup('02 • Permits, approvals & submissions', [
      'Environmental permit / approval and conditions register',
      'EIA / screening / authority submission and approval evidence',
      'NOC, utility and municipal approvals where applicable',
      'Permit-condition compliance matrix and due-date tracker',
      'Authority correspondence, notifications and approvals',
    ]),
    _DocumentGroup('03 • Waste management', [
      'Waste management plan and waste stream inventory',
      'Waste classification / characterization evidence where needed',
      'Waste storage inspection and inventory log',
      'Carrier / contractor authorization and due diligence',
      'Waste transfer notes, manifests, weighbridge tickets',
      'Receiving facility acceptance, recycling or disposal certificates',
      'Monthly waste reconciliation and reporting',
    ]),
    _DocumentGroup('04 • Pollution prevention & monitoring', [
      'Aspect-specific pollution prevention method statements',
      'Air / noise / vibration / water / soil monitoring plan as applicable',
      'Sampling plan, chain-of-custody and laboratory reports',
      'Instrument suitability, calibration and maintenance records',
      'Inspection, monitoring results, exceedance and response records',
      'Drain, bund, spill kit and pollution-control equipment checks',
    ]),
    _DocumentGroup('05 • Training & competency', [
      'Environmental induction and toolbox talk materials',
      'Attendance and understanding / competency records',
      'Role-specific specialist competency evidence',
      'Contractor environmental briefing and acknowledgement',
    ]),
    _DocumentGroup('06 • Emergency, incident & corrective action', [
      'Environmental emergency response plan and contact list',
      'Spill / release / complaint / incident reports',
      'Authority / client notification evidence where required',
      'Investigation, root-cause and corrective-action register',
      'Drill plan, attendance, evaluation and improvement actions',
    ]),
    _DocumentGroup('07 • Inspection, audit & reporting', [
      'Daily / weekly / monthly inspection records as project-defined',
      'Internal and external audit plans, reports and findings',
      'Legal compliance evaluation and evidence matrix',
      'KPI definitions, validated data and periodic reports',
      'Corrective-action closure and effectiveness verification',
    ]),
    _DocumentGroup('08 • Close-out & retention', [
      'Environmental handover / close-out dossier index',
      'Open obligations, permits and action handover',
      'Restoration / remediation verification and sign-off where applicable',
      'Records retention and archive index',
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Environmental Office Documents'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          const _IntroCard(),
          const SizedBox(height: 12),
          ...groups.map(
            (group) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFE0EAE5)),
              ),
              child: ExpansionTile(
                iconColor: green,
                collapsedIconColor: green,
                title: Text(
                  group.title,
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                children: group.items
                    .map(
                      (item) => ListTile(
                        leading: const Icon(
                          Icons.description_outlined,
                          color: green,
                        ),
                        title: Text(item),
                        subtitle: const Text(
                          'Open the document control record for applicability, owner, approval, review and evidence.',
                        ),
                        onTap: () => _showDocumentGuide(context, item),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Applicability note: classify each item as legally required, permit-conditioned, project/client-required or recommended only after checking the current official requirement and contract. Validity, review interval and retention period are not universal; record the actual source and approved schedule.',
              style: TextStyle(color: Colors.black54, height: 1.45, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static void _showDocumentGuide(BuildContext context, String name) {
    const fields = <String>[
      'Document name and unique reference / revision',
      'Definition and purpose — what it records and why it is needed',
      'Applicability classification: legal / permit / project / recommended',
      'Preparer and source information',
      'Reviewer, technical verifier and authorized approver',
      'Preparation timing, submission deadline and trigger for update',
      'Validity, review frequency and change-control trigger',
      'Required attachments, drawings, permits, photos, data and signatures',
      'Site verification: physical check, interview, sampling or traceability',
      'Record storage, access control and retention source / period',
      'Common errors, corrective action and close-out evidence',
      'Practical example and accountable owner',
    ];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFFF4F8F6),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.82,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: green,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Document control and field verification guide',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...fields.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 13,
                          backgroundColor: const Color(0xFFE1F2E9),
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              color: green,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(entry.value)),
                      ],
                    ),
                  ),
                ),
            const SizedBox(height: 10),
            const Text(
              'Record the actual authority / permit / client source. Do not invent a universal approval role, validity period, retention duration or legal requirement.',
              style: TextStyle(color: Colors.black54, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE5F3EC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          'Separate environmental office-document library. Each record must identify its purpose, applicability, preparer, reviewer/approver, timing, validity or review trigger, attachments, field verification, retention basis and common errors.',
          style: TextStyle(color: Color(0xFF174D3D), height: 1.45),
        ),
      );
}

class _DocumentGroup {
  const _DocumentGroup(this.title, this.items);
  final String title;
  final List<String> items;
}
