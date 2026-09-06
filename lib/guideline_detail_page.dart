import 'package:flutter/material.dart';

import 'guidelines.dart';

class GuidelineDetailPage extends StatelessWidget {
final ReferenceTopic topic;

const GuidelineDetailPage({
super.key,
required this.topic,
});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xFFF6F8F7),
appBar: AppBar(
title: Text(
topic.title,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontWeight: FontWeight.w800,
),
),
backgroundColor: Colors.white,
foregroundColor: Colors.black87,
elevation: 0,
),
body: SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildHeroCard(),
const SizedBox(height: 16),

          _officialReferenceCard(),

          _infoCard(
            icon: Icons.menu_book_rounded,
            title: 'What is it?',
            content: topic.overview,
          ),

          _infoCard(
            icon: Icons.warning_amber_rounded,
            title: 'Main Hazards',
            content: topic.hazards,
            bulletStyle: true,
          ),

          _infoCard(
            icon: Icons.shield_rounded,
            title: 'Risk Controls',
            content: topic.controls,
            bulletStyle: true,
          ),

          _infoCard(
            icon: Icons.assignment_rounded,
            title: 'Planning & Preparation',
            content: topic.planning,
          ),

          _infoCard(
            icon: Icons.engineering_rounded,
            title: 'Safe Work Practices',
            content: topic.safePractices,
          ),

          _infoCard(
            icon: Icons.health_and_safety_rounded,
            title: 'PPE',
            content: topic.ppe,
            bulletStyle: true,
          ),

          _checklistCard(),

          _infoCard(
            icon: Icons.search_rounded,
            title: 'Inspection Points',
            content: topic.inspection,
            bulletStyle: true,
          ),

          _doDontCard(
            title: 'Do',
            icon: Icons.check_circle_outline_rounded,
            content: topic.dos,
            isPositive: true,
          ),

          _doDontCard(
            title: 'Do Not',
            icon: Icons.cancel_outlined,
            content: topic.donts,
            isPositive: false,
          ),

          _stopWorkCard(),

          _infoCard(
            icon: Icons.emergency_rounded,
            title: 'Emergency Response',
            content: topic.emergency,
          ),

          _malayalamCard(),

          _referenceNote(),

          const SizedBox(height: 8),

          const Text(
            'SafeNexus HSE',
            style: TextStyle(
              color: Color(0xFF159447),
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'UAE HSE Safety Learning & Reference',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  ),
);

}

// ============================================================
// HERO CARD
// ============================================================

Widget _buildHeroCard() {
final categoryColor = _categoryColor(topic.category);

return Container(
  width: double.infinity,
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(22),
    gradient: LinearGradient(
      colors: [
        categoryColor,
        const Color(0xFF159447),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0x22000000),
        blurRadius: 14,
        offset: Offset(0, 7),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0x22FFFFFF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _categoryIcon(topic.category),
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  topic.sourceLabel,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      Text(
        topic.shortDescription,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          height: 1.45,
        ),
      ),
    ],
  ),
);

}

// ============================================================
// OFFICIAL REFERENCE CARD
// ============================================================

Widget _officialReferenceCard() {
return Container(
width: double.infinity,
margin: const EdgeInsets.only(bottom: 12),
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(17),
border: Border.all(
color: Colors.grey.shade200,
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Row(
children: [
Icon(
Icons.verified_outlined,
color: Color(0xFF0B5D4B),
size: 23,
),

          SizedBox(width: 10),

          Text(
            'Reference Information',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),

      const SizedBox(height: 14),

      _referenceRow(
        'Category',
        topic.category.label,
      ),

      _referenceRow(
        'Source',
        topic.sourceLabel,
      ),

      _referenceRow(
        'CoP / Reference',
        topic.copNumber,
      ),

      _referenceRow(
        'Version',
        topic.version,
      ),

      _referenceRow(
        'Effective Date',
        topic.effectiveDate,
      ),
    ],
  ),
);

}

Widget _referenceRow(
String label,
String value,
) {
return Padding(
padding: const EdgeInsets.only(bottom: 8),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
SizedBox(
width: 125,
child: Text(
label,
style: const TextStyle(
fontSize: 11.5,
fontWeight: FontWeight.w700,
color: Color(0xFF777777),
),
),
),

      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
    ],
  ),
);

}

// ============================================================
// INFORMATION CARD
// ============================================================

Widget _infoCard({
required IconData icon,
required String title,
required String content,
bool bulletStyle = false,
}) {
if (content.trim().isEmpty) {
return const SizedBox.shrink();
}

return Container(
  width: double.infinity,
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: Colors.grey.shade200,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF159447),
            size: 24,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      bulletStyle
          ? _bulletText(content)
          : Text(
              content,
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12.5,
                height: 1.55,
              ),
            ),
    ],
  ),
);

}

// ============================================================
// BULLET TEXT
// ============================================================

Widget _bulletText(String text) {
final items = _splitBullets(text);

return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: items.map((item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(
              Icons.circle,
              size: 6,
              color: Color(0xFF159447),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              item,
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList(),
);

}

List<String> _splitBullets(String text) {
return text
.split('\n')
.map((item) => item.trim())
.where((item) => item.isNotEmpty)
.toList();
}

// ============================================================
// CHECKLIST
// ============================================================

Widget _checklistCard() {
if (topic.checklist.trim().isEmpty) {
return const SizedBox.shrink();
}

final items = _splitBullets(topic.checklist);

return Container(
  width: double.infinity,
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: Colors.grey.shade200,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Row(
        children: [
          Icon(
            Icons.checklist_rounded,
            color: Color(0xFF159447),
            size: 24,
          ),

          SizedBox(width: 12),

          Text(
            'HSE Checklist',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
        ],
      ),

      const SizedBox(height: 12),

      ...items.map(
        (item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_box_outlined,
                size: 19,
                color: Color(0xFF159447),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

}

// ============================================================
// DO / DO NOT
// ============================================================

Widget _doDontCard({
required String title,
required IconData icon,
required String content,
required bool isPositive,
}) {
if (content.trim().isEmpty) {
return const SizedBox.shrink();
}

final color = isPositive
    ? const Color(0xFF159447)
    : const Color(0xFFD32F2F);

return Container(
  width: double.infinity,
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: Colors.grey.shade200,
    ),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(
        icon,
        color: color,
        size: 25,
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              content,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}

// ============================================================
// STOP WORK
// ============================================================

Widget _stopWorkCard() {
if (topic.stopWork.trim().isEmpty) {
return const SizedBox.shrink();
}

return Container(
  width: double.infinity,
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFFFF8F8),
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: const Color(0xFFF0CACA),
    ),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.pan_tool_alt_rounded,
        color: Color(0xFFD32F2F),
        size: 25,
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'When to Stop Work',
              style: TextStyle(
                color: Color(0xFFD32F2F),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              topic.stopWork,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}

// ============================================================
// MALAYALAM
// ============================================================

Widget _malayalamCard() {
if (topic.malayalam.trim().isEmpty) {
return const SizedBox.shrink();
}

return Container(
  width: double.infinity,
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: const Color(0xFFFFFBF2),
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: const Color(0xFFE9DDBD),
    ),
  ),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.translate_rounded,
        color: Color(0xFF8A6500),
        size: 25,
      ),

      const SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Malayalam – പ്രധാന സുരക്ഷാ നിർദ്ദേശങ്ങൾ',
              style: TextStyle(
                color: Color(0xFF765800),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              topic.malayalam,
              style: const TextStyle(
                color: Color(0xFF665A42),
                fontSize: 12.5,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}

// ============================================================
// REFERENCE NOTE
// ============================================================

Widget _referenceNote() {
return Container(
width: double.infinity,
margin: const EdgeInsets.only(bottom: 12),
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: const Color(0xFFF2F7F5),
borderRadius: BorderRadius.circular(17),
border: Border.all(
color: const Color(0xFFD7E8E1),
),
),
child: const Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Icon(
Icons.info_outline_rounded,
color: Color(0xFF0B5D4B),
size: 24,
),

      SizedBox(width: 12),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Important HSE Reference Note',
              style: TextStyle(
                color: Color(0xFF0B5D4B),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),

            SizedBox(height: 7),

            Text(
              'This Safety Guideline is provided for HSE learning and practical workplace reference. Always verify the latest official requirement, applicable legislation, authority requirements, project procedures, risk assessment, method statement and permit requirements before making a compliance decision.',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}

// ============================================================
// CATEGORY COLOR
// ============================================================

Color _categoryColor(GuidelineCategory category) {
switch (category) {
case GuidelineCategory.uaeGeneral:
return const Color(0xFF0B5D4B);

  case GuidelineCategory.abuDhabi:
    return const Color(0xFF8A6500);

  case GuidelineCategory.dubai:
    return const Color(0xFF7B3F98);

  case GuidelineCategory.all:
    return const Color(0xFF159447);
}

}

// ============================================================
// CATEGORY ICON
// ============================================================

IconData _categoryIcon(GuidelineCategory category) {
switch (category) {
case GuidelineCategory.uaeGeneral:
return Icons.shield_rounded;

  case GuidelineCategory.abuDhabi:
    return Icons.location_city_rounded;

  case GuidelineCategory.dubai:
    return Icons.business_rounded;

  case GuidelineCategory.all:
    return Icons.menu_book_rounded;
}

}
}
