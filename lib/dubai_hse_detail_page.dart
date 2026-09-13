import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

/// SafeNexus HSE - Dubai HSE Detail
///
/// Dubai-only detail experience. Existing ReferenceTopic data remains the
/// source for the topic requirements; this page adds a field-oriented view,
/// English/Malayalam labels, a practical verification checklist and current
/// official Dubai Municipality reference links.
class DubaiHseDetailPage extends StatefulWidget {
  final ReferenceTopic topic;

  const DubaiHseDetailPage({
    super.key,
    required this.topic,
  });

  @override
  State<DubaiHseDetailPage> createState() => _DubaiHseDetailPageState();
}

class _DubaiHseDetailPageState extends State<DubaiHseDetailPage> {
  bool _malayalam = false;

  ReferenceTopic get topic => widget.topic;

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFF374151);

  String get _malayalamTitle {
    const titles = <String, String>{
      'dubai_construction_safety': 'ദുബായ് നിർമ്മാണ സുരക്ഷാ ചട്ടക്കൂട്',
      'dubai_hse_management': 'HSE മാനേജ്മെന്റ് സംവിധാനം',
      'dubai_risk_assessment': 'ആരോഗ്യ-സുരക്ഷാ റിസ്ക് അസസ്മെന്റ്',
      'dubai_hse_plan': 'നിർമ്മാണ HSE പ്ലാൻ',
      'dubai_work_at_height': 'ഉയരത്തിൽ ജോലി',
      'dubai_scaffolding': 'സ്കാഫോൾഡിംഗ് സുരക്ഷ',
      'dubai_lifting': 'ലിഫ്റ്റിംഗ് & ക്രെയിൻ സുരക്ഷ',
      'dubai_excavation': 'എക്സ്കവേഷൻ / ട്രെഞ്ചിംഗ് സുരക്ഷ',
      'dubai_confined_space': 'കൺഫൈൻഡ് സ്പേസ് സുരക്ഷ',
      'dubai_electrical': 'ഇലക്ട്രിക്കൽ സുരക്ഷ',
      'dubai_hot_work': 'ഹോട്ട് വർക്ക് സുരക്ഷ',
      'dubai_traffic': 'സൈറ്റ് ട്രാഫിക് മാനേജ്മെന്റ്',
      'dubai_demolition': 'ഡിമോളിഷൻ സുരക്ഷ',
      'dubai_temporary_works': 'ടെംപററി വർക്സ് സുരക്ഷ',
      'dubai_heat_stress': 'ഹീറ്റ് സ്ട്രെസ് മാനേജ്മെന്റ്',
      'dubai_occupational_health': 'തൊഴിൽ ആരോഗ്യ സുരക്ഷ',
      'dubai_ppe': 'വ്യക്തിഗത സംരക്ഷണ ഉപകരണങ്ങൾ',
      'dubai_emergency': 'എമർജൻസി തയ്യാറെടുപ്പ്',
      'dubai_incident': 'ഇൻസിഡന്റ് റിപ്പോർട്ടിംഗ് & ഇൻവെസ്റ്റിഗേഷൻ',
      'dubai_contractor': 'കോൺട്രാക്ടർ HSE മാനേജ്മെന്റ്',
      'dubai_environment': 'നിർമ്മാണ പരിസ്ഥിതി നിയന്ത്രണം',
      'dubai_inspection': 'ഇൻസ്പെക്ഷൻ & മോണിറ്ററിംഗ്',
      'dubai_performance': 'HSE പെർഫോമൻസ് & തുടർച്ചയായ മെച്ചപ്പെടുത്തൽ',
      'dubai_building_code': 'ദുബായ് ബിൽഡിംഗ് കോഡ് — HSE',
      'dubai_permit_to_work': 'പെർമിറ്റ് ടു വർക്ക് സംവിധാനം',
    };
    return titles[topic.id] ?? topic.title;
  }

  String _t(String english, String malayalam) =>
      _malayalam ? malayalam : english;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          _t('Dubai HSE', 'ദുബായ് HSE'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: () => setState(() => _malayalam = !_malayalam),
              child: Text(
                _malayalam ? 'EN' : 'മലയാളം',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              _infoCard(),
              const SizedBox(height: 16),
              _section(
                _t('Overview', 'അവലോകനം'),
                Icons.info_outline,
                Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _listSection(
                _t('Key Requirements', 'പ്രധാന ആവശ്യകതകൾ'),
                Icons.checklist_outlined,
                topic.keyRequirements,
              ),
              const SizedBox(height: 16),
              _listSection(
                _t('Safety Controls', 'സുരക്ഷാ നിയന്ത്രണങ്ങൾ'),
                Icons.health_and_safety_outlined,
                topic.safetyControls,
              ),
              const SizedBox(height: 16),
              _listSection(
                _t('Responsibilities', 'ചുമതലകൾ'),
                Icons.groups_outlined,
                topic.responsibilities,
              ),
              const SizedBox(height: 16),
              _fieldChecklist(),
              const SizedBox(height: 16),
              _emergencySection(),
              const SizedBox(height: 16),
              _referenceSection(),
              const SizedBox(height: 16),
              _notice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, Color(0xFF087F5B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DUBAI HSE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _malayalam ? _malayalamTitle : topic.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _t(
              'Complete practical guidance for Dubai HSE field use',
              'ദുബായ് HSE ഫീൽഡ് ഉപയോഗത്തിനുള്ള സമഗ്ര പ്രായോഗിക മാർഗ്ഗനിർദ്ദേശം',
            ),
            style: TextStyle(
              color: Colors.white.withValues(alpha: .9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard() {
    return _section(
      _t('Authority & Jurisdiction', 'അധികാരിയും പരിധിയും'),
      Icons.account_balance_outlined,
      Column(
        children: [
          _row(_t('Authority', 'അധികാരി'), topic.authority),
          const SizedBox(height: 10),
          _row(_t('Jurisdiction', 'പരിധി'), topic.jurisdiction),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: textSecondary, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _section(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          child,
        ],
      ),
    );
  }

  Widget _listSection(String title, IconData icon, List<String> items) {
    return _section(
      title,
      icon,
      Column(
        children: List.generate(items.length, (index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == items.length - 1 ? 0 : 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(Icons.check_circle, size: 17, color: primaryGreen),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      color: textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _fieldChecklist() {
    final items = _malayalam
        ? const [
            'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് risk assessment / JSA പരിശോധിക്കുക.',
            'അംഗീകൃത method statement / safe work procedure ലഭ്യമാണെന്ന് ഉറപ്പാക്കുക.',
            'അവശ്യമായ permit, isolation, inspection, competency എന്നിവ verify ചെയ്യുക.',
            'പ്രദേശത്ത് barricade, signage, access/egress, housekeeping എന്നിവ പരിശോധിക്കുക.',
            'ഉപകരണങ്ങളും PPE-യും ഉപയോഗത്തിന് മുമ്പ് പരിശോധിക്കുക.',
            'അപകടാവസ്ഥ, മാറ്റം, weather condition എന്നിവ വന്നാൽ ജോലി നിർത്തി controls വീണ്ടും പരിശോധിക്കുക.',
            'Supervisor pre-start briefing രേഖപ്പെടുത്തുക.',
            'ജോലി പൂർത്തിയായ ശേഷം area safe ആക്കി permit/inspection records close ചെയ്യുക.',
          ]
        : const [
            'Review the risk assessment / JSA before starting work.',
            'Verify the approved method statement / safe work procedure is available.',
            'Verify required permits, isolations, inspections and competency.',
            'Check barricading, signage, access/egress and housekeeping.',
            'Inspect equipment and PPE before use.',
            'Stop and reassess if conditions, hazards or weather change.',
            'Record the supervisor pre-start briefing.',
            'Make the area safe and close required permits/inspection records after work.',
          ];

    return _section(
      _t('Field Verification Checklist', 'ഫീൽഡ് വെരിഫിക്കേഷൻ ചെക്ക്ലിസ്റ്റ്'),
      Icons.fact_check_outlined,
      Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.square_outlined, size: 20, color: primaryGreen),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(item, style: const TextStyle(height: 1.45, color: textSecondary)),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _emergencySection() {
    return _section(
      _t('Emergency & Stop-Work', 'എമർജൻസി & സ്റ്റോപ്പ്-വർക്ക്'),
      Icons.emergency_outlined,
      Text(
        _malayalam
            ? 'ഗുരുതരമായ അപകടം, unsafe condition, loss of control, fire, collapse, exposure അല്ലെങ്കിൽ emergency ഉണ്ടായാൽ ജോലി നിർത്തുക, ആളുകളെ സുരക്ഷിത സ്ഥലത്തേക്ക് മാറ്റുക, site emergency procedure അനുസരിക്കുക, ആവശ്യമായ emergency services / responsible management-നെ അറിയിക്കുക. സ്ഥിതി നിയന്ത്രിക്കപ്പെടുന്നതുവരെ ജോലി പുനരാരംഭിക്കരുത്.'
            : 'For a serious incident, unsafe condition, loss of control, fire, collapse, hazardous exposure or other emergency: stop the work, protect people from further exposure, follow the site emergency procedure, notify responsible management and emergency services as applicable, and do not restart until the area is assessed and controls are restored.',
        style: const TextStyle(height: 1.55, color: textSecondary),
      ),
    );
  }

  Widget _referenceSection() {
    final official = _malayalam
        ? const [
            'Dubai Municipality — Health & Safety Technical Guidelines List',
            'Dubai Municipality — Building Publications / Construction Work Safety Guide',
            'Dubai Municipality — Laws and Legislations',
            'Dubai Municipality — Dubai Building Code',
          ]
        : const [
            'Dubai Municipality — Health & Safety Technical Guidelines List',
            'Dubai Municipality — Building Publications / Construction Work Safety Guide',
            'Dubai Municipality — Laws and Legislations',
            'Dubai Municipality — Dubai Building Code',
          ];

    return _section(
      _t('Official Dubai References', 'ഔദ്യോഗിക ദുബായ് റഫറൻസുകൾ'),
      Icons.menu_book_outlined,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...topic.references.map(
            (ref) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Text('• $ref', style: const TextStyle(height: 1.45, color: textSecondary)),
            ),
          ),
          const Divider(height: 22),
          ...official.map(
            (ref) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Text('• $ref', style: const TextStyle(height: 1.45, color: textSecondary)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Text(
        _t(
          'SafeNexus HSE summarizes requirements for practical field use. Always verify the latest official Dubai Municipality publication, legislation, project requirements and approved company procedures before relying on a requirement.',
          'SafeNexus HSE പ്രായോഗിക ഫീൽഡ് ഉപയോഗത്തിനായി ആവശ്യകതകൾ സംഗ്രഹിക്കുന്നു. ഒരു requirement പ്രയോഗിക്കുന്നതിന് മുമ്പ് ഏറ്റവും പുതിയ Dubai Municipality publication, legislation, project requirements, approved company procedures എന്നിവ പരിശോധിക്കുക.',
        ),
        style: const TextStyle(fontSize: 12.5, height: 1.5, color: textSecondary),
      ),
    );
  }
}
