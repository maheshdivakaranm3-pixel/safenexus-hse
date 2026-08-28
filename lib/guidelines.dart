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
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'Abu Dhabi Occupational Safety and Health System framework.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'Essential workplace safety rules for workers and supervisors.'},
      {'letter': 'C', 'title': 'Code of Practice (CoP)', 'desc': 'Minimum mandatory OSH technical requirements for specific subjects.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'Short safety briefing before starting daily work.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'Preparation and response for fires, accidents and emergencies.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'Fire prevention, firefighting equipment and hot work safety.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'Sustainable construction and environmental protection practices.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Controls for protecting workers from heat stress.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Finding root causes of incidents and near misses.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'Identifying job hazards and controls before work starts.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'Measures used to monitor HSE performance.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'Safe planning and execution of lifting operations.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'Safe handling of materials to prevent injuries.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'Reporting unsafe events before they become accidents.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'International occupational safety and health standards.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'Correct selection, use and maintenance of PPE.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'Systematic checking of HSE compliance and performance.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'Identifying hazards, evaluating risks and implementing controls.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Safe erection, inspection, tagging and use of scaffolding.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'Safety training and site induction for workers.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'Legal requirements related to workers and workplace safety.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Safe ventilation, entry and control of confined spaces.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'Safe collection, segregation, storage and disposal of waste.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Safety controls for work involving radiation and radiography.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Safe vehicle and pedestrian movement within work yards.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'Continuous prevention of incidents and improvement of safety performance.'},
    ],

    'Hindi': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'अबू धाबी व्यावसायिक सुरक्षा और स्वास्थ्य प्रणाली।'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'कार्यस्थल पर पालन किए जाने वाले आवश्यक सुरक्षा नियम।'},
      {'letter': 'C', 'title': 'Code of Practice (CoP)', 'desc': 'विशिष्ट विषयों के लिए न्यूनतम अनिवार्य OSH तकनीकी आवश्यकताएँ।'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'दैनिक कार्य शुरू करने से पहले सुरक्षा ब्रीफिंग।'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'आग, दुर्घटना और आपातकाल के लिए तैयारी।'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'आग की रोकथाम और अग्निशमन सुरक्षा।'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'सतत निर्माण और पर्यावरण संरक्षण।'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'हीट स्ट्रेस से कर्मचारियों की सुरक्षा।'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'घटना और Near Miss के मूल कारणों की जाँच।'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'काम शुरू होने से पहले खतरों और नियंत्रणों की पहचान।'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'HSE प्रदर्शन को मापने वाले संकेतक।'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'लिफ्टिंग कार्यों की सुरक्षित योजना और संचालन।'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'सामग्री उठाने और संभालने के सुरक्षित तरीके।'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'दुर्घटना से पहले की असुरक्षित घटनाओं की रिपोर्टिंग।'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'अंतरराष्ट्रीय सुरक्षा और स्वास्थ्य मानक।'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'PPE का सही चयन, उपयोग और रखरखाव।'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'HSE अनुपालन और प्रदर्शन की व्यवस्थित जाँच।'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'खतरों की पहचान, जोखिम मूल्यांकन और नियंत्रण।'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'स्कैफोल्डिंग की सुरक्षित स्थापना, निरीक्षण और उपयोग।'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'कर्मचारियों के लिए सुरक्षा प्रशिक्षण और इंडक्शन।'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'कर्मचारियों और कार्यस्थल सुरक्षा से संबंधित कानूनी आवश्यकताएँ।'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Confined Space में सुरक्षित वेंटिलेशन और प्रवेश।'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'कचरे का सुरक्षित संग्रह, पृथक्करण और निपटान।'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'रेडिएशन और रेडियोग्राफी कार्यों के लिए सुरक्षा नियंत्रण।'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'यार्ड में वाहनों और पैदल यात्रियों की सुरक्षा।'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'दुर्घटनाओं की रोकथाम और सुरक्षा प्रदर्शन में सुधार।'},
    ],

    'Malayalam': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'അബുദാബി Occupational Safety and Health System ഫ്രെയിംവർക്ക്.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'ജോലിസ്ഥലത്ത് പാലിക്കേണ്ട അടിസ്ഥാന സുരക്ഷാ ചട്ടങ്ങൾ.'},
      {'letter': 'C', 'title': 'Code of Practice (CoP)', 'desc': 'പ്രത്യേക വിഷയങ്ങളിലെ കുറഞ്ഞ നിർബന്ധിത OSH സാങ്കേതിക ആവശ്യകതകൾ.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'ദിവസത്തെ ജോലി തുടങ്ങുന്നതിന് മുമ്പുള്ള സുരക്ഷാ ബ്രീഫിംഗ്.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'തീ, അപകടം, അടിയന്തര സാഹചര്യങ്ങൾക്കുള്ള തയ്യാറെടുപ്പ്.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'തീ തടയൽ, firefighting equipment, hot work സുരക്ഷ.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'സുസ്ഥിര നിർമ്മാണവും പരിസ്ഥിതി സംരക്ഷണവും.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Heat Stress-ൽ നിന്ന് തൊഴിലാളികളെ സംരക്ഷിക്കുന്ന നിയന്ത്രണങ്ങൾ.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Incident, Near Miss എന്നിവയുടെ root cause കണ്ടെത്തൽ.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് hazards, risks, controls തിരിച്ചറിയൽ.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'HSE പ്രകടനം അളക്കുന്നതിനുള്ള പ്രധാന സൂചകങ്ങൾ.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'Lifting operations സുരക്ഷിതമായി ആസൂത്രണം ചെയ്ത് നടത്തൽ.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'സാധനങ്ങൾ സുരക്ഷിതമായി കൈകാര്യം ചെയ്ത് പരിക്ക് ഒഴിവാക്കൽ.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'അപകടമായി മാറുന്നതിന് മുമ്പുള്ള unsafe events റിപ്പോർട്ട് ചെയ്യൽ.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'അന്താരാഷ്ട്ര safety and health standards.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'PPE ശരിയായി തിരഞ്ഞെടുക്കുകയും ഉപയോഗിക്കുകയും പരിപാലിക്കുകയും ചെയ്യൽ.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'HSE compliance, performance എന്നിവ systematic ആയി പരിശോധിക്കൽ.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'Hazard തിരിച്ചറിഞ്ഞ് risk വിലയിരുത്തി controls നടപ്പാക്കൽ.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Scaffolding erection, inspection, tagging, use എന്നിവയിലെ സുരക്ഷ.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'തൊഴിലാളികൾക്കുള്ള Safety Training, Site Induction.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'തൊഴിലാളികളും workplace safety-യും സംബന്ധിച്ച നിയമപരമായ ആവശ്യകതകൾ.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Confined Space-ൽ ventilation, entry, control എന്നിവയുടെ സുരക്ഷ.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'മാലിന്യങ്ങളുടെ സുരക്ഷിത collection, segregation, storage, disposal.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Radiation, radiography ജോലികളിലെ പ്രത്യേക സുരക്ഷാ നിയന്ത്രണങ്ങൾ.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Work yard-ലെ വാഹന, pedestrian movement സുരക്ഷ.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'അപകടങ്ങൾ തുടർച്ചയായി തടഞ്ഞ് safety performance മെച്ചപ്പെടുത്തുക.'},
    ],

    'Tamil': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'அபுதாபி தொழில்சார் பாதுகாப்பு மற்றும் சுகாதார அமைப்பு.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'பணியிடத்தில் பின்பற்ற வேண்டிய அடிப்படை பாதுகாப்பு விதிகள்.'},
      {'letter': 'C', 'title': 'Code of Practice (CoP)', 'desc': 'குறிப்பிட்ட தலைப்புகளுக்கான குறைந்தபட்ச கட்டாய OSH தொழில்நுட்ப தேவைகள்.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'தினசரி வேலை தொடங்குவதற்கு முன் பாதுகாப்பு விளக்கக்கூட்டம்.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'தீ, விபத்து மற்றும் அவசரநிலைகளுக்கான தயாரிப்பு.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'தீ தடுப்பு, firefighting equipment மற்றும் hot work பாதுகாப்பு.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'நிலையான கட்டுமானம் மற்றும் சுற்றுச்சூழல் பாதுகாப்பு.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Heat Stress-இலிருந்து தொழிலாளர்களை பாதுகாக்கும் கட்டுப்பாடுகள்.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Incident மற்றும் Near Miss-ன் அடிப்படை காரணங்களை கண்டறிதல்.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'வேலை தொடங்குவதற்கு முன் அபாயங்கள் மற்றும் கட்டுப்பாடுகளை அடையாளம் காணுதல்.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'HSE செயல்திறனை அளவிடும் முக்கிய குறியீடுகள்.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'Lifting பணிகளை பாதுகாப்பாக திட்டமிட்டு செயல்படுத்துதல்.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'பொருட்களை பாதுகாப்பாக கையாளுதல் மற்றும் காயங்களைத் தவிர்த்தல்.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'விபத்தாக மாறுவதற்கு முன் நிகழும் unsafe events-ஐ புகாரளித்தல்.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'சர்வதேச பாதுகாப்பு மற்றும் சுகாதார தரநிலைகள்.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'PPE-ஐ சரியாக தேர்வு செய்து பயன்படுத்தி பராமரித்தல்.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'HSE compliance மற்றும் performance-ஐ முறையாக ஆய்வு செய்தல்.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'அபாயங்களை கண்டறிந்து risk மதிப்பீடு செய்து controls செயல்படுத்துதல்.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Scaffolding அமைத்தல், inspection, tagging மற்றும் பயன்பாட்டின் பாதுகாப்பு.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'தொழிலாளர்களுக்கான Safety Training மற்றும் Site Induction.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'தொழிலாளர்கள் மற்றும் workplace safety தொடர்பான சட்ட தேவைகள்.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Confined Space-ல் ventilation மற்றும் பாதுகாப்பான entry.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'கழிவுகளை பாதுகாப்பாக சேகரித்து பிரித்து சேமித்து அகற்றுதல்.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Radiation மற்றும் radiography பணிகளுக்கான பாதுகாப்பு கட்டுப்பாடுகள்.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Work yard-ல் வாகன மற்றும் pedestrian movement பாதுகாப்பு.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'விபத்துகளை தொடர்ந்து தடுத்து safety performance-ஐ மேம்படுத்துதல்.'},
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

  @override
  Widget build(BuildContext context) {
    final currentGuidelines = guidelines[_language]!;

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
        itemCount: currentGuidelines.length,
        itemBuilder: (context, index) {
          final item = currentGuidelines[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  item['letter']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(item['desc']!),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.blueAccent,
              ),

              // A-Z CLICK
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuidelineDetailPage(
                      guideline: item,
                      language: _language,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
