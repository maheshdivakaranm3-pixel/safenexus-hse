import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnvironmentalChecklistPage extends StatefulWidget {
  const EnvironmentalChecklistPage({super.key});

  @override
  State<EnvironmentalChecklistPage> createState() =>
      _EnvironmentalChecklistPageState();
}

class _EnvironmentalChecklistPageState
    extends State<EnvironmentalChecklistPage> {
  static const Color green = Color(0xFF0B5D4B);

  static const Map<String, List<String>> checklists = {
    'A • Document readiness': [
      'Current approved EMP and aspect-impact register available at point of use',
      'Applicable UAE / emirate legal, permit, NOC and client conditions verified',
      'Current method statement, risk assessment and monitoring plan approved',
      'Preparer, reviewer, approver, revision and issue date traceable',
      'Required drawings, approvals, photos, reports and attachments included',
      'Document review trigger and retention basis identified',
    ],
    'B • Site environmental walkdown': [
      'Work boundary, sensitive receptors and drainage pathways identified',
      'Pollution controls installed, suitable, accessible and maintained',
      'Waste streams segregated, labelled and protected from weather / mixing',
      'Chemical and fuel containers sound, closed and compatible',
      'Bunds, drain covers and spill kits inspected where applicable',
      'Dust, noise, vibration, water or soil controls checked for active tasks',
      'Housekeeping and windblown litter controls effective',
      'Defects recorded with owner, due date and interim controls',
    ],
    'C • Waste transfer verification': [
      'Waste stream and classification confirmed by competent process',
      'Carrier and receiving facility authorization/scope checked',
      'Container, vehicle and load condition suitable',
      'Transfer note / manifest quantity and destination complete',
      'Receiving acceptance, weighbridge or treatment evidence received',
      'Inventory reconciled and discrepancy investigated',
    ],
    'D • Monitoring and sampling': [
      'Purpose, parameter, receptor, location and method defined',
      'Competent sampler/operator assigned',
      'Instrument suitability and calibration status checked where applicable',
      'Date, time, activity, weather/context and location recorded',
      'Chain-of-custody and laboratory requirements followed where applicable',
      'Results compared only with applicable approved criteria',
      'Trigger/exceedance escalation and response documented',
    ],
    'E • Emergency and incident': [
      'Emergency contacts and escalation route current and accessible',
      'Crew understands alarm, safe stop, isolation and notification steps',
      'Spill response equipment available and appropriate to credible scenario',
      'Incident facts, timeline, source, pathway and receptor recorded',
      'Authority/client notification obligations checked and evidenced',
      'Corrective actions have owner, deadline and effectiveness check',
    ],
    'F • Audit and close-out': [
      'Audit criteria, scope, sample and evidence sources defined',
      'Findings classified and supported by objective evidence',
      'Legal/permit compliance matrix updated',
      'Corrective action completed and field effectiveness verified',
      'Open permits, commitments and actions handed over',
      'Final records indexed and archived under approved retention schedule',
    ],
  };

  final Map<String, bool> checked = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadChecklist();
  }

  String _key(String group, String item) =>
      'env_check_${group.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}__${item.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}';

  Future<void> _loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    for (final entry in checklists.entries) {
      for (final item in entry.value) {
        checked['${entry.key}::$item'] = prefs.getBool(_key(entry.key, item)) ?? false;
      }
    }
    if (mounted) setState(() => loading = false);
  }

  Future<void> _setChecked(String group, String item, bool value) async {
    setState(() => checked['$group::$item'] = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key(group, item), value);
  }

  @override
  Widget build(BuildContext context) {
    final total = checklists.values.fold<int>(0, (sum, items) => sum + items.length);
    final done = checked.values.where((value) => value).length;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Environmental Checklists'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: loading ? const Center(child: CircularProgressIndicator()) : ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F3EC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Field and Office Verification',
                  style: TextStyle(
                    color: green,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text('$done of $total items checked'),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: total == 0 ? 0 : done / total,
                  color: green,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tick only after evidence or physical verification. This checklist supports, but does not replace, the approved project form or legal inspection.',
                  style: TextStyle(height: 1.4, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ...checklists.entries.map(
            (group) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFE0EAE5)),
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                title: Text(
                  group.key,
                  style: const TextStyle(
                    color: green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                children: group.value.map((item) {
                  final key = '${group.key}::$item';
                  return CheckboxListTile(
                    value: checked[key] ?? false,
                    activeColor: green,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(item, style: const TextStyle(fontSize: 13)),
                    onChanged: (value) =>
                        _setChecked(group.key, item, value ?? false),
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                for (final entry in checklists.entries) {
                  for (final item in entry.value) {
                    await prefs.remove(_key(entry.key, item));
                  }
                }
                setState(checked.clear);
              },
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset checklist'),
            ),
          ),
        ],
      ),
    );
  }
}
