import 'package:flutter/material.dart';

class DubaiDetailItem {
  final String title;
  final String subtitle;
  final List<String> details;

  const DubaiDetailItem({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class DubaiDetailSection {
  final String title;
  final String body;

  const DubaiDetailSection(this.title, this.body);
}

class DubaiTopicPage extends StatelessWidget {
  final String title;
  final String emoji;
  final String introduction;
  final List<DubaiDetailSection> sections;
  final List<DubaiDetailItem> tappableItems;

  const DubaiTopicPage({
    super.key,
    required this.title,
    required this.emoji,
    required this.introduction,
    required this.sections,
    required this.tappableItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFFEAF2EF),
        foregroundColor: const Color(0xFF17211E),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 28),
        children: [
          _introCard(context),
          const SizedBox(height: 12),
          ...sections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key, entry.value),
              ),
          const SizedBox(height: 12),
          _exploreHeader(),
          const SizedBox(height: 6),
          ...tappableItems.map((item) => _itemCard(context, item)),
        ],
      ),
    );
  }

  Widget _introCard(BuildContext context) => Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$emoji  Introduction — What is it?',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                introduction,
                style: const TextStyle(fontSize: 15.5, height: 1.5),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tap the small  >  on a section to open Advanced Learning.',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _sectionCard(
    BuildContext context,
    int index,
    DubaiDetailSection section,
  ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          iconColor: const Color(0xFF2B765A),
          collapsedIconColor: const Color(0xFF40564D),
          title: Text(
            section.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: 'Open Advanced Learning',
                icon: const Icon(Icons.chevron_right_rounded, size: 26),
                color: const Color(0xFF237A5C),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScaffoldingAdvancedLearningPage(
                      sectionNumber: index + 1,
                      sectionTitle: _cleanTitle(section.title),
                      body: section.body,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              const Icon(Icons.expand_more_rounded),
            ],
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                section.body,
                style: const TextStyle(fontSize: 15.5, height: 1.5),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScaffoldingAdvancedLearningPage(
                    sectionNumber: index + 1,
                    sectionTitle: _cleanTitle(section.title),
                    body: section.body,
                  ),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFEAF4EF),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Advanced Learning',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, size: 22),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemCard(BuildContext context, DubaiDetailItem item) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(item.subtitle),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DubaiItemPage(item: item)),
          ),
        ),
      );

  Widget _exploreHeader() => const Padding(
        padding: EdgeInsets.fromLTRB(4, 8, 4, 4),
        child: Text(
          '🔎 Tap to explore scaffold types & components',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      );

  String _cleanTitle(String value) => value.replaceFirst(RegExp(r'^.*?\s'), '').trim();
}

class DubaiItemPage extends StatelessWidget {
  final DubaiDetailItem item;

  const DubaiItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFFEAF2EF),
        foregroundColor: const Color(0xFF17211E),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(item.subtitle, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 14),
          ...item.details.map(
            (detail) => Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(detail, style: const TextStyle(fontSize: 15.5, height: 1.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScaffoldingAdvancedLearningPage extends StatelessWidget {
  final int sectionNumber;
  final String sectionTitle;
  final String body;

  const ScaffoldingAdvancedLearningPage({
    super.key,
    required this.sectionNumber,
    required this.sectionTitle,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final learning = _learningFor(sectionNumber, sectionTitle);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: const Color(0xFFEAF2EF),
        foregroundColor: const Color(0xFF17211E),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _heroCard(),
          const SizedBox(height: 12),
          _contentCard('Core Explanation', [body]),
          _contentCard('What to Verify in the Field', learning.fieldChecks),
          _contentCard('Critical Control Points', learning.controls),
          _contentCard('HSE Responsibility', learning.hse),
          _contentCard('Stop-Work Triggers', learning.stopWork),
          _contentCard('Practical Learning Scenario', [learning.scenario]),
          const SizedBox(height: 4),
          Card(
            child: ListTile(
              title: const Text('Deeper Learning', style: TextStyle(fontWeight: FontWeight.w800)),
              subtitle: const Text('Open the practical decision guide for this topic.'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ScaffoldingDeepLearningPage(
                    sectionTitle: sectionTitle,
                    learning: learning,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroCard() => Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$sectionNumber. $sectionTitle',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 7),
              const Text(
                'Professional field-learning guide • Scaffolding Safety',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      );

  Widget _contentCard(String title, List<String> points) => Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 9),
              ...points.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${entry.key + 1}. ', style: const TextStyle(fontWeight: FontWeight.w800)),
                          Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 15.2, height: 1.45))),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      );

  _ScaffoldLearning _learningFor(int number, String title) {
    switch (number) {
      case 1:
        return _ScaffoldLearning(
          fieldChecks: ['Confirm the scaffold purpose, location, expected users and intended work.', 'Check that the selected scaffold arrangement matches the work-at-height task and access needs.', 'Confirm the work area, interfaces, exclusion zones and dropped-object controls are planned.'],
          controls: ['Use a competent planning and erection process.', 'Provide suitable foundation, stability, access and edge protection.', 'Control loads, modifications, interfaces and unauthorised use.'],
          hse: ['Verify that risk controls are understood and implemented before use.', 'Inspect the work area and escalate uncontrolled scaffold risks.', 'Ensure defects and corrective actions are tracked to effective closeout.'],
          stopWork: ['Unplanned or improvised scaffold arrangement.', 'Unstable support, missing critical protection or obvious structural damage.', 'Workers using a scaffold that has not been released through the site inspection/status process.'],
          scenario: 'A façade team requests immediate access. HSE checks the planned arrangement, foundation, access, edge protection, loading and status before allowing use.',
        );
      case 2:
        return _ScaffoldLearning.fromLists(
          ['Identify the scaffold type and its intended duty.', 'Check system compatibility, manufacturer/system instructions and configuration.', 'Confirm special arrangements such as mobile, suspended or cantilever systems have appropriate controls.'],
          ['Do not mix incompatible components.', 'Do not improvise support or stability arrangements.', 'Ensure movement, suspension, anchorage or cantilever controls are specifically addressed where applicable.'],
          ['Verify the selected type is suitable for the task and environment.', 'Challenge deviations from the approved arrangement.', 'Confirm competent-person control for specialist arrangements.'],
          ['Unknown scaffold configuration.', 'Missing stability controls or unsuitable surface.', 'Unapproved modification or use outside intended purpose.'],
          'A mobile tower is requested on an uneven work area. The team stops and selects a suitable controlled access arrangement rather than improvising packing or movement controls.',
        );
      case 3:
        return _ScaffoldLearning.fromLists(
          ['Trace the load path from platform through transoms, ledgers, standards, base plates and supporting ground.', 'Check guardrails, intermediate rails, toe boards and access components.', 'Inspect couplers, braces, ties, castors and jacks where present.'],
          ['Maintain complete load path and stability.', 'Keep critical components installed and secured.', 'Replace damaged components and prevent incompatible or improvised parts.'],
          ['HSE should verify critical components during field inspections.', 'Any component affecting stability or fall protection requires immediate attention.', 'Modification must be controlled by competent personnel.'],
          ['Missing brace/tie.', 'Damaged load-bearing component.', 'Unsecured platform or incomplete edge protection.'],
          'During inspection, a damaged transom is found below a working platform. The platform is isolated until the competent team restores the approved arrangement and verifies it.',
        );
      case 4:
        return _ScaffoldLearning.fromLists(
          ['Check foundation and load distribution.', 'Verify platform, edge protection, access, bracing, ties and intended loading.', 'Use approved design/system information for dimensions and configuration rather than guessing field values.'],
          ['Follow the approved scaffold design and manufacturer/system instructions.', 'Prevent overloading and concentrated loads.', 'Maintain stability throughout the full life of the scaffold.'],
          ['HSE verifies field implementation against approved controls.', 'Engineering/competent scaffold personnel address design or configuration issues.', 'Do not approve unsafe deviations based only on visual appearance.'],
          ['Unverified configuration.', 'Overloading or unsuitable support.', 'Missing engineered stability controls.'],
          'A scaffold looks complete but its loading requirement has changed. Work pauses while the competent team confirms whether the configuration remains suitable.',
        );
      case 5:
        return _ScaffoldLearning.fromLists(
          ['Review erection sequence, exclusion zone, access for erectors and material handling.', 'Check progressive stability, bracing, ties and protection during erection.', 'During dismantling, maintain stability and remove components progressively.'],
          ['Keep unauthorised people outside the erection/dismantling zone.', 'Never remove stability components prematurely.', 'Control falling objects and maintain a safe sequence.'],
          ['HSE monitors critical controls and intervenes when sequence or exclusion controls fail.', 'Competent scaffold personnel control technical erection/dismantling.', 'Supervision must match the risk and complexity.'],
          ['Erection without planned sequence.', 'Stability compromised during dismantling.', 'People entering the exclusion zone.'],
          'During dismantling, a tie is proposed for early removal. Work stops until the competent person confirms the safe sequence and an alternative stability arrangement if required.',
        );
      case 6:
        return _ScaffoldLearning.fromLists(
          ['Inspect foundation, standards, ledgers, transoms, bracing, ties and platforms.', 'Check guardrails, toe boards, access, loading, damage and unauthorised changes.', 'Re-inspect after significant changes or events that may affect stability.'],
          ['Inspection must be systematic and traceable.', 'Defects affecting safety require isolation/correction.', 'Do not rely on the tag alone.'],
          ['HSE verifies inspection status and field condition.', 'Defects are assigned, corrected and re-verified.', 'Competent persons make technical decisions on scaffold condition.'],
          ['Critical defect.', 'Inspection status cannot be confirmed.', 'Scaffold altered after inspection without re-verification.'],
          'After strong wind, the scaffold appears visually normal. The site follows its re-inspection requirement before workers return to the platform.',
        );
      case 7:
        return _ScaffoldLearning.fromLists(
          ['Confirm the site tag/status system is present and current.', 'Verify the physical scaffold condition matches the communicated status.', 'Ensure workers understand what the site status means.'],
          ['Tagging communicates status; it does not replace inspection.', 'Remove/withdraw status when the scaffold becomes unsafe according to site procedure.', 'Control access to scaffolds not released for use.'],
          ['HSE checks status during field inspections.', 'Supervision prevents use of restricted scaffolds.', 'Workers report visible defects even when a tag appears acceptable.'],
          ['Missing/unclear status.', 'Condition inconsistent with status.', 'Worker cannot confirm authorised use.'],
          'A green-status tag is visible but a guardrail has been removed after the inspection. The scaffold is treated as unsafe until reassessed and status is restored through the site process.',
        );
      case 8:
        return _ScaffoldLearning.fromLists(
          ['Identify what component or configuration has changed.', 'Assess effect on stability, load path, access and fall protection.', 'Confirm competent approval and re-inspection before release.'],
          ['No unauthorised removal of ties, braces, guardrails or platforms.', 'Maintain the approved configuration.', 'Reassess after changes.'],
          ['HSE challenges uncontrolled modifications.', 'Competent scaffold personnel determine technical acceptability.', 'Supervision controls who may modify the scaffold.'],
          ['Any unauthorised modification.', 'Critical component removed.', 'Configuration differs from approved arrangement.'],
          'A worker removes a toe board to move material. The activity is stopped, the opening is restored and the modification is reviewed before work resumes.',
        );
      case 9:
        return _ScaffoldLearning.fromLists(
          ['Look for instability, missing edge protection, damaged platforms, unsafe access and overloading.', 'Check for environmental conditions that affect stability or safe use.', 'Isolate the affected area when a critical defect is identified.'],
          ['Stop-work authority must be clear.', 'Protect people from the hazard before technical correction.', 'Resume only after competent verification and required status update.'],
          ['HSE identifies and escalates critical conditions.', 'Supervisors secure the area and control the workforce.', 'Competent persons assess technical stability.'],
          ['Collapse/instability indicators.', 'Critical fall protection failure.', 'Unsafe access or uncontrolled modification.'],
          'A missing required tie is discovered during a pre-start check. Workers are kept off the scaffold until the stability arrangement is corrected and verified.',
        );
      case 10:
        return _ScaffoldLearning.fromLists(
          ['Confirm the competent person has suitable knowledge and authority for the scaffold arrangement.', 'Review inspection, modification and release controls.', 'Ensure defects are not passed to workers as acceptable conditions.'],
          ['Technical decisions remain with competent scaffold personnel.', 'HSE provides independent verification and escalation.', 'Workers receive clear instructions on safe use and reporting.'],
          ['HSE Officer: field verification and intervention.', 'HSE Supervisor: daily coordination and closeout.', 'Senior HSE/HSE Engineer/Manager: assurance and escalation for significant risk.'],
          ['Competence cannot be demonstrated.', 'Critical defect is accepted without technical assessment.', 'Unauthorised person directs technical modification.'],
          'A complex scaffold modification is requested by a work supervisor. HSE does not approve it informally; the request is referred to the competent scaffold team for technical control.',
        );
      case 11:
        return _ScaffoldLearning.fromLists(
          ['Confirm workers use approved access and platforms.', 'Check housekeeping, loading and correct use of guardrails.', 'Verify workers do not remove or alter scaffold components.'],
          ['Follow site instructions and work-at-height requirements.', 'Report defects immediately.', 'Respect status and exclusion controls.'],
          ['HSE communicates critical scaffold rules and verifies compliance.', 'Supervisors reinforce safe use during daily work.', 'Workers are responsible for reporting unsafe conditions.'],
          ['Unsafe climbing.', 'Component removal.', 'Overloading or unsafe access.'],
          'A worker climbs the outside of the scaffold rather than using the designed access. Work is corrected and the safe access route is reinforced.',
        );
      case 12:
        return _ScaffoldLearning.fromLists(
          ['Know the emergency plan for fall, collapse, falling-object and medical scenarios.', 'Keep emergency access routes clear.', 'Do not enter or attempt rescue from an unstable scaffold unless the rescue plan and competent responders permit it.'],
          ['Raise alarm and isolate the area.', 'Prevent secondary casualties.', 'Use trained rescue/medical arrangements.'],
          ['HSE supports emergency coordination, scene control and reporting.', 'Supervision accounts for workers and controls access.', 'Emergency responders operate within competence and plan.'],
          ['Collapse/instability.', 'Uncontrolled rescue attempt.', 'Secondary exposure to falling objects.'],
          'A worker falls and the scaffold becomes unstable. The area is isolated and the emergency plan is activated rather than sending unprotected workers onto the scaffold.',
        );
      case 13:
        return _ScaffoldLearning.fromLists(
          ['Break the situation into hazard, immediate control, competent assessment, correction, verification and release.', 'Record significant findings according to site procedure.', 'Check that corrective action is effective, not merely completed on paper.'],
          ['Immediate isolation where required.', 'Technical correction by competent personnel.', 'Verification before restart.'],
          ['HSE observes, intervenes, coordinates and verifies.', 'Construction supervision controls the work sequence.', 'Competent scaffold personnel control technical changes.'],
          ['Immediate danger.', 'Control not implemented.', 'Work resumes before verification.'],
          'A façade crew finds a missing tie. The correct response is STOP → EXCLUDE → ASSESS → CORRECT → RE-INSPECT → STATUS → RESUME.',
        );
      default:
        return _ScaffoldLearning.fromLists(
          ['Use the learning formula as a field verification sequence.', 'Check each critical control rather than relying on appearance.', 'Escalate uncertainty before work continues.'],
          ['BASE → FRAME → BRACE → TIE → PLATFORM → GUARDRAIL → ACCESS → LOAD → INSPECT → TAG → USE.', 'Keep the sequence simple enough for toolbox communication.', 'Use site-specific approved requirements for technical decisions.'],
          ['HSE verifies the critical controls and records significant findings.', 'Supervision maintains operational discipline.', 'Competent persons make technical scaffold decisions.'],
          ['Any critical control cannot be verified.', 'Unsafe condition is observed.', 'Work method or scaffold configuration changes without reassessment.'],
          'Before a shift starts, the HSE team walks the sequence from base to platform and status. Any failed control is corrected before release.',
        );
    }
  }
}

class ScaffoldingDeepLearningPage extends StatelessWidget {
  final String sectionTitle;
  final _ScaffoldLearning learning;

  const ScaffoldingDeepLearningPage({
    super.key,
    required this.sectionTitle,
    required this.learning,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Practical Decision Guide'),
        backgroundColor: const Color(0xFFEAF2EF),
        foregroundColor: const Color(0xFF17211E),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(sectionTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          _decisionCard('1. PLAN', 'Understand the work, scaffold purpose, configuration, users, loading and interfaces.'),
          _decisionCard('2. VERIFY', 'Check the actual field condition against the approved arrangement and site controls.'),
          _decisionCard('3. CONTROL', 'Apply immediate barriers, isolation, competent technical correction and supervision.'),
          _decisionCard('4. RE-CHECK', 'Inspect the corrected condition and confirm the control is effective.'),
          _decisionCard('5. RELEASE', 'Only resume when the responsible competent process and site status allow use.'),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Field Questions', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  ...[...learning.fieldChecks, ...learning.stopWork]
                      .asMap()
                      .entries
                      .map((entry) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('${entry.key + 1}. ${entry.value}', style: const TextStyle(fontSize: 15.2, height: 1.45)),
                          )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _decisionCard(String title, String body) => Card(
        margin: const EdgeInsets.only(bottom: 9),
        child: ListTile(
          leading: const Icon(Icons.chevron_right_rounded),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(body, style: const TextStyle(height: 1.4)),
          ),
        ),
      );
}

class _ScaffoldLearning {
  final List<String> fieldChecks;
  final List<String> controls;
  final List<String> hse;
  final List<String> stopWork;
  final String scenario;

  const _ScaffoldLearning({
    required this.fieldChecks,
    required this.controls,
    required this.hse,
    required this.stopWork,
    required this.scenario,
  });

  factory _ScaffoldLearning.fromLists(
    List<String> fieldChecks,
    List<String> controls,
    List<String> hse,
    List<String> stopWork,
    String scenario,
  ) => _ScaffoldLearning(
        fieldChecks: fieldChecks,
        controls: controls,
        hse: hse,
        stopWork: stopWork,
        scenario: scenario,
      );
}

class ScaffoldingSafetyPage extends StatelessWidget {
  const ScaffoldingSafetyPage({super.key});

  static const types = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Fixed / Static Scaffold', subtitle: 'Ground-supported temporary scaffold', details: [
      'What: A scaffold erected in a fixed position to provide access and working platforms.',
      'Uses: Building construction, façade work, maintenance and inspection.',
      'Controls: Stable foundation, correct erection sequence, bracing, ties where required, safe access and inspection.',
      'Hazards: Falls, collapse, falling objects and overloading.',
    ]),
    DubaiDetailItem(title: 'Independent Scaffold', subtitle: 'Self-supporting scaffold framework', details: [
      'What: A scaffold with its own supporting framework.',
      'Controls: Correct base arrangement, framework stability, bracing, access and designed loading.',
    ]),
    DubaiDetailItem(title: 'Tied Scaffold', subtitle: 'Scaffold connected to a supporting structure', details: [
      'Purpose: Ties provide stability and help control movement.',
      'Critical control: Required ties must not be removed or altered without competent assessment and an approved control arrangement.',
    ]),
    DubaiDetailItem(title: 'Mobile Scaffold', subtitle: 'Scaffold mounted on wheels/castors', details: [
      'What: A scaffold designed for controlled movement between approved work locations.',
      'Controls: Castors locked during use; stable level surface; safe access; suitable configuration; never move with workers on the scaffold.',
      'Stop work: Unlocked wheels, unstable surface, damaged structure or unsafe movement.',
    ]),
    DubaiDetailItem(title: 'Tower Scaffold', subtitle: 'Vertical scaffold arrangement', details: [
      'Purpose: Elevated access and work from a tower configuration.',
      'Controls: Stable base, complete bracing, safe access, edge protection and configuration suitable for its designed height and loading.',
    ]),
    DubaiDetailItem(title: 'Access Scaffold', subtitle: 'Primarily designed for access', details: [
      'Focus: Safe access route, landings, handrails, platforms and housekeeping.',
    ]),
    DubaiDetailItem(title: 'Birdcage Scaffold', subtitle: 'Multi-level working framework', details: [
      'Focus: Overall stability, internal access, platform protection and control of imposed loads.',
    ]),
    DubaiDetailItem(title: 'Suspended Scaffold', subtitle: 'Platform suspended from overhead support', details: [
      'Focus: Suspension system, supporting structure, secondary protection, safe movement controls and inspection.',
    ]),
    DubaiDetailItem(title: 'Cantilever Scaffold', subtitle: 'Supported from a structure rather than ground', details: [
      'Focus: Structural support, anchorage, design verification, stability and controlled loading.',
      'Rule: Never improvise support arrangements.',
    ]),
    DubaiDetailItem(title: 'System Scaffold', subtitle: 'Prefabricated modular system', details: [
      'Focus: Correct compatible components, approved connections, system instructions and designed configuration.',
    ]),
    DubaiDetailItem(title: 'Tube & Fitting Scaffold', subtitle: 'Tubes joined with couplers/fittings', details: [
      'Focus: Tube condition, couplers, bracing, ties, platforms and safe access.',
    ]),
    DubaiDetailItem(title: 'Special-Purpose Scaffold', subtitle: 'Designed for a specific requirement', details: [
      'Use: Where a standard arrangement is not suitable.',
      'Focus: Specific design, support, loading, stability, access and competent control.',
    ]),
  ];

  static const components = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Standard (Vertical Member)', subtitle: 'Main vertical load-bearing member', details: [
      'Function: Transfers vertical loads through the scaffold framework to the base.',
      'Checks: Position, vertical alignment, condition, connections and base support.',
    ]),
    DubaiDetailItem(title: 'Ledger', subtitle: 'Longitudinal horizontal member', details: [
      'Function: Connects standards and contributes to the scaffold framework.',
      'Checks: Correct connections, level/alignment and component condition.',
    ]),
    DubaiDetailItem(title: 'Transom', subtitle: 'Cross member supporting the platform', details: [
      'Function: Supports platform components and connects the scaffold across its width.',
      'Checks: Correct seating, condition and configuration.',
    ]),
    DubaiDetailItem(title: 'Base Plate', subtitle: 'Base load-distribution component', details: [
      'Function: Provides a suitable interface between the standard and base arrangement.',
      'Checks: Correct placement, condition and supporting surface.',
    ]),
    DubaiDetailItem(title: 'Sole Board', subtitle: 'Ground/load-distribution support', details: [
      'Function: Helps distribute loads where required by the design and ground condition.',
      'Rule: Do not use unstable improvised packing.',
    ]),
    DubaiDetailItem(title: 'Brace', subtitle: 'Stiffness and stability member', details: [
      'Function: Resists movement and contributes to stability.',
      'Rule: Never remove required bracing without competent assessment and control.',
    ]),
    DubaiDetailItem(title: 'Tie', subtitle: 'Connection to supporting structure', details: [
      'Function: Provides stability against movement.',
      'Rule: Required ties must remain controlled as part of the approved arrangement.',
    ]),
    DubaiDetailItem(title: 'Coupler', subtitle: 'Tube/component connector', details: [
      'Function: Connects tubes/components in tube-and-fitting systems.',
      'Checks: Correct type, condition, installation and secure connection.',
    ]),
    DubaiDetailItem(title: 'Platform', subtitle: 'Working surface', details: [
      'Function: Provides a safe working area.',
      'Checks: Support, secure positioning, suitable duty/load, sound condition, housekeeping and no dangerous gaps.',
    ]),
    DubaiDetailItem(title: 'Guardrail / Handrail', subtitle: 'Edge protection', details: [
      'Function: Reduces fall risk at exposed platform edges.',
      'Checks: Secure fixing, suitable arrangement and no unprotected working edge.',
    ]),
    DubaiDetailItem(title: 'Intermediate Rail', subtitle: 'Additional edge protection', details: [
      'Function: Reduces open-edge exposure between platform and upper protection.',
      'Checks: Secure and complete edge protection arrangement.',
    ]),
    DubaiDetailItem(title: 'Toe Board', subtitle: 'Low-level edge protection', details: [
      'Function: Helps prevent people and materials falling from platform edges.',
      'Checks: Secure installation and suitable arrangement for the platform.',
    ]),
    DubaiDetailItem(title: 'Access Ladder', subtitle: 'Controlled access between levels', details: [
      'Function: Provides a safe route to platforms.',
      'Checks: Secure installation, suitable landing and clear access.',
    ]),
    DubaiDetailItem(title: 'Scaffold Stair', subtitle: 'Stair-type access', details: [
      'Function: Provides stair-type movement between levels where designed.',
      'Checks: Handrails, treads, landings, housekeeping and safe access.',
    ]),
    DubaiDetailItem(title: 'Castor / Wheel', subtitle: 'Mobile scaffold movement component', details: [
      'Function: Enables controlled movement of mobile scaffolds.',
      'Checks: Condition, locking mechanism and compatibility with the system.',
    ]),
    DubaiDetailItem(title: 'Base Jack', subtitle: 'Designed base adjustment/support', details: [
      'Function: Provides controlled adjustment/support where designed.',
      'Checks: Correct installation, load path and approved adjustment range.',
    ]),
    DubaiDetailItem(title: 'Scaffold Tag', subtitle: 'Inspection/status communication', details: [
      'Function: Communicates the site inspection/status system.',
      'Rule: A tag does not replace visual checks or reporting of defects.',
    ]),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection('📏 3. Technical Requirements', 'Platform: properly supported, secure, suitable for intended duty/load and free from dangerous gaps. Guardrails: suitable edge protection, secure fixing and no unprotected working edge. Toe boards: installed and secured where required. Foundation: stable support and proper load distribution. Bracing and ties: installed and maintained according to the approved design/system. Loading: never exceed designed capacity and avoid concentrated loads. Exact dimensions or load values must follow the applicable Dubai requirement, approved scaffold design and manufacturer/system instructions.'),
    DubaiDetailSection('⚠️ 4. Main Scaffolding Hazards', 'Falls from height; scaffold collapse; falling tools/materials; overloading; unstable foundation; missing bracing or ties; unsafe access; damaged platforms; unauthorised modification; mobile scaffold movement; adverse weather.'),
    DubaiDetailSection('🔧 5. Erection & Dismantling', 'Safe sequence: PLAN → ASSESS → EXCLUDE → ERECT PROGRESSIVELY → MAINTAIN STABILITY → INSTALL PROTECTION → INSPECT → TAG → USE. Dismantling must be planned, the area isolated, falling objects controlled, stability maintained and components removed progressively and safely.'),
    DubaiDetailSection('🔍 6. Inspection', 'Check foundation, base plates, standards, ledgers, transoms, bracing, ties, platforms, guardrails, toe boards, access, loading, damage, unauthorised modifications and inspection/status information. Re-inspect after changes or events that may affect stability.'),
    DubaiDetailSection('🏷️ 7. Scaffold Tagging', 'Use the site tagging/status system to communicate inspection and authorised-use status. Never rely on the tag alone; workers must report visible defects and unsafe conditions.'),
    DubaiDetailSection('🔄 8. Modification & Control', 'Workers must not independently remove guardrails, ties or braces, alter platforms, add unauthorised loading or change scaffold configuration. Modifications must be assessed and controlled by competent personnel.'),
    DubaiDetailSection('🛑 9. Stop-Work Conditions', 'Stop immediately for instability, critical missing edge protection, deteriorated foundation, missing required ties/bracing, damaged platform, overloading, unsafe access, unauthorised modification or weather conditions that compromise safety.'),
    DubaiDetailSection('👷 10. Competent Person Responsibilities', 'Plan scaffold activities within competency; control erection/dismantling; inspect; identify defects; control modifications; verify stability; recommend corrective action; prevent unauthorised use.'),
    DubaiDetailSection('👷 11. Worker Responsibilities', 'Use only approved scaffolds; follow site instructions; report unsafe conditions; never remove scaffold components; never exceed loading limits; maintain housekeeping; use safe access; follow work-at-height requirements.'),
    DubaiDetailSection('🚨 12. Emergency Response', 'Scaffold collapse/instability/fall: STOP → ALARM → EXCLUDE → DO NOT ENTER AN UNSTABLE AREA → FOLLOW EMERGENCY/RESCUE PLAN → FIRST AID WITHIN COMPETENCE → REPORT & INVESTIGATE.'),
    DubaiDetailSection('👷 13. Practical Site Example', 'Situation: A façade team is using a tied scaffold and one required tie has been removed. HSE response: STOP WORK → isolate affected area → competent-person stability assessment → restore/control the approved tie arrangement → re-inspect → confirm status → resume only after verification.'),
    DubaiDetailSection('🧠 14. Quick Learning Formula', 'BASE → FRAME → BRACE → TIE → PLATFORM → GUARDRAIL → ACCESS → LOAD → INSPECT → TAG → USE'),
  ];

  @override
  Widget build(BuildContext context) => DubaiTopicPage(
        title: 'Scaffolding Safety',
        emoji: '🏗️',
        introduction: 'Scaffolding is a temporary structure used to provide safe access, working platforms and fall protection for construction, maintenance, inspection and other work-at-height activities. A scaffold must be properly planned, suitable for its intended purpose, erected by competent persons, inspected, maintained and safely dismantled.',
        sections: sections,
        tappableItems: [...types, ...components],
      );
}
