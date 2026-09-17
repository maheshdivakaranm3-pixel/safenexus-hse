import 'package:flutter/material.dart';

import 'data/abu_dhabi_hse_topics.dart';
import 'data/abu_dhabi_hse_topic_content.dart';
import 'models/reference_topic.dart';

class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;

  const AbuDhabiHseTopicPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  String _masterId(ReferenceTopic topic) => topic.id;

  Widget _section(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text(
                        '•',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: primaryGreen,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = abuDhabiHseTopicContent[_masterId(topic)];

    // CoP 1.0 gets the advanced interactive learning/reference experience.
    if (topic.id == 'ad_cop_1_0' && content != null) {
      return AbuDhabiCop10LearningPage(
        topic: topic,
        content: content,
      );
    }

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(
          topic.shortTitle,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 21,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text(topic.shortTitle)),
                      Chip(label: Text(topic.category)),
                      Chip(label: Text(topic.jurisdiction)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (content != null) ...[
            _section('Overview', [content.overview]),
            _section('Deep Study', content.deepStudy),
            _section('Micro-Detail', content.microDetails),
            _section('Field Practical', content.fieldPractical),
            _section('Inspection Checklist', content.inspectionChecklist),
            _section('Emergency / Response', content.emergencyResponse),
            _section('Records & Evidence', content.records),
            _section('Interview Questions', content.interviewQuestions),
            _section(
              'Regulatory Verification',
              content.regulatoryVerification,
            ),
          ] else ...[
            _section('Overview', [topic.description]),
            _section('Key Requirements', topic.keyRequirements),
            _section('Safety Controls', topic.safetyControls),
            _section('Responsibilities', topic.responsibilities),
            _section('References', topic.references),
          ],
        ],
      ),
    );
  }
}

/// Advanced interactive learning page for Abu Dhabi CoP 1.0.
///
/// Existing CoP 1.0 regulatory content is preserved. This page adds a deeper
/// navigation layer so the user can study a point, open it, and then review
/// practical HSE guidance around that point.
class AbuDhabiCop10LearningPage extends StatelessWidget {
  final ReferenceTopic topic;
  final AbuDhabiHseTopicContent content;

  const AbuDhabiCop10LearningPage({
    super.key,
    required this.topic,
    required this.content,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<_Cop10Section> _sections() {
    return [
      _Cop10Section('Overview', content.overview),
      _Cop10Section('Deep Study', content.deepStudy.join('\n• ')),
      _Cop10Section('Micro-Detail', content.microDetails.join('\n• ')),
      _Cop10Section('Field Practical', content.fieldPractical.join('\n• ')),
      _Cop10Section(
        'Inspection Checklist',
        content.inspectionChecklist.join('\n• '),
      ),
      _Cop10Section(
        'Emergency / Response',
        content.emergencyResponse.join('\n• '),
      ),
      _Cop10Section('Records & Evidence', content.records.join('\n• ')),
      _Cop10Section(
        'Interview Questions',
        content.interviewQuestions.join('\n• '),
      ),
      _Cop10Section(
        'Regulatory Verification',
        content.regulatoryVerification.join('\n• '),
      ),
    ].where((section) => section.body.trim().isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sections = _sections();

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('CoP 1.0 — Study & Reference'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 22,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Abu Dhabi ADPHC • Advanced Learning / Field Reference',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Tap any section below. On the next page, each point is individually tappable for a more focused explanation and field-reference view.',
                    style: TextStyle(fontSize: 15.5, height: 1.45),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...sections.asMap().entries.map(
                (entry) => _sectionCard(context, entry.key + 1, entry.value),
              ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    int number,
    _Cop10Section section,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AbuDhabiCop10PointPage(
                sectionTitle: section.title,
                body: section.body,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: darkGreen,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: darkGreen),
            ],
          ),
        ),
      ),
    );
  }
}

class _Cop10Section {
  final String title;
  final String body;

  const _Cop10Section(this.title, this.body);
}

/// Second-level page: every bullet/point can be tapped for micro-detail.
class AbuDhabiCop10PointPage extends StatelessWidget {
  final String sectionTitle;
  final String body;

  const AbuDhabiCop10PointPage({
    super.key,
    required this.sectionTitle,
    required this.body,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<String> _points() {
    return body
        .split('\n')
        .map((line) => line.trim())
        .map((line) => line.startsWith('• ') ? line.substring(2) : line)
        .where((line) => line.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final points = _points();

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(
          sectionTitle,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.touch_app, color: primaryGreen, size: 25),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      points.length > 1
                          ? 'Tap each point below to study it separately.'
                          : 'Tap the point below to open the focused study view.',
                      style: const TextStyle(fontSize: 15, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...points.asMap().entries.map(
                (entry) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AbuDhabiCop10MicroDetailPage(
                            sectionTitle: sectionTitle,
                            pointNumber: entry.key + 1,
                            point: entry.value,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryGreen.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: darkGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              entry.value,
                              style: const TextStyle(
                                fontSize: 15.5,
                                height: 1.45,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8, top: 4),
                            child: Icon(
                              Icons.chevron_right,
                              color: darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

/// Third-level micro-detail page. It deliberately explains rather than
/// rewriting the underlying Abu Dhabi requirement.
class AbuDhabiCop10MicroDetailPage extends StatelessWidget {
  final String sectionTitle;
  final int pointNumber;
  final String point;

  const AbuDhabiCop10MicroDetailPage({
    super.key,
    required this.sectionTitle,
    required this.pointNumber,
    required this.point,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  String _explanation() {
    if (sectionTitle == 'Regulatory Verification') {
      return 'Use this point as a verification step. Check the current official Abu Dhabi ADPHC CoP, its applicable version, linked ADOSH-SF requirements and the actual site activity before treating any regulatory statement as mandatory.';
    }
    if (sectionTitle == 'Inspection Checklist') {
      return 'During a field inspection, verify this point physically where possible. Compare what is observed with the approved risk assessment, method statement, procedure and applicable Abu Dhabi requirement. Record evidence and track deficiencies to closure.';
    }
    if (sectionTitle == 'Emergency / Response') {
      return 'This point should be connected to the site emergency plan. Confirm that the response is practical for the actual material, task, location, people exposed and available emergency resources. Avoid creating secondary exposure during rescue or response.';
    }
    if (sectionTitle == 'Interview Questions') {
      return 'For interview preparation, answer using a clear sequence: identify the hazard, assess the risk, apply the hierarchy of controls, verify implementation in the field, communicate with the workforce, and document/close corrective actions.';
    }
    if (sectionTitle == 'Records & Evidence') {
      return 'A good HSE record should be current, traceable and connected to the actual activity. During an audit, explain what the document proves, who approved it, when it was reviewed and how field implementation was verified.';
    }
    if (sectionTitle == 'Field Practical') {
      return 'In the field, do not rely only on paperwork. Walk the work area, speak with the workers, verify critical controls, check equipment and conditions, and stop/reassess the activity when a serious uncontrolled hazard is identified.';
    }
    if (sectionTitle == 'Micro-Detail') {
      return 'Treat this as a field-level verification point. Ask: What can go wrong? Who can be exposed? What control prevents it? How do I physically verify that control? What evidence should I record if it is missing?' ;
    }
    return 'Study this point together with the complete CoP 1.0 content. Understand the hazard, the reason for the control, the people affected, the required evidence and how the control is verified in the workplace. Do not substitute generic guidance for the current official Abu Dhabi requirement.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: Text(
          'Point $pointNumber',
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sectionTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    point,
                    style: const TextStyle(
                      fontSize: 19,
                      height: 1.4,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _infoCard('Study Explanation', Icons.school, _explanation()),
          _infoCard(
            'HSE Officer Field Check',
            Icons.fact_check_outlined,
            'Verify the actual work condition, worker understanding, control implementation and supporting evidence. If the control is not effective, follow the site stop-work / escalation and corrective-action process.',
          ),
          _infoCard(
            'Remember',
            Icons.lightbulb_outline,
            'The purpose of SafeNexus HSE is to help you understand and verify the requirement. The official Abu Dhabi source remains the regulatory reference for compliance decisions.',
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String title, IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 15.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
