// lib/data/abu_dhabi/abu_dhabi_scaffolding_reference_page.dart
//
// SafeNexus HSE - Abu Dhabi HSE Reference
// CoP 26.0 – Scaffolding V4.1 field-reference UI
// Includes subject introduction, standard scrollable field-reference UI.

import 'package:flutter/material.dart';

import 'cop_26_scaffolding_v4_1.dart';

class AbuDhabiScaffoldingReferencePage extends StatefulWidget {
  const AbuDhabiScaffoldingReferencePage({super.key});

  @override
  State<AbuDhabiScaffoldingReferencePage> createState() =>
      _AbuDhabiScaffoldingReferencePageState();
}

class _AbuDhabiScaffoldingReferencePageState
    extends State<AbuDhabiScaffoldingReferencePage> {
  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);
  static const Color pageBackground = Color(0xFFF4F8FB);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sections = AbuDhabiCop26Scaffolding.sections;
    final matchingChecklist = AbuDhabiCop26Scaffolding.fieldChecklist;
    final matchingStopWork = AbuDhabiCop26Scaffolding.stopWorkIndicators;
    final matchingPrecautions = AbuDhabiCop26Scaffolding.safetyPrecautions;
    final matchingTypes = AbuDhabiCop26Scaffolding.scaffoldTypes;
    final matchingComponents = AbuDhabiCop26Scaffolding.scaffoldComponents;
    final matchingGreenTag = AbuDhabiCop26Scaffolding.greenTagProcedure;
    final matchingRedTag = AbuDhabiCop26Scaffolding.redTagConditions;
    final matchingMeasurements = AbuDhabiCop26Scaffolding.keyMeasurements;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Abu Dhabi HSE'),
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _headerCard(),
                    ...[
                      const SizedBox(height: 14),
                      _whatIsScaffoldingCard(),
                    ],
                    if (matchingPrecautions.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _bulletCard(
                        title: 'Scaffolding Safety Precautions',
                        icon: Icons.security_rounded,
                        color: green,
                        items: matchingPrecautions,
                      ),
                    ],
                    if (matchingTypes.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _bulletCard(
                        title: 'Types of Scaffolding',
                        icon: Icons.account_tree_rounded,
                        color: green,
                        items: matchingTypes,
                      ),
                    ],
                    if (matchingComponents.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _bulletCard(
                        title: 'Important Scaffold Components',
                        icon: Icons.construction_rounded,
                        color: green,
                        items: matchingComponents,
                      ),
                    ],
                    if (matchingGreenTag.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _bulletCard(
                        title: 'Green Scafftag — Inspection & Release for Use',
                        icon: Icons.verified_rounded,
                        color: green,
                        items: matchingGreenTag,
                      ),
                    ],
                    if (matchingRedTag.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _bulletCard(
                        title: 'Red Scafftag — Do Not Use Conditions',
                        icon: Icons.dangerous_rounded,
                        color: const Color(0xFFC62828),
                        items: matchingRedTag,
                      ),
                    ],
                    ...[
                      const SizedBox(height: 14),
                      _tagStatusNoteCard(),
                    ],
                    if (matchingMeasurements.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      _quickReferenceCard(matchingMeasurements),
                    ],
                    if (sections.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      for (final section in sections)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _sectionCard(section),
                        ),
                    ],
                    if (matchingChecklist.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      _bulletCard(
                        title: 'Field Checklist',
                        icon: Icons.checklist_rounded,
                        color: green,
                        items: matchingChecklist,
                      ),
                    ],
                    if (matchingStopWork.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      _bulletCard(
                        title: 'Stop-Work Indicators',
                        icon: Icons.stop_circle_outlined,
                        color: const Color(0xFFC62828),
                        items: matchingStopWork,
                      ),
                    ],
                  ],
                ),
            ),
        ],
      ),
    );
  }

  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CoP 26.0 – Scaffolding',
            style: TextStyle(
              color: navy,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'ADOSH-SF • Version 4.1 • 16 February 2026',
            style: TextStyle(
              color: green,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Abu Dhabi HSE field reference for scaffold planning, design, erection, use, alteration, dismantling and inspection.',
            style: TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _whatIsScaffoldingCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 17, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: green.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.menu_open_rounded, color: green, size: 25),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'What is Scaffolding?',
                  style: TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Scaffolding is a temporary access and working structure assembled from scaffold components to provide safe working platforms and access for people carrying out work at height. CoP 26.0 covers planning, assessment, design where required, erection, use, alteration, maintenance, dismantling and inspection.',
            style: TextStyle(
              color: Color(0xFF455A64),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          _introPoint('Purpose',
              'Provide stable working platforms and safe access for work at height.'),
          _introPoint('Where it is used',
              'Construction, maintenance, inspection, repair, finishing and other temporary work activities.'),
          _introPoint('Main risks',
              'Falls from height, falling objects, scaffold instability, overloading, unsafe access and unsafe alteration or dismantling.'),
          _introPoint('Core precautions',
              'Use competent persons, suitable design/manufacturer instructions, stable foundations, effective ties and bracing, secured platforms, edge protection, safe access, load control and planned inspection.'),
          _introPoint('Types covered',
              'Modular/system, tube-and-coupler, suspended, swinging-stage, hanging-bracket, freestanding, static-tower and mobile-access-tower arrangements, plus specified special-purpose configurations.'),
          _introPoint('Abu Dhabi basis',
              'ADPHC / ADOSH-SF Code of Practice CoP 26.0 – Scaffolding, Version 4.1, dated 16 February 2026.'),
        ],
      ),
    );
  }

  Widget _introPoint(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Color(0xFF455A64),
                  fontSize: 12.5,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagStatusNoteCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: green.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.local_offer_rounded, color: green, size: 24),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Scafftag Status — Field Meaning',
                  style: TextStyle(
                    color: navy,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _introPoint(
            'Green',
            'Scaffold has been inspected and accepted for the stated intended use, subject to its marked loading and restrictions.',
          ),
          _introPoint(
            'Red',
            'Do Not Use. Scaffold is incomplete, unsafe, failed inspection, awaiting required re-inspection, or otherwise not released for use.',
          ),
          _introPoint(
            'Important',
            AbuDhabiCop26Scaffolding.tagStatusNote,
          ),
        ],
      ),
    );
  }

  Widget _quickReferenceCard(List<Cop26QuickReference> items) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.straighten_rounded, color: green, size: 25),
              SizedBox(width: 9),
              Text(
                'Key Measurements',
                style: TextStyle(
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.item,
                      style: const TextStyle(
                        color: Color(0xFF455A64),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      item.requirement,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionCard(Cop26Section section) {
    final filteredSubsections = section.subsections;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        iconColor: green,
        collapsedIconColor: green,
        title: Text(
          '${section.number}  ${section.title}',
          style: const TextStyle(
            color: navy,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: section.summary == null
            ? null
            : Text(
                section.summary!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
        children: [
          if (section.hazards.isNotEmpty) ...[
            _label('Hazards'),
            for (final item in _visibleList(section.hazards)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.measurements.isNotEmpty) ...[
            _label('Measurements'),
            for (final item in _visibleList(section.measurements)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.requirements.isNotEmpty) ...[
            _label('Requirements'),
            for (final item in _visibleList(section.requirements)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.controlHierarchy.isNotEmpty) ...[
            _label('Hierarchy of Controls'),
            for (final item in _visibleList(section.controlHierarchy)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.documents.isNotEmpty) ...[
            _label('Documents'),
            for (final item in _visibleList(section.documents)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (filteredSubsections.isNotEmpty) ...[
            _label('Detailed Subsections'),
            for (final subsection in filteredSubsections)
              _subsectionCard(subsection),
          ],
          if (section.trainingRecordFields.isNotEmpty) ...[
            _label('Training Record Fields'),
            for (final item in _visibleList(section.trainingRecordFields))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionFrequency.isNotEmpty) ...[
            _label('Inspection Frequency'),
            for (final item in _visibleList(section.inspectionFrequency))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionPoints.isNotEmpty) ...[
            _label('Inspection Points'),
            for (final item in _visibleList(section.inspectionPoints))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionRecordFields.isNotEmpty) ...[
            _label('Inspection Record Fields'),
            for (final item in _visibleList(section.inspectionRecordFields))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.scaffoldTagFields.isNotEmpty) ...[
            _label('Scaffold Tag Fields'),
            for (final item in _visibleList(section.scaffoldTagFields))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.stopWorkExamples.isNotEmpty) ...[
            _label('Stop-Work Examples'),
            for (final item in _visibleList(section.stopWorkExamples))
              _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.fieldWarning != null) ...[
            _label('Field Warning'),
            _bullet(section.fieldWarning!),
            const SizedBox(height: 8),
          ],
          if (section.references.isNotEmpty) ...[
            _label('References'),
            for (final item in _visibleList(section.references)) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.amendments.isNotEmpty) ...[
            _label('Amendment Record'),
            for (final item in section.amendments)
              if (true) // Search filtering removed
                '${item.version} ${item.date} ${item.description} ${item.pagesAffected}',
              ))
                _bullet(
                  '${item.version} • ${item.date} • ${item.description} • ${item.pagesAffected}',
                ),
          ],
        ],
      ),
    );
  }

  List<String> _visibleList(List<String> items) => items;

  Widget _subsectionCard(Cop26Subsection subsection) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        title: Text(
          '${subsection.number}  ${subsection.title}',
          style: const TextStyle(
            color: navy,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        children: [
          if (subsection.measurements.isNotEmpty) ...[
            _label('Measurements'),
            for (final item in _visibleList(subsection.measurements))
              _bullet(item),
            const SizedBox(height: 6),
          ],
          if (subsection.requirements.isNotEmpty) ...[
            _label('Requirements'),
            for (final item in _visibleList(subsection.requirements)) _bullet(item),
          ],
          if (subsection.controlHierarchy.isNotEmpty) ...[
            const SizedBox(height: 6),
            _label('Hierarchy of Controls'),
            for (final item in _visibleList(subsection.controlHierarchy))
              _bullet(item),
          ],
          if (subsection.officialReferences.isNotEmpty) ...[
            const SizedBox(height: 6),
            _label('Official References'),
            for (final item in _visibleList(subsection.officialReferences))
              _bullet(item),
          ],
        ],
      ),
    );
  }

  Widget _bulletCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 25),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final item in items) _bullet(item),
        ],
      ),
    );
  }

  Widget _noSearchResultsCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, color: green, size: 38),
          SizedBox(height: 8),
          Text(
            'No matching content found',
            style: TextStyle(
              color: navy,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try another keyword such as guardrail, inspection, ladder, platform or dismantling.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(
          color: green,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: green,
              fontWeight: FontWeight.w900,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF455A64),
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
