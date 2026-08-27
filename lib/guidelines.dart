import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  const GuidelinesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> uaeGuidelines = const [
    {'letter': 'A', 'title': 'ADOSH (Abu Dhabi OSH)', 'desc': 'അബുദാബിയിലെ OSHAD ഫ്രെയിംവർക്ക് പ്രകാരമുള്ള നിയമങ്ങളും മാനദണ്ഡങ്ങളും.'},
    {'letter': 'B', 'title': 'Basic Safety Rules', 'desc': 'സൈറ്റിൽ നിർബന്ധമായും പാലിക്കേണ്ട അടിസ്ഥാന സുരക്ഷാ ചട്ടങ്ങൾ.'},
    {'letter': 'C', 'title': 'Dubai Code of Practice (CoP)', 'desc': 'ദുബായ് മുനിസിപ്പാലിറ്റിയുടെ കോഡ് ഓഫ് പ്രാക്ടീസ് അനുസരിച്ചുള്ള നിബന്ധനകൾ.'},
    {'letter': 'D', 'title': 'Daily Toolbox Talk (TBT)', 'desc': 'ജോലി ആരംഭിക്കുന്നതിന് മുൻപ് തൊഴിലാളികൾക്ക് നൽകുന്ന സുരക്ഷാ ബോധവൽക്കരണം.'},
    {'letter': 'E', 'title': 'Emergency Preparedness', 'desc': 'തീപിടിത്തം, അപകടങ്ങൾ എന്നിവ ഉണ്ടായാൽ സ്വീകരിക്കേണ്ട നടപടികൾ.'},
    {'letter': 'F', 'title': 'Fire Safety & Prevention', 'desc': 'ഫയർ എക്സ്റ്റിംഗുഷറുകളുടെ ഉപയോഗം, ഹോട്ട് വർക്ക് പെർമിറ്റ്.'},
    {'letter': 'G', 'title': 'Green Building Regulations', 'desc': 'യു.എ.ഇ.-യുടെ സുസ്ഥിര നിർമ്മാണ നയങ്ങളും പരിസ്ഥിതി സംരക്ഷണ ചട്ടങ്ങളും.'},
    {'letter': 'H', 'title': 'Heat Stress Management', 'desc': 'വേനൽക്കാലത്ത് ഉച്ചസമയത്തെ ഔട്ട്ഡോർ ജോലി നിരോധനവും (Midday Break Law) മുൻകരുതലുകളും.'},
    {'letter': 'I', 'title': 'Incident Investigation', 'desc': 'അപകടമോ നിയർ മിസ്സോ ഉണ്ടായാൽ അതിന്റെ കാരണം കണ്ടെത്താനുള്ള അന്വേഷണം.'},
    {'letter': 'J', 'title': 'Job Safety Analysis (JSA)', 'desc': 'ജോലി തുടങ്ങുന്നതിന് മുൻപ് അപകടസാധ്യതകൾ വിലയിരുത്തി മുൻകരുതൽ എടുക്കൽ.'},
    {'letter': 'K', 'title': 'Key Performance Indicators', 'desc': 'കമ്പനിയുടെ സുരക്ഷാ പ്രകടനം അളക്കുന്ന അളവുകോലുകൾ.'},
    {'letter': 'L', 'title': 'Lifting Operations', 'desc': 'ക്രെയിൻ, ലിഫ്റ്റിംഗ് ടാക്കുകൾ എന്നിവ ചെയ്യുമ്പോൾ പാലിക്കേണ്ട സുരക്ഷ.'},
    {'letter': 'M', 'title': 'Manual Handling', 'desc': 'ഭാരമുള്ള സാധനങ്ങൾ എടുക്കുമ്പോൾ ശരീരത്തിന് പരിക്കുകൾ പറ്റാതിരിക്കാനുള്ള രീതികൾ.'},
    {'letter': 'N', 'title': 'Near Miss Reporting', 'desc': 'വലിയ അപകടങ്ങളിലേക്ക് നയിച്ചേക്കാവുന്ന ചെറിയ വീഴ്ചകൾ റിപ്പോർട്ട് ചെയ്യൽ.'},
    {'letter': 'O', 'title': 'OSHA & ISO Standards', 'desc': 'അന്താരാഷ്ട്ര മാനദണ്ഡങ്ങളായ OSHA, ISO 45001 പാലനം.'},
    {'letter': 'P', 'title': 'PPE Compliance', 'desc': 'ഹെൽമെറ്റ്, സേഫ്റ്റി ഷൂ, ഗ്ലാസുകൾ തുടങ്ങിയ ഉപകരണങ്ങൾ കൃത്യമായി ഉപയോഗിക്കൽ.'},
    {'letter': 'Q', 'title': 'HSE Auditing', 'desc': 'സൈറ്റിൽ സുരക്ഷാ ചട്ടങ്ങൾ കൃത്യമായി പാലിക്കുന്നുണ്ടോ എന്ന് പരിശോധിക്കൽ.'},
    {'letter': 'R', 'title': 'Risk Assessment', 'desc': 'ജോലിസ്ഥലത്തെ അപകടസാധ്യതകൾ മുൻകൂട്ടി തിട്ടപ്പെടുത്തി നിയന്ത്രിക്കൽ.'},
    {'letter': 'S', 'title': 'Scaffolding Safety', 'desc': 'സ്കാഫോൾഡിംഗ് നിർമ്മാണവും ടാഗ് സിസ്റ്റവും (Green, Red, Yellow Tags).'},
    {'letter': 'T', 'title': 'Training & Induction', 'desc': 'പുതിയ തൊഴിലാളികൾക്ക് നൽകുന്ന നിർബന്ധിത സേഫ്റ്റി ട്രെയിനിങ്.'},
    {'letter': 'U', 'title': 'UAE Labour Law', 'desc': 'തൊഴിലാളികളുടെ ആരോഗ്യവും സുരക്ഷയും ഉറപ്പാക്കാനുള്ള നിയമങ്ങൾ.'},
    {'letter': 'V', 'title': 'Ventilation & Confined Space', 'desc': 'ക്ലോസ്ഡ് സ്പേസുകളിൽ നല്ല വായുസഞ്ചാരം ഉറപ്പാക്കൽ.'},
    {'letter': 'W', 'title': 'Waste Management', 'desc': 'സൈറ്റിലെ മാലിന്യങ്ങൾ നിയമപ്രകാരം സംസ്കരിക്കൽ.'},
    {'letter': 'X', 'title': 'Radiation Safety', 'desc': 'റേഡിയോഗ്രാഫി ജോലികൾ നടക്കുന്ന സ്ഥലങ്ങളിലെ പ്രത്യേക സുരക്ഷ.'},
    {'letter': 'Y', 'title': 'Yard & Traffic Safety', 'desc': 'മെറ്റീരിയൽ യാർഡുകളിലെ വാഹനങ്ങളുടെ വേഗതയും സുരക്ഷയും.'},
    {'letter': 'Z', 'title': 'Zero Accident Goal', 'desc': 'അപകടങ്ങൾ പൂർണ്ണമായും ഒഴിവാക്കി ജീറോ ആക്സിഡന്റ് ലക്ഷ്യത്തിലെത്തൽ.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UAE HSE A-Z Guidelines'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: uaeGuidelines.length,
        itemBuilder: (context, index) {
          final item = uaeGuidelines[index];

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
            ),
          );
        },
      ),
    );
  }
}
