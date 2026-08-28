import 'package:flutter/material.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  String _language = 'English';

  final Map<String, List<Map<String, String>>> guidelines = {
    'English': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'Rules and standards based on the Abu Dhabi OSH framework.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'Essential safety rules that must be followed at the site.'},
      {'letter': 'C', 'title': 'Dubai Code of Practice (CoP)', 'desc': 'Requirements based on Dubai Municipality Codes of Practice.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'Safety awareness briefing provided to workers before starting work.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'Actions to be taken during fire, accidents, and emergencies.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'Fire extinguisher use and hot work permit requirements.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'UAE sustainable construction and environmental protection requirements.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Heat stress precautions and UAE midday break requirements.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Investigation to identify the causes of incidents and near misses.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'Identifying hazards and controls before starting a job.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'Measures used to evaluate safety performance.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'Safety requirements for cranes and lifting operations.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'Safe methods to prevent injuries while handling heavy materials.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'Reporting events that could potentially lead to serious accidents.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'Compliance with international OSHA and ISO 45001 standards.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'Correct use of helmets, safety shoes, glasses, and other PPE.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'Checking whether safety requirements are properly followed.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'Identifying and controlling workplace hazards before work begins.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Safe scaffolding practices and Green, Red, and Yellow tag systems.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'Mandatory safety training and induction for workers.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'Legal requirements for protecting worker health and safety.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Ensuring adequate ventilation and safe entry into confined spaces.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'Proper handling and disposal of site waste.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Special safety controls for areas where radiography is performed.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Vehicle movement, speed control, and safety in material yards.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'Working towards preventing accidents and achieving a zero-accident goal.'},
    ],

    'Hindi': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'अबू धाबी OSH फ्रेमवर्क के अनुसार नियम और मानक।'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'साइट पर पालन किए जाने वाले आवश्यक सुरक्षा नियम।'},
      {'letter': 'C', 'title': 'Dubai Code of Practice (CoP)', 'desc': 'दुबई म्यूनिसिपैलिटी के कोड ऑफ प्रैक्टिस के अनुसार आवश्यकताएँ।'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'काम शुरू करने से पहले कर्मचारियों को दी जाने वाली सुरक्षा जानकारी।'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'आग, दुर्घटना और आपातकाल में अपनाए जाने वाले उपाय।'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'फायर एक्सटिंग्विशर और हॉट वर्क परमिट की सुरक्षा आवश्यकताएँ।'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'UAE के सतत निर्माण और पर्यावरण संरक्षण नियम।'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'हीट स्ट्रेस से बचाव और UAE मिडडे ब्रेक आवश्यकताएँ।'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'घटनाओं और नियर मिस के कारणों की जाँच।'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'काम शुरू करने से पहले खतरों और नियंत्रण उपायों की पहचान।'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'सुरक्षा प्रदर्शन को मापने वाले संकेतक।'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'क्रेन और लिफ्टिंग कार्यों के लिए सुरक्षा आवश्यकताएँ।'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'भारी सामग्री उठाते समय चोटों से बचने के सुरक्षित तरीके।'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'गंभीर दुर्घटना का कारण बन सकने वाली घटनाओं की रिपोर्टिंग।'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'OSHA और ISO 45001 अंतरराष्ट्रीय मानकों का पालन।'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'हेलमेट, सेफ्टी शूज़, ग्लास आदि PPE का सही उपयोग।'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'साइट पर सुरक्षा नियमों के पालन की जाँच।'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'कार्यस्थल के खतरों की पहचान और नियंत्रण।'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'स्कैफोल्डिंग सुरक्षा और Green, Red तथा Yellow Tag सिस्टम।'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'कर्मचारियों के लिए अनिवार्य सुरक्षा प्रशिक्षण और इंडक्शन।'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'कर्मचारियों के स्वास्थ्य और सुरक्षा की कानूनी आवश्यकताएँ।'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'कन्फाइंड स्पेस में उचित वेंटिलेशन और सुरक्षित प्रवेश।'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'साइट के कचरे का उचित प्रबंधन और निपटान।'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'रेडियोग्राफी कार्य क्षेत्रों के लिए विशेष सुरक्षा नियंत्रण।'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'मटेरियल यार्ड में वाहन गति और यातायात सुरक्षा।'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'दुर्घटनाओं को रोककर Zero Accident लक्ष्य प्राप्त करना।'},
    ],

    'Malayalam': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'അബുദാബി OSH ഫ്രെയിംവർക്ക് അടിസ്ഥാനമാക്കിയുള്ള നിയമങ്ങളും മാനദണ്ഡങ്ങളും.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'സൈറ്റിൽ നിർബന്ധമായും പാലിക്കേണ്ട അടിസ്ഥാന സുരക്ഷാ ചട്ടങ്ങൾ.'},
      {'letter': 'C', 'title': 'Dubai Code of Practice (CoP)', 'desc': 'ദുബായ് മുനിസിപ്പാലിറ്റി Code of Practice അനുസരിച്ചുള്ള നിബന്ധനകൾ.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'ജോലി ആരംഭിക്കുന്നതിന് മുമ്പ് നൽകുന്ന സുരക്ഷാ ബോധവൽക്കരണം.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'തീപിടിത്തം, അപകടം, അടിയന്തര സാഹചര്യം എന്നിവയ്ക്കുള്ള തയ്യാറെടുപ്പ്.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'ഫയർ എക്സ്റ്റിംഗുഷർ ഉപയോഗവും Hot Work Permit സുരക്ഷയും.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'യു.എ.ഇ.യിലെ സുസ്ഥിര നിർമ്മാണവും പരിസ്ഥിതി സംരക്ഷണ ചട്ടങ്ങളും.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Heat Stress നിയന്ത്രണവും UAE Midday Break ആവശ്യകതകളും.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Incident, Near Miss എന്നിവയുടെ കാരണങ്ങൾ കണ്ടെത്തുന്നതിനുള്ള അന്വേഷണം.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് അപകടസാധ്യതകളും നിയന്ത്രണങ്ങളും തിരിച്ചറിയൽ.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'സുരക്ഷാ പ്രകടനം അളക്കുന്നതിനുള്ള സൂചകങ്ങൾ.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'ക്രെയിൻ, ലിഫ്റ്റിംഗ് പ്രവർത്തനങ്ങൾക്കുള്ള സുരക്ഷാ ആവശ്യകതകൾ.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'ഭാരമുള്ള വസ്തുക്കൾ കൈകാര്യം ചെയ്യുമ്പോൾ പരിക്ക് ഒഴിവാക്കാനുള്ള സുരക്ഷിത രീതികൾ.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'വലിയ അപകടത്തിലേക്ക് നയിക്കാവുന്ന സംഭവങ്ങൾ റിപ്പോർട്ട് ചെയ്യൽ.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'OSHA, ISO 45001 അന്താരാഷ്ട്ര മാനദണ്ഡങ്ങൾ പാലിക്കൽ.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'Helmet, Safety Shoes, Safety Glasses തുടങ്ങിയ PPE ശരിയായി ഉപയോഗിക്കൽ.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'സൈറ്റിലെ സുരക്ഷാ ചട്ടങ്ങൾ ശരിയായി പാലിക്കുന്നുണ്ടോ എന്ന് പരിശോധിക്കൽ.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'ജോലിസ്ഥലത്തെ അപകടസാധ്യതകൾ തിരിച്ചറിഞ്ഞ് നിയന്ത്രിക്കൽ.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Scaffolding സുരക്ഷയും Green, Red, Yellow Tag സംവിധാനവും.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'തൊഴിലാളികൾക്കുള്ള നിർബന്ധിത Safety Training & Induction.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'തൊഴിലാളികളുടെ ആരോഗ്യവും സുരക്ഷയും സംരക്ഷിക്കുന്ന നിയമങ്ങൾ.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Confined Space-ൽ ആവശ്യമായ വായുസഞ്ചാരവും സുരക്ഷിത പ്രവേശനവും.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'സൈറ്റിലെ മാലിന്യങ്ങളുടെ ശരിയായ കൈകാര്യം ചെയ്യലും സംസ്കരണവും.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Radiography നടക്കുന്ന സ്ഥലങ്ങളിലെ പ്രത്യേക സുരക്ഷാ നിയന്ത്രണങ്ങൾ.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Material Yard-ലെ വാഹന ഗതാഗതവും വേഗത നിയന്ത്രണവും.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'അപകടങ്ങൾ ഒഴിവാക്കി Zero Accident ലക്ഷ്യം കൈവരിക്കൽ.'},
    ],

    'Tamil': [
      {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'அபுதாபி OSH கட்டமைப்பின் அடிப்படையிலான விதிமுறைகள் மற்றும் தரநிலைகள்.'},
      {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'தளத்தில் கட்டாயமாக பின்பற்ற வேண்டிய அடிப்படை பாதுகாப்பு விதிகள்.'},
      {'letter': 'C', 'title': 'Dubai Code of Practice (CoP)', 'desc': 'துபாய் நகராட்சி Code of Practice அடிப்படையிலான விதிமுறைகள்.'},
      {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'வேலை தொடங்குவதற்கு முன் வழங்கப்படும் பாதுகாப்பு விழிப்புணர்வு.'},
      {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'தீ, விபத்து மற்றும் அவசரநிலைகளுக்கான தயாரிப்பு நடவடிக்கைகள்.'},
      {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'Fire Extinguisher பயன்பாடு மற்றும் Hot Work Permit பாதுகாப்பு.'},
      {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'UAE நிலையான கட்டுமான மற்றும் சுற்றுச்சூழல் பாதுகாப்பு விதிமுறைகள்.'},
      {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'Heat Stress கட்டுப்பாடு மற்றும் UAE Midday Break தேவைகள்.'},
      {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'Incident மற்றும் Near Miss காரணங்களை கண்டறியும் விசாரணை.'},
      {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'வேலைக்கு முன் அபாயங்கள் மற்றும் கட்டுப்பாட்டு நடவடிக்கைகளை அடையாளம் காணுதல்.'},
      {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'பாதுகாப்பு செயல்திறனை அளவிடும் குறியீடுகள்.'},
      {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'Crane மற்றும் Lifting பணிகளுக்கான பாதுகாப்பு தேவைகள்.'},
      {'letter': 'M', 'title': 'Manual Handling', 'desc': 'கனமான பொருட்களை கையாளும்போது காயங்களைத் தவிர்க்கும் பாதுகாப்பான முறைகள்.'},
      {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'பெரிய விபத்துகளுக்கு வழிவகுக்கக்கூடிய நிகழ்வுகளைப் புகாரளித்தல்.'},
      {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'OSHA மற்றும் ISO 45001 சர்வதேச தரநிலைகளை பின்பற்றுதல்.'},
      {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'Helmet, Safety Shoes, Safety Glasses போன்ற PPE-ஐ சரியாக பயன்படுத்துதல்.'},
      {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'தளத்தில் பாதுகாப்பு விதிகள் சரியாக பின்பற்றப்படுகிறதா என்பதை ஆய்வு செய்தல்.'},
      {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'பணியிட அபாயங்களை கண்டறிந்து கட்டுப்படுத்துதல்.'},
      {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'Scaffolding பாதுகாப்பு மற்றும் Green, Red, Yellow Tag அமைப்பு.'},
      {'letter': 'T', 'title': 'Training & Induction', 'desc': 'தொழிலாளர்களுக்கான கட்டாய Safety Training மற்றும் Induction.'},
      {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'தொழிலாளர்களின் உடல்நலம் மற்றும் பாதுகாப்பை பாதுகாக்கும் சட்டங்கள்.'},
      {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'Confined Space-ல் சரியான காற்றோட்டம் மற்றும் பாதுகாப்பான நுழைவு.'},
      {'letter': 'W', 'title': 'Waste Management', 'desc': 'தளக் கழிவுகளை முறையாக கையாளுதல் மற்றும் அகற்றுதல்.'},
      {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'Radiography நடைபெறும் பகுதிகளுக்கான சிறப்பு பாதுகாப்பு கட்டுப்பாடுகள்.'},
      {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'Material Yard-ல் வாகன இயக்கம், வேகக் கட்டுப்பாடு மற்றும் பாதுகாப்பு.'},
      {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'விபத்துகளைத் தடுத்து Zero Accident இலக்கை அடைதல்.'},
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
              subtitle: Text(
                item['desc']!,
              ),
            ),
          );
        },
      ),
    );
  }
}
