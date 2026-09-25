// lib/data/abu_dhabi/abu_dhabi_scaffolding_reference_page.dart
//
// SafeNexus HSE - Abu Dhabi HSE Reference
// CoP 26.0 – Scaffolding V4.1 field-reference UI

import 'package:flutter/material.dart';

import 'cop_26_scaffolding_v4_1.dart';

class AbuDhabiScaffoldingReferencePage extends StatelessWidget {
  const AbuDhabiScaffoldingReferencePage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        title: const Text('Abu Dhabi HSE'),
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
        children: [
          _headerCard(),
          const SizedBox(height: 14),
          _quickReferenceCard(),
          const SizedBox(height: 14),
          for (final section in AbuDhabiCop26Scaffolding.sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _sectionCard(section),
            ),
          _bulletCard(
            title: 'Field Checklist',
            icon: Icons.checklist_rounded,
            color: green,
            items: AbuDhabiCop26Scaffolding.fieldChecklist,
          ),
          const SizedBox(height: 12),
          _bulletCard(
            title: 'Stop-Work Indicators',
            icon: Icons.stop_circle_outlined,
            color: const Color(0xFFC62828),
            items: AbuDhabiCop26Scaffolding.stopWorkIndicators,
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

  Widget _quickReferenceCard() {
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
          for (final item in AbuDhabiCop26Scaffolding.keyMeasurements)
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
            for (final item in section.hazards) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.measurements.isNotEmpty) ...[
            _label('Measurements'),
            for (final item in section.measurements) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.requirements.isNotEmpty) ...[
            _label('Requirements'),
            for (final item in section.requirements) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.controlHierarchy.isNotEmpty) ...[
            _label('Hierarchy of Controls'),
            for (final item in section.controlHierarchy) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.documents.isNotEmpty) ...[
            _label('Documents'),
            for (final item in section.documents) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.subsections.isNotEmpty) ...[
            _label('Detailed Subsections'),
            for (final subsection in section.subsections)
              _subsectionCard(subsection),
          ],
          if (section.trainingRecordFields.isNotEmpty) ...[
            _label('Training Record Fields'),
            for (final item in section.trainingRecordFields) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionFrequency.isNotEmpty) ...[
            _label('Inspection Frequency'),
            for (final item in section.inspectionFrequency) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionPoints.isNotEmpty) ...[
            _label('Inspection Points'),
            for (final item in section.inspectionPoints) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.inspectionRecordFields.isNotEmpty) ...[
            _label('Inspection Record Fields'),
            for (final item in section.inspectionRecordFields) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.scaffoldTagFields.isNotEmpty) ...[
            _label('Scaffold Tag Fields'),
            for (final item in section.scaffoldTagFields) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.fieldWarning != null) ...[
            _label('Field Warning'),
            _bullet(section.fieldWarning!),
            const SizedBox(height: 8),
          ],
          if (section.references.isNotEmpty) ...[
            _label('References'),
            for (final item in section.references) _bullet(item),
            const SizedBox(height: 8),
          ],
          if (section.amendments.isNotEmpty) ...[
            _label('Amendment Record'),
            for (final item in section.amendments)
              _bullet(item.version + ' • ' + item.date + ' • ' + item.description),
          ],
        ],
      ),
    );
  }

  Widget _subsectionCard(Cop26Subsection subsection) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8FB),
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
            for (final item in subsection.measurements) _bullet(item),
            const SizedBox(height: 6),
          ],
          if (subsection.requirements.isNotEmpty) ...[
            _label('Requirements'),
            for (final item in subsection.requirements) _bullet(item),
          ],
          if (subsection.controlHierarchy.isNotEmpty) ...[
            const SizedBox(height: 6),
            _label('Hierarchy of Controls'),
            for (final item in subsection.controlHierarchy) _bullet(item),
          ],
          if (subsection.officialReferences.isNotEmpty) ...[
            const SizedBox(height: 6),
            _label('Official References'),
            for (final item in subsection.officialReferences) _bullet(item),
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
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
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
