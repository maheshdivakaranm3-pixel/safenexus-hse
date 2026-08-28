import 'package:flutter/material.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  String _language = 'English';

  final Map<String, List<Map<String, String>>> guidelines = {
    'English': [
      {
        'letter': 'A',
        'title': 'ADOSH (Abu Dhabi OSH)',
        'desc': 'Rules and standards based on the Abu Dhabi OSH framework.',
        'English_title': 'ADOSH (Abu Dhabi OSH)',
        'English_what': 'What is ADOSH?',
        'English_whatText': 'ADOSH refers to the Abu Dhabi Occupational Safety and Health framework.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To protect workers and improve occupational safety and health.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Follow applicable OSH policies, procedures, risk controls and reporting requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Employers, supervisors and workers must follow applicable safety requirements.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Risk assessment, PPE, training, emergency arrangements and inspections.',
        'English_violations': 'Violations',
        'English_violationsText': 'Failure to follow required safety controls may result in unsafe conditions and corrective action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Maintain proper documentation, regular inspections, training and continuous improvement.',
        'English_reference': 'Reference',
        'English_referenceText': 'Abu Dhabi Occupational Safety and Health System Framework.'
      },
      {
        'letter': 'B',
        'title': 'Basic Safety Rules',
        'desc': 'Essential safety rules that must be followed at the site.',
        'English_title': 'Basic Safety Rules',
        'English_what': 'What are Basic Safety Rules?',
        'English_whatText': 'Basic safety rules are essential precautions that every worker must follow at the workplace.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To prevent injuries, incidents and unsafe acts.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Wear required PPE, follow site procedures, maintain good housekeeping and report hazards.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Every worker and supervisor is responsible for maintaining a safe workplace.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'PPE, housekeeping, access, tools, electrical safety and emergency arrangements.',
        'English_violations': 'Violations',
        'English_violationsText': 'Ignoring site safety rules can lead to accidents and disciplinary action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Stop unsafe work, report hazards immediately and follow approved procedures.',
        'English_reference': 'Reference',
        'English_referenceText': 'Company HSE procedures and applicable UAE requirements.'
      },
    ],
  };

  final Map<String, String> pageTitles = {
    'English': 'UAE HSE A-Z Guidelines',
    'Hindi': 'UAE HSE A-Z सुरक्षा दिशानिर्देश',
    'Malayalam': 'UAE HSE A-Z സുരക്ഷാ മാർഗ്ഗനിർദ്ദേശങ്ങൾ',
    'Tamil': 'UAE HSE A-Z பாதுகாப்பு வழிகாட்டுதல்கள்',
  };

  void _changeLanguage(String language) {
    setState(() {
      _language = language;
    });
  }

  void _openGuideline(Map<String, String> item) {
    final Map<String, String> detailGuideline = Map<String, String>.from(item);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuidelineDetailPage(
          guideline: detailGuideline,
          language: _language,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentGuidelines = guidelines[_language] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitles[_language]!),
        backgroundColor: Colors.blueAccent,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: _changeLanguage,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'Hindi',
                child: Text('हिन्दी'),
              ),
              PopupMenuItem(
                value: 'Malayalam',
                child: Text('മലയാളം'),
              ),
              PopupMenuItem(
                value: 'Tamil',
                child: Text('தமிழ்'),
              ),
            ],
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: currentGuidelines.length,
        itemBuilder: (context, index) {
          final item = currentGuidelines[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  item['letter'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                item['title'] ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  item['desc'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),

              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.blueAccent,
              ),

              onTap: () {
                _openGuideline(item);
              },
            ),
          );
        },
      ),
    );
  }
}
