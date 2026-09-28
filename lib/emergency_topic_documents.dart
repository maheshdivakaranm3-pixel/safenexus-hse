import 'package:flutter/material.dart';

/// Topic-specific document register for Emergency & Rescue ER-01 to ER-20.
/// This is a planning checklist, not a substitute for approved site documents.
class EmergencyTopicDocument {
  final String title;
  final String status;
  final String note;
  const EmergencyTopicDocument(this.title, this.status, [this.note = '']);
}

const Map<String, List<EmergencyTopicDocument>> emergencyTopicDocuments = {
  'ER-01': [
    EmergencyTopicDocument('Site Emergency Response Plan (ERP)', 'Required'),
    EmergencyTopicDocument('Emergency Roles & Responsibility Matrix', 'Required'),
    EmergencyTopicDocument('Emergency Contact & Escalation Matrix', 'Required'),
    EmergencyTopicDocument('Emergency Equipment Inventory / Inspection Register', 'Required'),
    EmergencyTopicDocument('Emergency Drill Schedule & Annual Review', 'Required'),
  ],
  'ER-02': [
    EmergencyTopicDocument('Scenario-specific Emergency Response Procedure', 'Required'),
    EmergencyTopicDocument('Emergency Notification / Escalation Flowchart', 'Required'),
    EmergencyTopicDocument('Incident / Emergency Report Form', 'Required'),
    EmergencyTopicDocument('Emergency Response Team Roster', 'Required'),
    EmergencyTopicDocument('Response Debrief & Corrective Action Register', 'Required'),
  ],
  'ER-03': [
    EmergencyTopicDocument('Alarm & Communication Matrix', 'Required'),
    EmergencyTopicDocument('Alarm Test / Inspection Log', 'Required'),
    EmergencyTopicDocument('Radio / Emergency Communication Check Record', 'Required'),
    EmergencyTopicDocument('Emergency Contact List', 'Required'),
    EmergencyTopicDocument('Communication Drill Evaluation', 'Conditional', 'Where included in the site drill programme.'),
  ],
  'ER-04': [
    EmergencyTopicDocument('Site Evacuation Plan & Route Map', 'Required'),
    EmergencyTopicDocument('Evacuation Warden / Area Marshal Register', 'Required'),
    EmergencyTopicDocument('Evacuation Route & Exit Inspection Checklist', 'Required'),
    EmergencyTopicDocument('Evacuation Drill Attendance / Evaluation', 'Required'),
    EmergencyTopicDocument('Special Assistance / PEEP Register', 'Conditional', 'Where persons require assistance to evacuate.'),
  ],
  'ER-05': [
    EmergencyTopicDocument('Assembly Point Layout / Muster Map', 'Required'),
    EmergencyTopicDocument('Personnel Accountability / Headcount Register', 'Required'),
    EmergencyTopicDocument('Visitor & Contractor Sign-in Reconciliation', 'Required'),
    EmergencyTopicDocument('Missing Person Escalation Record', 'Conditional', 'If a person is unaccounted for.'),
    EmergencyTopicDocument('Muster Point Inspection Checklist', 'Required'),
  ],
  'ER-06': [
    EmergencyTopicDocument('Fire Emergency Response Plan', 'Required'),
    EmergencyTopicDocument('Fire Warden / Fire Team Competency Record', 'Required'),
    EmergencyTopicDocument('Fire Extinguisher / Fire Equipment Inspection Register', 'Required'),
    EmergencyTopicDocument('Hot Work Permit & Fire Watch Record', 'Conditional', 'For hot-work activities.'),
    EmergencyTopicDocument('Fire Drill / Alarm Test Record', 'Required'),
  ],
  'ER-07': [
    EmergencyTopicDocument('Medical Emergency Response Procedure', 'Required'),
    EmergencyTopicDocument('First Aider & First Aid Coverage Register', 'Required'),
    Emergency EquipmentDocumentPlaceholder(),
    EmergencyTopicDocument('Ambulance / Clinic Contact & Access Details', 'Required'),
    EmergencyTopicDocument('First Aid / Medical Treatment Incident Record', 'Required'),
  ],
  'ER-08': [
    EmergencyTopicDocument('Confined Space Rescue Plan', 'Required', 'Must match the actual space, hazards, access and rescue method.'),
    EmergencyTopicDocument('Confined Space Entry Permit', 'Required', 'For permit-controlled entry.'),
    EmergencyTopicDocument('Risk Assessment / JSA', 'Required'),
    EmergencyTopicDocument('Gas Testing Record', 'Required', 'Include initial and ongoing tests as specified by the approved procedure.'),
    EmergencyTopicDocument('Authorized Entrant & Standby Person Register', 'Required'),
    EmergencyTopicDocument('Rescue Team Competency / Training Record', 'Required'),
    EmergencyTopicDocument('Rescue Equipment Inspection Checklist', 'Required'),
    EmergencyTopicDocument('Emergency Contact & Communication Matrix', 'Required'),
    EmergencyTopicDocument('Rescue Drill Record', 'Required', 'Scenario-based and documented.'),
  ],
  'ER-09': [
    EmergencyTopicDocument('Work at Height Rescue Plan', 'Required', 'Specific to work location, access, suspension and casualty recovery.'),
    EmergencyTopicDocument('Work at Height Risk Assessment / JSA', 'Required'),
    EmergencyTopicDocument('Work at Height Permit', 'Conditional', 'Where required by site/client permit rules.'),
    EmergencyTopicDocument('Rescue Team Competency / Training Record', 'Required'),
    EmergencyTopicDocument('Harness, Lanyard & Rescue Kit Inspection Register', 'Required'),
    EmergencyTopicDocument('Rescue Drill / Practical Verification Record', 'Required'),
  ],
  'ER-10': [
    EmergencyTopicDocument('Lifting Plan & Lift Risk Assessment', 'Required'),
    EmergencyTopicDocument('Lifting Emergency / Recovery Plan', 'Required', 'Include suspended-load and plant-failure scenarios as applicable.'),
    EmergencyTopicDocument('Lifting Equipment / Accessories Inspection Records', 'Required'),
    EmergencyTopicDocument('Operator, Rigger & Signal Person Competency Records', 'Required'),
    EmergencyTopicDocument('Lift Permit / Authorization', 'Conditional', 'According to lift classification and site rules.'),
    EmergencyTopicDocument('Emergency Drill / Recovery Review', 'Conditional', 'For credible high-consequence scenarios or site drill programme.'),
  ],
  'ER-11': [
    EmergencyTopicDocument('Electrical Shock / Electrical Emergency Procedure', 'Required'),
    EmergencyTopicDocument('Electrical Isolation / LOTO Record', 'Required', 'Only by authorized persons.'),
    EmergencyTopicDocument('Electrical Risk Assessment / JSA', 'Required'),
    EmergencyTopicDocument('Rescue / First Aid & CPR Competency Records', 'Required'),
    EmergencyTopicDocument('Electrical Emergency Equipment Inspection', 'Required'),
    EmergencyTopicDocument('Incident Report & Investigation', 'Required', 'After an event.'),
  ],
  'ER-12': [
    EmergencyTopicDocument('Chemical Spill Response Plan', 'Required'),
    EmergencyTopicDocument('Chemical Inventory & Current SDS', 'Required'),
    EmergencyTopicDocument('Chemical Spill Risk Assessment / Compatibility Review', 'Required'),
    EmergencyTopicDocument('Spill Kit / PPE Inspection Checklist', 'Required'),
    EmergencyTopicDocument('Hazardous Waste Collection / Disposal Record', 'Conditional', 'Where contaminated waste is generated.'),
    EmergencyTopicDocument('Spill Drill / Incident & Corrective Action Record', 'Conditional', 'As required by risk and site programme.'),
  ],
  'ER-13': [
    EmergencyTopicDocument('Traffic / Vehicle Emergency Response Plan', 'Required'),
    EmergencyTopicDocument('Traffic Management Plan & Site Traffic Layout', 'Required'),
    EmergencyTopicDocument('Vehicle / Plant Inspection & Authorization Records', 'Required'),
    EmergencyTopicDocument('Traffic Marshal / Banksman Competency Register', 'Conditional', 'Where marshals are assigned.'),
    EmergencyTopicDocument('Incident Scene / Witness / Investigation Form', 'Required', 'After an incident.'),
  ],
  'ER-14': [
    EmergencyTopicDocument('Machinery Entrapment Rescue / Recovery Procedure', 'Required'),
    EmergencyTopicDocument('Machine-specific Risk Assessment / JSA', 'Required'),
    EmergencyTopicDocument('Isolation / LOTO and Stored Energy Verification', 'Required'),
    EmergencyTopicDocument('Operator / Maintenance Competency Records', 'Required'),
    EmergencyTopicDocument('Machine Guarding & Emergency Stop Inspection', 'Required'),
    EmergencyTopicDocument('Rescue / Recovery Drill or Tabletop Review', 'Conditional', 'Based on assessed risk and site programme.'),
  ],
  'ER-15': [
    EmergencyTopicDocument('Water Rescue / Drowning Response Plan', 'Required', 'Where work involves water or credible drowning exposure.'),
    EmergencyTopicDocument('Water-edge / Flood Risk Assessment', 'Required'),
    EmergencyTopicDocument('Rescue Team Competency & Authorization', 'Required'),
    EmergencyTopicDocument('Lifejacket / Throwline / Rescue Equipment Inspection', 'Required'),
    EmergencyTopicDocument('Rescue Boat / Marine Readiness Records', 'Conditional', 'If rescue craft are provided.'),
    EmergencyTopicDocument('Water Rescue Drill Record', 'Required', 'Where water rescue is part of the emergency arrangement.'),
  ],
  'ER-16': [
    EmergencyTopicDocument('Heat Illness Emergency Response Procedure', 'Required'),
    EmergencyTopicDocument('Heat Stress Risk Assessment & Work/Rest Controls', 'Required'),
    EmergencyTopicDocument('Worker Briefing / Heat Stress Training Record', 'Required'),
    EmergencyTopicDocument('Water, Shade & Welfare Inspection Log', 'Required'),
    EmergencyTopicDocument('Heat Illness First Aid / Incident Record', 'Required', 'If a case occurs.'),
  ],
  'ER-17': [
    EmergencyTopicDocument('Severe Weather / Lightning / Sandstorm Procedure', 'Required'),
    EmergencyTopicDocument('Weather Monitoring & Stop/Resume Authorization Log', 'Required'),
    EmergencyTopicDocument('Shelter / Safe Area Inspection Checklist', 'Required'),
    EmergencyTopicDocument('Crane, Lifting & Temporary Works Weather Controls', 'Conditional', 'Where exposed activities or equipment are present.'),
    EmergencyTopicDocument('Weather Event Debrief / Damage Inspection', 'Conditional', 'After an event.'),
  ],
  'ER-18': [
    EmergencyTopicDocument('Collapse / Trench Failure Rescue Plan', 'Required', 'Prepared for the actual excavation or structural work.'),
    EmergencyTopicDocument('Excavation / Structural Risk Assessment & Method Statement', 'Required'),
    EmergencyTopicDocument('Excavation Permit, Utility Clearance & Inspection Records', 'Conditional', 'For excavation activities and applicable permit systems.'),
    EmergencyTopicDocument('Competent Rescue Team / Specialist Contact Register', 'Required'),
    EmergencyTopicDocument('Rescue Equipment & Access Inspection Checklist', 'Required'),
    EmergencyTopicDocument('Emergency Drill / Scenario Review', 'Conditional', 'According to risk and site plan.'),
  ],
  'ER-19': [
    EmergencyTopicDocument('Gas Leak / Flammable Vapour Emergency Plan', 'Required'),
    EmergencyTopicDocument('Gas Detection / Monitoring Records', 'Required'),
    EmergencyTopicDocument('Isolation / Shutdown & Permit Records', 'Conditional', 'For affected process or work system.'),
    EmergencyTopicDocument('Hazardous Area / Exclusion Zone Layout', 'Required'),
    EmergencyTopicDocument('Emergency Team Competency & PPE Records', 'Required'),
    EmergencyTopicDocument('Gas Release Drill / Debrief Record', 'Required'),
  ],
  'ER-20': [
    EmergencyTopicDocument('Annual / Risk-based Emergency Drill Schedule', 'Required'),
    EmergencyTopicDocument('Drill Scenario, Objectives & Observer Checklist', 'Required'),
    EmergencyTopicDocument('Drill Attendance / Headcount Record', 'Required'),
    EmergencyTopicDocument('Drill Evaluation & Debrief Report', 'Required'),
    EmergencyTopicDocument('Corrective Action Register with Owner / Due Date', 'Required'),
    EmergencyTopicDocument('ERP Review / Revision History', 'Required'),
  ],
};

class EmergencyTopicDocumentsPage extends StatefulWidget {
  const EmergencyTopicDocumentsPage({super.key, required this.topicId, required this.topicTitle});
  final String topicId;
  final String topicTitle;

  @override
  State<EmergencyTopicDocumentsPage> createState() => _EmergencyTopicDocumentsPageState();
}

class _EmergencyTopicDocumentsPageState extends State<EmergencyTopicDocumentsPage> {
  static const Color _green = Color(0xFF0B5D4B);
  final Set<int> _checked = <int>{};

  @override
  Widget build(BuildContext context) {
    final docs = emergencyTopicDocuments[widget.topicId] ?? const <EmergencyTopicDocument>[];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(backgroundColor: _green, foregroundColor: Colors.white,
        title: const Text('Topic-specific Documents')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Text('${widget.topicId} — ${widget.topicTitle}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF17324D))),
        const SizedBox(height: 8),
        const Text('Select and track the office documents applicable to this topic. Confirm final requirements against the current approved site ERP, risk assessment, client rules and competent-person review.'),
        const SizedBox(height: 14),
        Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
          const Icon(Icons.checklist, color: _green), const SizedBox(width: 10),
          Expanded(child: Text('${_checked.length} of ${docs.length} checked', style: const TextStyle(fontWeight: FontWeight.w700))),
          Text('${docs.isEmpty ? 0 : (_checked.length * 100 ~/ docs.length)}%', style: const TextStyle(color: _green, fontWeight: FontWeight.w800)),
        ]))),
        ...docs.asMap().entries.map((entry) {
          final i = entry.key; final doc = entry.value;
          final required = doc.status == 'Required';
          return Card(elevation: 0, margin: const EdgeInsets.only(bottom: 9), child: CheckboxListTile(
            value: _checked.contains(i), activeColor: _green,
            onChanged: (value) => setState(() { if (value == true) { _checked.add(i); } else { _checked.remove(i); } }),
            title: Text(doc.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: required ? const Color(0xFFE2F2E9) : const Color(0xFFFFF1D6), borderRadius: BorderRadius.circular(20)), child: Text(doc.status, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: required ? _green : const Color(0xFF8A5A00)))),
              if (doc.note.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text(doc.note)),
            ]), controlAffinity: ListTileControlAffinity.leading,
          ));
        }),
        const SizedBox(height: 10),
        OutlinedButton.icon(onPressed: () {
          final text = StringBuffer('${widget.topicId} — ${widget.topicTitle}\nTopic-specific HSE Documents Checklist\n\n');
          for (var i = 0; i < docs.length; i++) { text.writeln('${_checked.contains(i) ? '[x]' : '[ ]'} ${docs[i].title} — ${docs[i].status}'); if (docs[i].note.isNotEmpty) text.writeln('    ${docs[i].note}'); }
          text.writeln('\nVerify applicability against approved site arrangements and current authority/client requirements.');
          // Clipboard-free share via the platform share sheet is not needed here; show copyable checklist dialog.
          showDialog<void>(context: context, builder: (ctx) => AlertDialog(title: const Text('Checklist Summary'), content: SingleChildScrollView(child: SelectableText(text.toString())), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close'))]));
        }, icon: const Icon(Icons.fact_check_outlined), label: const Text('View Checklist Summary')),
      ]),
    );
  }
}

