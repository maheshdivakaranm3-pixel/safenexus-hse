import 'package:flutter/material.dart';
import 'environmental_emp_professional_content.dart';

/// Readable EMP field guide using the existing content framework.
/// This is a reference/template view; editing and file export are not yet wired.
class EnvironmentalEmpPage extends StatelessWidget {
  const EnvironmentalEmpPage({super.key});

  static const Color green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F6),
      appBar: AppBar(
        title: const Text('Environmental Management Plan (EMP)'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          _intro(),
          const SizedBox(height: 12),
          const Text('PROJECT INFORMATION',
              style: TextStyle(color: green, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          ...empProjectFields.map((field) => _FieldCard(label: field)),
          const SizedBox(height: 16),
          const Text('JURISDICTION & APPLICABILITY',
              style: TextStyle(color: green, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          ...empApplicabilityGuide.map((item) => Card(
                elevation: 0,
                child: ExpansionTile(
                  title: Text(item.jurisdiction,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text(item.status),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  children: [
                    _paragraph('Basis', item.basis),
                    _paragraph('Project verification', item.projectCheck),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          const Text('EMP CONTENT',
              style: TextStyle(color: green, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          ...environmentalManagementPlanSections.map((section) => Card(
                elevation: 0,
                child: ExpansionTile(
                  leading: const Icon(Icons.description_outlined, color: green),
                  title: Text('${section.id}. ${section.title}',
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    _paragraph('Purpose', section.purpose),
                    _paragraph('Guidance', section.guidance),
                    _paragraph('Required evidence', section.requiredEvidence),
                    _paragraph('Editable project fields',
                        section.editableFields.join('\n• ')),
                    _paragraph('Reference IDs',
                        section.sourceIds.isEmpty ? 'Project-specific verification required' : section.sourceIds.join(', ')),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          const Text('SOURCE REFERENCES',
              style: TextStyle(color: green, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          ...empSourceReferences.map((source) => Card(
                elevation: 0,
                child: ListTile(
                  title: Text(source.title),
                  subtitle: Text('${source.authority}\n${source.note}\n${source.url}'),
                  isThreeLine: true,
                  leading: const Icon(Icons.link, color: green),
                ),
              )),
          const SizedBox(height: 12),
          const Text(
            'Important: this screen is a reference/template, not an authority-approved project EMP. Confirm current legislation, permits, approval conditions, project scope, responsible parties, review dates and retention rules before use.',
            style: TextStyle(fontSize: 12, height: 1.45, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  static Widget _intro() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFE5F3EC),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Text(
          'A project-level plan for identifying environmental aspects and impacts, assigning controls and responsibilities, defining monitoring and reporting, preparing for incidents, and retaining evidence. Complete project-specific fields before controlled issue.',
          style: TextStyle(color: Color(0xFF174D3D), height: 1.45),
        ),
      );

  static Widget _paragraph(String heading, String body) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading,
                style: const TextStyle(
                    color: green, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(body, style: const TextStyle(height: 1.45)),
          ],
        ),
      );
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter project-specific information',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  isDense: true,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      );
}
