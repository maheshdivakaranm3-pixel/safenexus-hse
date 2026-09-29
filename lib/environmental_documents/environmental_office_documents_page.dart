import 'package:flutter/material.dart';
import 'environmental_emp_page.dart';
import 'environmental_editable_document_page.dart';

/// Environmental office-document library. Applicability, authority, approval,
/// validity and retention must be confirmed against the live project requirements.
class EnvironmentalOfficeDocumentsPage extends StatelessWidget {
  const EnvironmentalOfficeDocumentsPage({super.key});
  static const Color green = Color(0xFF0B5D4B);

  static const List<_DocumentGroup> groups = [
    _DocumentGroup('Governance & document control', [
      'Environmental Policy and commitments',
      'Environmental Management Plan (EMP)',
      'Environmental aspects and impacts register',
      'Environmental legal / permit / NOC register',
      'Environmental objectives, targets and action plan',
      'Document master register, revision history and distribution list',
      'Management review minutes and action tracker',
    ]),
    _DocumentGroup('Permits, approvals & submissions', [
      'Environmental permit / approval and conditions register',
      'EIA / screening / authority submission and approval evidence',
      'NOC, utility and municipal approvals where applicable',
      'Permit-condition compliance matrix and due-date tracker',
      'Authority correspondence, notifications and approvals',
    ]),
    _DocumentGroup('Waste management', [
      'Waste management plan and waste stream inventory',
      'Waste classification / characterization evidence where needed',
      'Waste storage inspection and inventory log',
      'Carrier / contractor authorization and due diligence',
      'Waste transfer notes, manifests, weighbridge tickets',
      'Receiving facility acceptance, recycling or disposal certificates',
      'Monthly waste reconciliation and reporting',
    ]),
    _DocumentGroup('Pollution prevention & monitoring', [
      'Aspect-specific pollution prevention method statements',
      'Air / noise / vibration / water / soil monitoring plan as applicable',
      'Sampling plan, chain-of-custody and laboratory reports',
      'Instrument suitability, calibration and maintenance records',
      'Inspection, monitoring results, exceedance and response records',
      'Drain, bund, spill kit and pollution-control equipment checks',
    ]),
    _DocumentGroup('Training & competency', [
      'Environmental induction and toolbox talk materials',
      'Attendance and understanding / competency records',
      'Role-specific specialist competency evidence',
      'Contractor environmental briefing and acknowledgement',
    ]),
    _DocumentGroup('Emergency, incident & corrective action', [
      'Environmental emergency response plan and contact list',
      'Spill / release / complaint / incident reports',
      'Authority / client notification evidence where required',
      'Investigation, root-cause and corrective-action register',
      'Drill plan, attendance, evaluation and improvement actions',
    ]),
    _DocumentGroup('Inspection, audit & reporting', [
      'Daily / weekly / monthly inspection records as project-defined',
      'Internal and external audit plans, reports and findings',
      'Legal compliance evaluation and evidence matrix',
      'KPI definitions, validated data and periodic reports',
      'Corrective-action closure and effectiveness verification',
    ]),
    _DocumentGroup('Close-out & retention', [
      'Environmental handover / close-out dossier index',
      'Open obligations, permits and action handover',
      'Restoration / remediation verification and sign-off where applicable',
      'Records retention and archive index',
    ]),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF4F8F6),
    appBar: AppBar(title: const Text('Environmental Office Documents'), backgroundColor: green, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFE5F3EC), borderRadius: BorderRadius.circular(15)), child: const Text(
        'Document-by-document field guide. Each record explains its purpose, ownership, preparation and review, evidence, verification and control of revisions. Confirm legal, permit, client and contract applicability for the actual project; this library does not assign universal validity or retention periods.',
        style: TextStyle(color: Color(0xFF174D3D), height: 1.45))),
      const SizedBox(height: 12),
      ...groups.map((group) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFE0EAE5))), child: ExpansionTile(
        iconColor: green, collapsedIconColor: green,
        title: Text(group.title, style: const TextStyle(color: green, fontWeight: FontWeight.w800)),
        children: group.items.map((name) => ListTile(
          leading: const Icon(Icons.description_outlined, color: green), title: Text(name),
          subtitle: const Text('Open the dedicated document guide'),
          trailing: const Icon(Icons.chevron_right, color: green),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => name == 'Environmental Management Plan (EMP)'
                  ? const EnvironmentalEmpPage()
                  : EnvironmentalEditableDocumentPage(name: name, group: group.title),
            ),
          ),
        )).toList(),
      ))),
    ]),
  );
}

class _DocumentGroup { const _DocumentGroup(this.title, this.items); final String title; final List<String> items; }
