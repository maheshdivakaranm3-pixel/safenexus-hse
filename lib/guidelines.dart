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
        'desc':
            'Abu Dhabi Occupational Safety and Health System Framework and workplace safety requirements.',
        'English_title': 'ADOSH (Abu Dhabi OSH)',
        'English_what': 'What is ADOSH?',
        'English_whatText':
            'ADOSH-SF is the Abu Dhabi Occupational Safety and Health System Framework. It provides a structured framework for managing occupational safety and health risks and establishing an effective OSH management system.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent workplace injuries, occupational illness and unsafe conditions by identifying hazards, assessing risks and implementing effective controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Organizations must identify applicable OSH requirements, establish appropriate policies and procedures, assess workplace risks, provide competent resources, implement controls, monitor performance and maintain required records.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and leadership. Supervisors implement safe work practices. Workers follow procedures, use required PPE and report hazards, incidents and unsafe conditions.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'OSH policy, risk assessment, legal requirements, training and competency, PPE, emergency arrangements, inspections, incident reporting, monitoring and corrective actions.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without required controls, inadequate risk assessment, failure to provide PPE or training, poor housekeeping, unsafe equipment and failure to report incidents.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a proactive risk-management approach, conduct regular inspections, involve workers in safety activities, close corrective actions promptly and continuously improve the OSH management system.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF), Version 4.0 and applicable Codes of Practice.',

        'Hindi_title': 'ADOSH (Abu Dhabi OSH)',
        'Hindi_what': 'ADOSH क्या है?',
        'Hindi_whatText':
            'ADOSH-SF अबू धाबी का Occupational Safety and Health System Framework है। यह कार्यस्थल पर सुरक्षा और स्वास्थ्य जोखिमों को व्यवस्थित रूप से प्रबंधित करने के लिए एक ढांचा प्रदान करता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'कार्यस्थल की चोटों, व्यावसायिक बीमारी और असुरक्षित परिस्थितियों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'लागू OSH आवश्यकताओं की पहचान, जोखिम मूल्यांकन, सुरक्षित प्रक्रियाएँ, प्रशिक्षण, PPE, आपातकालीन व्यवस्था, निरीक्षण और रिकॉर्ड बनाए रखना आवश्यक है।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'प्रबंधन संसाधन और नेतृत्व प्रदान करता है। सुपरवाइजर सुरक्षित कार्य लागू करते हैं। कर्मचारी प्रक्रियाओं का पालन करते और खतरों की रिपोर्ट करते हैं।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'OSH नीति, Risk Assessment, प्रशिक्षण, PPE, Emergency Plan, Inspection, Incident Reporting और Corrective Action की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'बिना नियंत्रण के काम करना, अपर्याप्त Risk Assessment, PPE या प्रशिक्षण की कमी और Incident Reporting में विफलता।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'नियमित निरीक्षण करें, कर्मचारियों को सुरक्षा गतिविधियों में शामिल करें और Corrective Actions को समय पर बंद करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – ADOSH-SF Version 4.0 और लागू Codes of Practice।',

        'Malayalam_title': 'ADOSH (Abu Dhabi OSH)',
        'Malayalam_what': 'ADOSH എന്താണ്?',
        'Malayalam_whatText':
            'ADOSH-SF എന്നത് അബുദാബിയിലെ Occupational Safety and Health System Framework ആണ്. ജോലിസ്ഥലത്തെ സുരക്ഷാ, ആരോഗ്യ അപകടസാധ്യതകൾ ക്രമബദ്ധമായി നിയന്ത്രിക്കുന്നതിനുള്ള സംവിധാനമാണിത്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജോലിസ്ഥലത്തെ അപകടങ്ങൾ, തൊഴിൽ സംബന്ധമായ അസുഖങ്ങൾ, സുരക്ഷിതമല്ലാത്ത സാഹചര്യങ്ങൾ എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'ബാധകമായ OSH ആവശ്യകതകൾ തിരിച്ചറിയുക, Risk Assessment നടത്തുക, സുരക്ഷിതമായ നടപടിക്രമങ്ങൾ, Training, PPE, Emergency Arrangements, Inspection, Reporting എന്നിവ നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management ആവശ്യമായ വിഭവങ്ങളും നേതൃത്വവും നൽകണം. Supervisors സുരക്ഷിതമായ ജോലി ഉറപ്പാക്കണം. Workers procedures പാലിക്കുകയും hazards report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'OSH Policy, Risk Assessment, Training, PPE, Emergency Plan, Inspection, Incident Reporting, Monitoring, Corrective Action എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'ആവശ്യമായ നിയന്ത്രണങ്ങളില്ലാതെ ജോലി ചെയ്യൽ, ശരിയായ Risk Assessment ഇല്ലായ്മ, PPE/Training കുറവ്, അപകടങ്ങൾ റിപ്പോർട്ട് ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Regular Inspection നടത്തുക, തൊഴിലാളികളെ safety activities-ൽ ഉൾപ്പെടുത്തുക, corrective actions സമയത്ത് close ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – ADOSH-SF Version 4.0 കൂടാതെ ബാധകമായ Codes of Practice.',

        'Tamil_title': 'ADOSH (Abu Dhabi OSH)',
        'Tamil_what': 'ADOSH என்றால் என்ன?',
        'Tamil_whatText':
            'ADOSH-SF என்பது அபுதாபியின் Occupational Safety and Health System Framework ஆகும். பணியிட பாதுகாப்பு மற்றும் சுகாதார அபாயங்களை முறையாக நிர்வகிக்க இது ஒரு கட்டமைப்பை வழங்குகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'பணியிட விபத்துகள், தொழில் சார்ந்த நோய்கள் மற்றும் பாதுகாப்பற்ற நிலைகளைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'பொருந்தும் OSH தேவைகளை அடையாளம் காணுதல், Risk Assessment, பாதுகாப்பான நடைமுறைகள், Training, PPE, Emergency Arrangements மற்றும் Inspection ஆகியவை செயல்படுத்தப்பட வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management வளங்களையும் தலைமையையும் வழங்க வேண்டும். Supervisors பாதுகாப்பான வேலை முறைகளை உறுதி செய்ய வேண்டும். Workers நடைமுறைகளைப் பின்பற்றி hazards-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'OSH Policy, Risk Assessment, Training, PPE, Emergency Plan, Inspection, Incident Reporting மற்றும் Corrective Action ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'தேவையான controls இல்லாமல் வேலை செய்தல், Risk Assessment குறைபாடு, PPE/Training இல்லாமை மற்றும் incidents report செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Regular Inspection செய்யவும், workers-ஐ safety activities-ல் ஈடுபடுத்தவும், corrective actions-ஐ நேரத்தில் close செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Abu Dhabi Public Health Centre (ADPHC) – ADOSH-SF Version 4.0 மற்றும் பொருந்தும் Codes of Practice.',
      },

      {
        'letter': 'B',
        'title': 'Basic Safety Rules',
        'desc':
            'Essential workplace safety rules that every worker must follow.',
        'English_title': 'Basic Safety Rules',
        'English_what': 'What are Basic Safety Rules?',
        'English_whatText':
            'Basic safety rules are fundamental precautions that help workers perform tasks safely and prevent common workplace incidents.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent injuries, unsafe acts, property damage and avoidable incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Follow site procedures, use required PPE, maintain housekeeping, use tools correctly, follow warning signs, keep access routes clear and report hazards immediately.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers must follow safe work procedures. Supervisors must monitor compliance and correct unsafe acts. Management must provide suitable resources and training.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'PPE, housekeeping, access and egress, tools, electrical safety, lifting practices, signage, emergency equipment and hazard reporting.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to wear PPE, horseplay, blocked access, unsafe use of tools, bypassing safety devices and ignoring warning signs.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Stop unsafe work when necessary, follow approved procedures, maintain good housekeeping and report hazards before they become incidents.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and relevant UAE legislation.',

        'Hindi_title': 'Basic Safety Rules',
        'Hindi_what': 'Basic Safety Rules क्या हैं?',
        'Hindi_whatText':
            'Basic Safety Rules वे मूल सुरक्षा सावधानियाँ हैं जिनका पालन करके कर्मचारी सुरक्षित रूप से काम कर सकते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'चोटों, असुरक्षित कार्यों और अनावश्यक घटनाओं को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Site procedures का पालन करें, PPE पहनें, housekeeping बनाए रखें, tools सही तरीके से इस्तेमाल करें और hazards की तुरंत रिपोर्ट करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Workers procedures का पालन करें। Supervisors compliance की निगरानी करें। Management training और resources उपलब्ध कराए।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'PPE, housekeeping, access, tools, electrical safety, signage, emergency equipment और hazard reporting की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'PPE न पहनना, unsafe tools, blocked access, safety devices को bypass करना और warning signs को नजरअंदाज करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Unsafe work को रोकें, approved procedures का पालन करें और hazards को तुरंत report करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, ADOSH-SF requirements और लागू UAE legislation।',

        'Malayalam_title': 'Basic Safety Rules',
        'Malayalam_what': 'Basic Safety Rules എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്ത് സുരക്ഷിതമായി ജോലി ചെയ്യാൻ ഓരോ തൊഴിലാളിയും പാലിക്കേണ്ട അടിസ്ഥാന സുരക്ഷാ മുൻകരുതലുകളാണ് Basic Safety Rules.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'പരിക്കുകൾ, unsafe acts, property damage, incidents എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Site procedures പാലിക്കുക, ആവശ്യമായ PPE ഉപയോഗിക്കുക, housekeeping maintain ചെയ്യുക, tools ശരിയായി ഉപയോഗിക്കുക, warning signs പാലിക്കുക, hazards ഉടൻ report ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Workers safe procedures പാലിക്കണം. Supervisors compliance പരിശോധിക്കണം. Management ആവശ്യമായ training, resources എന്നിവ നൽകണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'PPE, housekeeping, access, tools, electrical safety, signage, emergency equipment, hazard reporting എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'PPE ഉപയോഗിക്കാത്തത്, unsafe tool use, access block ചെയ്യൽ, safety devices bypass ചെയ്യൽ, warning signs അവഗണിക്കൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Unsafe work ആവശ്യമെങ്കിൽ stop ചെയ്യുക, approved procedures പാലിക്കുക, hazards ഉടൻ report ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE Procedures, ബാധകമായ ADOSH-SF requirements, UAE legislation.',

        'Tamil_title': 'Basic Safety Rules',
        'Tamil_what': 'Basic Safety Rules என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிடத்தில் பாதுகாப்பாக வேலை செய்வதற்காக ஒவ்வொரு தொழிலாளியும் பின்பற்ற வேண்டிய அடிப்படை பாதுகாப்பு விதிகள்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'காயங்கள், பாதுகாப்பற்ற செயல்கள் மற்றும் தவிர்க்கக்கூடிய சம்பவங்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Site procedures-ஐ பின்பற்றுதல், PPE பயன்படுத்துதல், housekeeping பராமரித்தல், tools-ஐ சரியாக பயன்படுத்துதல் மற்றும் hazards-ஐ உடனடியாக report செய்தல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Workers பாதுகாப்பு நடைமுறைகளைப் பின்பற்ற வேண்டும். Supervisors compliance-ஐ கண்காணிக்க வேண்டும். Management training மற்றும் resources வழங்க வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'PPE, housekeeping, access, tools, electrical safety, signage, emergency equipment மற்றும் hazard reporting ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'PPE பயன்படுத்தாதது, unsafe tools, access block செய்தல், safety devices bypass செய்தல் மற்றும் warning signs-ஐ புறக்கணித்தல்.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Unsafe work-ஐ நிறுத்தி, approved procedures-ஐ பின்பற்றி, hazards-ஐ உடனடியாக report செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE Procedures, ADOSH-SF requirements மற்றும் பொருந்தும் UAE legislation.',
      },

      {
        'letter': 'C',
        'title': 'Dubai Code of Practice (CoP)',
        'desc':
            'Safety requirements and good practices applicable to construction and workplace activities in Dubai.',
        'English_title': 'Dubai Code of Practice (CoP)',
        'English_what': 'What is a Code of Practice?',
        'English_whatText':
            'A Code of Practice provides practical requirements or guidance for managing specific workplace safety risks. The applicable authority and current edition should always be checked before relying on a specific requirement.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide consistent safety practices and controls for specific activities and hazards.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify the applicable authority requirements, use the current approved documents, implement appropriate risk controls and maintain required records.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management and HSE personnel must identify applicable requirements. Supervisors must implement them at site level. Workers must follow the approved controls.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'Applicable authority identified, current document available, risk assessment completed, controls implemented, workers briefed and inspections recorded.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Using outdated requirements, missing risk controls, inadequate worker briefing, poor documentation and failure to inspect work activities.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain a legal and regulatory register, verify document revisions and ensure site procedures reflect current applicable requirements.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable Dubai authority requirements and current Codes of Practice. Always verify the latest official publication before compliance decisions.',
      },

      {
        'letter': 'D',
        'title': 'Daily Toolbox Talk (TBT)',
        'desc':
            'Daily safety briefing conducted before work starts.',
        'English_title': 'Daily Toolbox Talk (TBT)',
        'English_what': 'What is a Toolbox Talk?',
        'English_whatText':
            'A Toolbox Talk is a short, focused safety briefing conducted before work to discuss the planned activity, hazards, controls and relevant lessons.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure workers understand the day’s tasks, hazards, controls, emergency arrangements and expected safe behaviour.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Discuss the actual task, hazards and controls. Confirm worker understanding and competency where necessary. Record attendance and important observations.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisor or competent person leads the briefing. Workers participate, ask questions and raise hazards or concerns.',
        'English_checklist': 'TBT Checklist',
        'English_checklistText':
            'Task discussed, hazards identified, controls explained, PPE confirmed, equipment checked, emergency arrangements discussed and attendance recorded.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Conducting TBT only as a formality, discussing irrelevant topics, poor attendance, no worker participation and missing records.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep the briefing task-specific and interactive. Use recent incidents, site observations and lessons learned to improve awareness.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and site-specific risk assessments.',
      },

      {
        'letter': 'E',
        'title': 'Emergency Preparedness',
        'desc':
            'Planning and preparation for fires, accidents and other emergency situations.',
        'English_title': 'Emergency Preparedness',
        'English_what': 'What is Emergency Preparedness?',
        'English_whatText':
            'Emergency preparedness is the process of planning, organizing and preparing people and resources to respond effectively to foreseeable emergencies.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect life, reduce injuries and property damage, and enable an organized emergency response.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify credible emergencies, establish emergency procedures, provide alarms and communication methods, maintain suitable emergency equipment, identify assembly points and provide training and drills as required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources. Emergency teams and competent persons respond according to their roles. Workers follow alarms, evacuation instructions and assembly procedures.',
        'English_checklist': 'Emergency Checklist',
        'English_checklistText':
            'Emergency plan, alarm system, emergency contacts, evacuation routes, assembly point, fire equipment, first aid, emergency lighting, access for emergency services and drill records.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Blocked emergency exits, unavailable extinguishers, unclear assembly points, outdated contact lists, untrained personnel and poor emergency access.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Review emergency plans regularly, conduct suitable drills, investigate drill findings and close corrective actions.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE and local authority emergency requirements, company emergency response plan and relevant ADOSH-SF requirements.',
      },

      {
        'letter': 'F',
        'title': 'Fire Safety & Prevention',
        'desc':
            'Fire prevention, fire protection equipment and hot-work safety controls.',
        'English_title': 'Fire Safety & Prevention',
        'English_what': 'What is Fire Safety?',
        'English_whatText':
            'Fire safety involves preventing fires, detecting them early, protecting people and property, and ensuring a safe emergency response.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent fire incidents, limit fire spread and protect workers, visitors, assets and the environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Control ignition sources and combustible materials, maintain suitable fire extinguishers and fire systems, keep exits clear, control hot work and follow approved permit requirements where applicable.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides fire protection arrangements. Supervisors control fire hazards and hot work. Workers follow fire procedures and report fire hazards immediately.',
        'English_checklist': 'Fire Safety Checklist',
        'English_checklistText':
            'Fire extinguishers accessible and suitable, emergency exits clear, fire alarm systems maintained, combustible materials controlled, electrical equipment safe, hot-work controls in place and emergency contacts available.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Blocked exits, inaccessible extinguishers, uncontrolled ignition sources, poor housekeeping, unsafe electrical connections and hot work without required controls.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Apply the hierarchy of controls, maintain good housekeeping, inspect fire equipment, separate ignition sources from combustibles and use a proper hot-work control system.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE fire safety requirements, local authority requirements, company fire safety procedures and relevant ADOSH-SF requirements.',
      },
            {
        'letter': 'G',
        'title': 'Green Building Regulations',
        'desc':
            'UAE sustainable construction and environmental protection requirements.',

        'English_title': 'Green Building Regulations',
        'English_what': 'What are Green Building Regulations?',
        'English_whatText':
            'Green Building Regulations are requirements and practices that promote sustainable construction, energy efficiency, water conservation, responsible material use and environmental protection.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce environmental impact, conserve resources, improve building efficiency and support a healthier working and living environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Follow approved environmental procedures, control waste, prevent pollution, conserve water and energy, and use approved sustainable materials and systems where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management shall provide resources and procedures. Supervisors shall monitor implementation. Workers shall follow environmental controls and report spills, waste issues and unsafe practices.',
        'English_checklist': 'Checklist',
        'English_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation, approved materials, housekeeping and environmental inspections.',
        'English_violations': 'Violations',
        'English_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution, unnecessary resource consumption and failure to follow approved environmental procedures may require corrective action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan environmental controls before work, segregate waste at source, prevent pollution, monitor resource consumption and maintain good housekeeping throughout the project.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE environmental requirements, local authority requirements and approved project environmental procedures.',

        'Hindi_title': 'Green Building Regulations',
        'Hindi_what': 'Green Building Regulations क्या हैं?',
        'Hindi_whatText':
            'Green Building Regulations ऐसी आवश्यकताएँ और practices हैं जो sustainable construction, energy efficiency, water conservation और environmental protection को बढ़ावा देती हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'पर्यावरणीय प्रभाव कम करना, संसाधनों का संरक्षण करना और building efficiency में सुधार करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Approved environmental procedures का पालन करें, waste control करें, pollution रोकें और water तथा energy conserve करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources और procedures प्रदान करे। Supervisors implementation monitor करें। Workers environmental controls का पालन करें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation और environmental inspection की जाँच करें।',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution और environmental procedures का पालन न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Work शुरू करने से पहले environmental controls plan करें और waste को source पर segregate करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE environmental requirements, local authority requirements और approved project environmental procedures।',

        'Malayalam_title': 'Green Building Regulations',
        'Malayalam_what': 'Green Building Regulations എന്താണ്?',
        'Malayalam_whatText':
            'Sustainable construction, energy efficiency, water conservation, responsible material use, environmental protection എന്നിവ പ്രോത്സാഹിപ്പിക്കുന്ന ആവശ്യകതകളും നടപടിക്രമങ്ങളുമാണ് Green Building Regulations.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Environmental impact കുറയ്ക്കുക, resources സംരക്ഷിക്കുക, building efficiency മെച്ചപ്പെടുത്തുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Approved environmental procedures പാലിക്കുക, waste control ചെയ്യുക, pollution തടയുക, water/energy conserve ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Supervisors implementation monitor ചെയ്യണം. Workers environmental controls പാലിക്കണം.',
        'Malayalam_checklist': 'Checklist',
        'Malayalam_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation, housekeeping, environmental inspections എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution, unnecessary resource consumption, environmental procedures പാലിക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Work തുടങ്ങുന്നതിന് മുമ്പ് environmental controls plan ചെയ്യുക, waste source-ൽ തന്നെ segregate ചെയ്യുക, pollution തടയുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE environmental requirements, local authority requirements, approved project environmental procedures.',

        'Tamil_title': 'Green Building Regulations',
        'Tamil_what': 'Green Building Regulations என்றால் என்ன?',
        'Tamil_whatText':
            'Sustainable construction, energy efficiency, water conservation மற்றும் environmental protection ஆகியவற்றை ஊக்குவிக்கும் தேவைகள் மற்றும் நடைமுறைகள்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'சுற்றுச்சூழல் பாதிப்பைக் குறைத்து, வளங்களைப் பாதுகாத்து, building efficiency-ஐ மேம்படுத்துதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Approved environmental procedures-ஐ பின்பற்றி, waste control செய்து, pollution தடுத்து, water மற்றும் energy-ஐ சேமிக்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources மற்றும் procedures வழங்க வேண்டும். Supervisors implementation-ஐ monitor செய்ய வேண்டும். Workers environmental controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Checklist',
        'Tamil_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation மற்றும் environmental inspections ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution மற்றும் environmental procedures-ஐ பின்பற்றாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'வேலை தொடங்குவதற்கு முன் environmental controls-ஐ திட்டமிட்டு, waste-ஐ source-ல் segregate செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE environmental requirements, local authority requirements மற்றும் approved project environmental procedures.',
      },
            {
        'letter': 'H',
        'title': 'Housekeeping & Workplace Cleanliness',
        'desc':
            'Good housekeeping practices for a clean, organized and safe workplace.',

        'English_title': 'Housekeeping & Workplace Cleanliness',
        'English_what': 'What is Good Housekeeping?',
        'English_whatText':
            'Good housekeeping means keeping the workplace clean, organized and free from unnecessary hazards such as waste, spills, obstructions and poor storage.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent slips, trips, falls, fire hazards, blocked access and other workplace incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Maintain clean work areas, remove waste regularly, keep access routes clear, store materials safely, control spills and maintain proper waste segregation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable arrangements. Supervisors monitor housekeeping standards. Workers keep their work areas clean and report unsafe conditions.',
        'English_checklist': 'Housekeeping Checklist',
        'English_checklistText':
            'Clean floors, clear access routes, safe material storage, waste segregation, spill control, proper stacking, clear emergency exits and adequate lighting.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, oil or water spills, obstructed emergency exits and poor material storage.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Apply the clean-as-you-go principle, inspect housekeeping regularly and correct unsafe conditions immediately.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and relevant UAE workplace safety requirements.',

        'Hindi_title': 'Housekeeping & Workplace Cleanliness',
        'Hindi_what': 'Good Housekeeping क्या है?',
        'Hindi_whatText':
            'कार्यस्थल को साफ, व्यवस्थित और waste, spills तथा obstructions जैसे hazards से मुक्त रखना Good Housekeeping है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Slip, trip, fall, fire hazards और blocked access जैसी घटनाओं को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Work area साफ रखें, waste नियमित रूप से हटाएँ, access routes clear रखें, materials सुरक्षित रखें और spills को तुरंत control करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management उचित व्यवस्था करे। Supervisors housekeeping monitor करें। Workers अपना work area साफ रखें।',
        'Hindi_checklist': 'Housekeeping Checklist',
        'Hindi_checklistText':
            'Clean floors, clear access, safe storage, waste segregation, spill control, proper stacking और clear emergency exits की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, spills और poor material storage।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Clean-as-you-go principle अपनाएँ और unsafe conditions को तुरंत correct करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements और relevant UAE workplace safety requirements।',

        'Malayalam_title': 'Housekeeping & Workplace Cleanliness',
        'Malayalam_what': 'Good Housekeeping എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലം വൃത്തിയായും ക്രമമായും നിലനിർത്തുകയും waste, spills, obstructions തുടങ്ങിയ hazards ഒഴിവാക്കുകയും ചെയ്യുന്നതാണ് Good Housekeeping.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Slip, trip, fall, fire hazards, blocked access തുടങ്ങിയ workplace incidents തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Work area clean ആയി സൂക്ഷിക്കുക, waste regular ആയി നീക്കം ചെയ്യുക, access routes clear ആയി വയ്ക്കുക, materials safe ആയി store ചെയ്യുക, spills ഉടൻ control ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management ആവശ്യമായ arrangements നൽകണം. Supervisors housekeeping monitor ചെയ്യണം. Workers സ്വന്തം work area clean ആയി സൂക്ഷിക്കണം.',
        'Malayalam_checklist': 'Housekeeping Checklist',
        'Malayalam_checklistText':
            'Clean floors, clear access routes, safe material storage, waste segregation, spill control, proper stacking, clear emergency exits എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Waste accumulation, walkway block ചെയ്യൽ, unsafe stacking, oil/water spills, emergency exits obstruct ചെയ്യൽ, poor material storage.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Clean-as-you-go principle പാലിക്കുക. Housekeeping regular ആയി inspect ചെയ്ത് unsafe conditions ഉടൻ correct ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE workplace safety requirements.',

        'Tamil_title': 'Housekeeping & Workplace Cleanliness',
        'Tamil_what': 'Good Housekeeping என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிடத்தை சுத்தமாகவும் ஒழுங்காகவும் வைத்திருப்பதுடன் waste, spills மற்றும் obstructions போன்ற hazards-ஐ அகற்றுவது Good Housekeeping ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Slip, trip, fall, fire hazards மற்றும் blocked access போன்ற சம்பவங்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Work area-ஐ சுத்தமாக வைத்தல், waste-ஐ தொடர்ந்து அகற்றுதல், access routes-ஐ clear வைத்தல், materials-ஐ பாதுகாப்பாக சேமித்தல் மற்றும் spills-ஐ உடனடியாக control செய்தல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management தேவையான arrangements வழங்க வேண்டும். Supervisors housekeeping-ஐ monitor செய்ய வேண்டும். Workers தங்கள் work area-ஐ சுத்தமாக வைத்திருக்க வேண்டும்.',
        'Tamil_checklist': 'Housekeeping Checklist',
        'Tamil_checklistText':
            'Clean floors, clear access routes, safe storage, waste segregation, spill control, proper stacking மற்றும் emergency exits ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, oil/water spills மற்றும் poor material storage.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Clean-as-you-go principle-ஐ பின்பற்றி, unsafe conditions-ஐ உடனடியாக சரிசெய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements மற்றும் relevant UAE workplace safety requirements.',
      },
            {
        'letter': 'H',
        'title': 'Housekeeping & Workplace Cleanliness',
        'desc':
            'Good housekeeping practices for a clean, organized and safe workplace.',

        'English_title': 'Housekeeping & Workplace Cleanliness',
        'English_what': 'What is Good Housekeeping?',
        'English_whatText':
            'Good housekeeping means keeping the workplace clean, organized and free from unnecessary hazards such as waste, spills, obstructions and poor storage.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent slips, trips, falls, fire hazards, blocked access and other workplace incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Maintain clean work areas, remove waste regularly, keep access routes clear, store materials safely, control spills and maintain proper waste segregation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable arrangements. Supervisors monitor housekeeping standards. Workers keep their work areas clean and report unsafe conditions.',
        'English_checklist': 'Housekeeping Checklist',
        'English_checklistText':
            'Clean floors, clear access routes, safe material storage, waste segregation, spill control, proper stacking, clear emergency exits and adequate lighting.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, oil or water spills, obstructed emergency exits and poor material storage.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Apply the clean-as-you-go principle, inspect housekeeping regularly and correct unsafe conditions immediately.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and relevant UAE workplace safety requirements.',

        'Hindi_title': 'Housekeeping & Workplace Cleanliness',
        'Hindi_what': 'Good Housekeeping क्या है?',
        'Hindi_whatText':
            'कार्यस्थल को साफ, व्यवस्थित और waste, spills तथा obstructions जैसे hazards से मुक्त रखना Good Housekeeping है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Slip, trip, fall, fire hazards और blocked access जैसी घटनाओं को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Work area साफ रखें, waste नियमित रूप से हटाएँ, access routes clear रखें, materials सुरक्षित रखें और spills को तुरंत control करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management उचित व्यवस्था करे। Supervisors housekeeping monitor करें। Workers अपना work area साफ रखें।',
        'Hindi_checklist': 'Housekeeping Checklist',
        'Hindi_checklistText':
            'Clean floors, clear access, safe storage, waste segregation, spill control, proper stacking और clear emergency exits की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, spills और poor material storage।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Clean-as-you-go principle अपनाएँ और unsafe conditions को तुरंत correct करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements और relevant UAE workplace safety requirements।',

        'Malayalam_title': 'Housekeeping & Workplace Cleanliness',
        'Malayalam_what': 'Good Housekeeping എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലം വൃത്തിയായും ക്രമമായും നിലനിർത്തുകയും waste, spills, obstructions തുടങ്ങിയ hazards ഒഴിവാക്കുകയും ചെയ്യുന്നതാണ് Good Housekeeping.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Slip, trip, fall, fire hazards, blocked access തുടങ്ങിയ workplace incidents തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Work area clean ആയി സൂക്ഷിക്കുക, waste regular ആയി നീക്കം ചെയ്യുക, access routes clear ആയി വയ്ക്കുക, materials safe ആയി store ചെയ്യുക, spills ഉടൻ control ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management ആവശ്യമായ arrangements നൽകണം. Supervisors housekeeping monitor ചെയ്യണം. Workers സ്വന്തം work area clean ആയി സൂക്ഷിക്കണം.',
        'Malayalam_checklist': 'Housekeeping Checklist',
        'Malayalam_checklistText':
            'Clean floors, clear access routes, safe material storage, waste segregation, spill control, proper stacking, clear emergency exits എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Waste accumulation, walkway block ചെയ്യൽ, unsafe stacking, oil/water spills, emergency exits obstruct ചെയ്യൽ, poor material storage.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Clean-as-you-go principle പാലിക്കുക. Housekeeping regular ആയി inspect ചെയ്ത് unsafe conditions ഉടൻ correct ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE workplace safety requirements.',

        'Tamil_title': 'Housekeeping & Workplace Cleanliness',
        'Tamil_what': 'Good Housekeeping என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிடத்தை சுத்தமாகவும் ஒழுங்காகவும் வைத்திருப்பதுடன் waste, spills மற்றும் obstructions போன்ற hazards-ஐ அகற்றுவது Good Housekeeping ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Slip, trip, fall, fire hazards மற்றும் blocked access போன்ற சம்பவங்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Work area-ஐ சுத்தமாக வைத்தல், waste-ஐ தொடர்ந்து அகற்றுதல், access routes-ஐ clear வைத்தல், materials-ஐ பாதுகாப்பாக சேமித்தல் மற்றும் spills-ஐ உடனடியாக control செய்தல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management தேவையான arrangements வழங்க வேண்டும். Supervisors housekeeping-ஐ monitor செய்ய வேண்டும். Workers தங்கள் work area-ஐ சுத்தமாக வைத்திருக்க வேண்டும்.',
        'Tamil_checklist': 'Housekeeping Checklist',
        'Tamil_checklistText':
            'Clean floors, clear access routes, safe storage, waste segregation, spill control, proper stacking மற்றும் emergency exits ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Waste accumulation, blocked walkways, unsafe stacking, oil/water spills மற்றும் poor material storage.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Clean-as-you-go principle-ஐ பின்பற்றி, unsafe conditions-ஐ உடனடியாக சரிசெய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements மற்றும் relevant UAE workplace safety requirements.',
      },
            {
        'letter': 'I',
        'title': 'Incident Reporting & Investigation',
        'desc':
            'Reporting, investigating and learning from workplace incidents and near misses.',

        'English_title': 'Incident Reporting & Investigation',
        'English_what': 'What is Incident Reporting & Investigation?',
        'English_whatText':
            'Incident reporting and investigation is the process of reporting workplace incidents and near misses, identifying their causes and implementing corrective actions to prevent recurrence.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify immediate and underlying causes, prevent recurrence, improve safety controls and support continuous improvement.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Report incidents and near misses promptly, preserve relevant evidence, investigate according to the severity and potential of the event, identify root causes and implement corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers must report incidents, injuries, hazards and near misses. Supervisors must secure the area and initiate reporting. HSE personnel support the investigation and corrective action process.',
        'English_checklist': 'Incident Investigation Checklist',
        'English_checklistText':
            'Incident reported, area secured, injured persons assisted, evidence preserved, witnesses identified, facts collected, causes analyzed, corrective actions assigned and close-out verified.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to report incidents, delayed reporting, incomplete investigation, blaming individuals without identifying system causes and failure to close corrective actions.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Focus on facts and root causes rather than blame. Share lessons learned and verify that corrective actions are effective.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company incident reporting procedure, applicable ADOSH-SF requirements and relevant UAE workplace safety requirements.',

        'Hindi_title': 'Incident Reporting & Investigation',
        'Hindi_what': 'Incident Reporting & Investigation क्या है?',
        'Hindi_whatText':
            'कार्यस्थल की घटनाओं और near misses की रिपोर्ट करना, उनके कारणों की जाँच करना और दोबारा घटना रोकने के लिए corrective actions लागू करना Incident Reporting & Investigation है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'घटना के immediate और underlying causes की पहचान करना तथा भविष्य में ऐसी घटनाओं को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Incidents और near misses की तुरंत रिपोर्ट करें, evidence सुरक्षित रखें, घटना की गंभीरता के अनुसार investigation करें और corrective actions लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Workers incidents और near misses report करें। Supervisors area को सुरक्षित करें और reporting शुरू करें। HSE team investigation में सहायता करे।',
        'Hindi_checklist': 'Incident Investigation Checklist',
        'Hindi_checklistText':
            'Incident reported, area secured, injured persons assisted, evidence preserved, witnesses identified, causes analyzed और corrective actions closed की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Incident report न करना, delayed reporting, incomplete investigation और corrective actions close न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Blame के बजाय facts और root causes पर ध्यान दें। Lessons learned को workers के साथ share करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company incident reporting procedure, applicable ADOSH-SF requirements और relevant UAE workplace safety requirements।',

        'Malayalam_title': 'Incident Reporting & Investigation',
        'Malayalam_what': 'Incident Reporting & Investigation എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്തെ incidents, injuries, near misses എന്നിവ report ചെയ്യുകയും അവയുടെ കാരണങ്ങൾ അന്വേഷിക്കുകയും ആവർത്തനം തടയാൻ corrective actions നടപ്പാക്കുകയും ചെയ്യുന്ന പ്രക്രിയയാണ് Incident Reporting & Investigation.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Immediate, underlying, root causes തിരിച്ചറിയുകയും incident വീണ്ടും സംഭവിക്കുന്നത് തടയുകയും safety controls മെച്ചപ്പെടുത്തുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Incidents, injuries, near misses എന്നിവ ഉടൻ report ചെയ്യുക, evidence preserve ചെയ്യുക, incident severity അനുസരിച്ച് investigation നടത്തുക, root causes കണ്ടെത്തി corrective actions നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Workers incidents, injuries, hazards, near misses എന്നിവ report ചെയ്യണം. Supervisors area secure ചെയ്ത് reporting ആരംഭിക്കണം. HSE team investigation, corrective action process എന്നിവയിൽ support നൽകണം.',
        'Malayalam_checklist': 'Incident Investigation Checklist',
        'Malayalam_checklistText':
            'Incident report ചെയ്തോ, area secure ചെയ്തോ, injured person-ന് സഹായം നൽകിയോ, evidence preserve ചെയ്തോ, witnesses തിരിച്ചറിഞ്ഞോ, causes analyze ചെയ്തോ, corrective actions assign/close ചെയ്തോ എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Incident report ചെയ്യാത്തത്, delayed reporting, incomplete investigation, വ്യക്തിയെ മാത്രം കുറ്റപ്പെടുത്തൽ, corrective actions close ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Blame ചെയ്യുന്നതിന് പകരം facts, root causes എന്നിവയിൽ focus ചെയ്യുക. Lessons learned workers-ുമായി share ചെയ്യുകയും corrective actions effective ആണെന്ന് verify ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company Incident Reporting Procedure, ബാധകമായ ADOSH-SF requirements, relevant UAE workplace safety requirements.',

        'Tamil_title': 'Incident Reporting & Investigation',
        'Tamil_what': 'Incident Reporting & Investigation என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட incidents மற்றும் near misses-ஐ report செய்து, அவற்றின் காரணங்களை ஆய்வு செய்து, மீண்டும் நிகழாமல் தடுப்பதற்கான corrective actions செயல்படுத்தும் செயல்முறை.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Immediate மற்றும் underlying causes-ஐ கண்டறிந்து, incidents மீண்டும் நிகழ்வதைத் தடுப்பது மற்றும் safety controls-ஐ மேம்படுத்துவது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Incidents மற்றும் near misses-ஐ உடனடியாக report செய்ய வேண்டும். Evidence-ஐ பாதுகாத்து, incident severity-க்கு ஏற்ப investigation செய்து, root causes கண்டறிந்து corrective actions செயல்படுத்த வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Workers incidents மற்றும் near misses-ஐ report செய்ய வேண்டும். Supervisors area-ஐ secure செய்து reporting தொடங்க வேண்டும். HSE team investigation-க்கு support வழங்க வேண்டும்.',
        'Tamil_checklist': 'Incident Investigation Checklist',
        'Tamil_checklistText':
            'Incident report, area secured, injured persons assisted, evidence preserved, witnesses identified, causes analyzed மற்றும் corrective actions close செய்யப்பட்டுள்ளதா என்பதைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Incident report செய்யாதது, delayed reporting, incomplete investigation மற்றும் corrective actions close செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Blame செய்வதற்குப் பதிலாக facts மற்றும் root causes மீது கவனம் செலுத்தவும். Lessons learned-ஐ workers உடன் பகிர்ந்து corrective actions effective என்பதை verify செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company Incident Reporting Procedure, applicable ADOSH-SF requirements மற்றும் relevant UAE workplace safety requirements.',
      },
            {
        'letter': 'J',
        'title': 'Job Safety Analysis (JSA)',
        'desc':
            'Systematic identification of job hazards and controls before work starts.',

        'English_title': 'Job Safety Analysis (JSA)',
        'English_what': 'What is Job Safety Analysis?',
        'English_whatText':
            'Job Safety Analysis is a systematic process of breaking a job into steps, identifying hazards associated with each step and establishing appropriate controls before the work begins.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify hazards before work starts, reduce risk and establish safe methods of work.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Define the job steps, identify hazards, assess risks, establish controls, communicate the JSA to workers and review it when conditions or the work scope changes.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisors and competent persons prepare or review the JSA. Workers participate, understand the controls and follow the approved safe work method.',
        'English_checklist': 'JSA Checklist',
        'English_checklistText':
            'Job steps identified, hazards identified, risks assessed, controls established, PPE identified, workers briefed, permits checked and JSA reviewed when conditions change.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Using generic JSA, missing job steps, incomplete hazard identification, inadequate controls, workers not briefed and failure to review the JSA after changes.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Involve workers in the JSA process, focus on task-specific hazards and apply the hierarchy of controls before relying on PPE.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements, approved risk assessments and safe work procedures.',

        'Hindi_title': 'Job Safety Analysis (JSA)',
        'Hindi_what': 'Job Safety Analysis क्या है?',
        'Hindi_whatText':
            'Job Safety Analysis एक systematic process है जिसमें job को steps में बाँटकर प्रत्येक step के hazards की पहचान की जाती है और काम शुरू होने से पहले controls तय किए जाते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'काम शुरू होने से पहले hazards की पहचान करना, risk कम करना और safe work method स्थापित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Job steps define करें, hazards identify करें, risks assess करें, controls establish करें और workers को JSA समझाएँ। Conditions बदलने पर JSA review करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Supervisors और competent persons JSA तैयार या review करें। Workers participate करें और approved controls का पालन करें।',
        'Hindi_checklist': 'JSA Checklist',
        'Hindi_checklistText':
            'Job steps, hazards, risk assessment, controls, PPE, worker briefing और permits की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Generic JSA का उपयोग, hazards की incomplete identification, inadequate controls और workers को briefing न देना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Workers को JSA process में शामिल करें और task-specific hazards पर ध्यान दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements, approved risk assessments और safe work procedures।',

        'Malayalam_title': 'Job Safety Analysis (JSA)',
        'Malayalam_what': 'Job Safety Analysis എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു ജോലി ചെറിയ ഘട്ടങ്ങളായി വിഭജിച്ച് ഓരോ ഘട്ടത്തിലുമുള്ള hazards തിരിച്ചറിയുകയും ജോലി തുടങ്ങുന്നതിന് മുമ്പ് ആവശ്യമായ controls നിശ്ചയിക്കുകയും ചെയ്യുന്ന systematic process ആണ് JSA.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് hazards തിരിച്ചറിയുക, risk കുറയ്ക്കുക, safe work method സ്ഥാപിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Job steps തിരിച്ചറിയുക, hazards കണ്ടെത്തുക, risks assess ചെയ്യുക, controls നിശ്ചയിക്കുക, workers-നെ JSA brief ചെയ്യുക. Conditions മാറുമ്പോൾ JSA review ചെയ്യണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Supervisors/competent persons JSA തയ്യാറാക്കുകയോ review ചെയ്യുകയോ വേണം. Workers പങ്കെടുക്കുകയും approved controls പാലിക്കുകയും വേണം.',
        'Malayalam_checklist': 'JSA Checklist',
        'Malayalam_checklistText':
            'Job steps, hazards, risk assessment, controls, PPE, worker briefing, permits എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Generic JSA ഉപയോഗിക്കൽ, job steps miss ചെയ്യൽ, hazards ശരിയായി തിരിച്ചറിയാത്തത്, inadequate controls, worker briefing ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'JSA തയ്യാറാക്കുമ്പോൾ workers-നെ ഉൾപ്പെടുത്തുക. Task-specific hazards-ൽ focus ചെയ്യുകയും PPE-ക്ക് മുമ്പ് hierarchy of controls പ്രയോഗിക്കുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE procedures, ബാധകമായ ADOSH-SF requirements, approved Risk Assessments, Safe Work Procedures.',

        'Tamil_title': 'Job Safety Analysis (JSA)',
        'Tamil_what': 'Job Safety Analysis என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு வேலையை சிறிய steps-ஆக பிரித்து, ஒவ்வொரு step-இலும் உள்ள hazards-ஐ கண்டறிந்து, வேலை தொடங்குவதற்கு முன் தேவையான controls-ஐ நிர்ணயிக்கும் systematic process JSA ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'வேலை தொடங்குவதற்கு முன் hazards-ஐ கண்டறிந்து risk-ஐ குறைத்து safe work method-ஐ உருவாக்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Job steps-ஐ வரையறுத்து, hazards-ஐ கண்டறிந்து, risks-ஐ assess செய்து, controls அமைத்து, workers-க்கு JSA briefing வழங்க வேண்டும். Conditions மாறினால் JSA-ஐ review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Supervisors/competent persons JSA-ஐ தயாரிக்க அல்லது review செய்ய வேண்டும். Workers கலந்து கொண்டு approved controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'JSA Checklist',
        'Tamil_checklistText':
            'Job steps, hazards, risk assessment, controls, PPE, worker briefing மற்றும் permits ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Generic JSA பயன்படுத்துதல், hazards-ஐ முழுமையாக கண்டறியாதது, inadequate controls மற்றும் workers-க்கு briefing வழங்காதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'JSA process-ல் workers-ஐ ஈடுபடுத்தி task-specific hazards மீது கவனம் செலுத்தவும். PPE-க்கு முன் hierarchy of controls பயன்படுத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements, approved Risk Assessments மற்றும் Safe Work Procedures.',
      },
            {
        'letter': 'K',
        'title': 'Key Safety Responsibilities',
        'desc':
            'Essential safety responsibilities of management, supervisors, workers and HSE personnel.',

        'English_title': 'Key Safety Responsibilities',
        'English_what': 'What are Key Safety Responsibilities?',
        'English_whatText':
            'Key safety responsibilities define the duties of management, supervisors, HSE personnel, workers and other persons in maintaining a safe workplace.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure everyone understands their safety duties and actively contributes to preventing incidents and controlling workplace risks.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Define roles and responsibilities, provide adequate resources and training, implement safe work procedures, communicate hazards and monitor compliance with safety requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides leadership and resources. Supervisors implement safe work practices. HSE personnel provide guidance and monitoring. Workers follow procedures, use PPE and report hazards.',
        'English_checklist': 'Safety Responsibilities Checklist',
        'English_checklistText':
            'Roles defined, competent persons appointed, training provided, procedures communicated, PPE available, inspections completed, hazards reported and corrective actions followed up.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unclear responsibilities, inadequate supervision, lack of training, failure to provide resources, unsafe work practices and failure to report hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Clearly communicate responsibilities, lead by example, encourage worker participation and hold responsible persons accountable for safety performance.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE policy and procedures, applicable ADOSH-SF requirements and relevant UAE workplace safety requirements.',

        'Hindi_title': 'Key Safety Responsibilities',
        'Hindi_what': 'Key Safety Responsibilities क्या हैं?',
        'Hindi_whatText':
            'Management, Supervisors, HSE personnel और Workers की safety duties और responsibilities को स्पष्ट करना Key Safety Responsibilities का उद्देश्य है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'सभी लोगों को अपनी safety duties समझाना और workplace risks को नियंत्रित करने में उनकी भागीदारी सुनिश्चित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Roles और responsibilities define करें, resources और training दें, safe work procedures लागू करें और safety compliance monitor करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management leadership और resources प्रदान करे। Supervisors safe work practices लागू करें। HSE personnel guidance और monitoring करें। Workers procedures और PPE requirements का पालन करें।',
        'Hindi_checklist': 'Safety Responsibilities Checklist',
        'Hindi_checklistText':
            'Roles defined, competent persons appointed, training provided, procedures communicated, PPE available, inspections completed और hazards reported हैं या नहीं जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Responsibilities unclear होना, inadequate supervision, training की कमी, resources उपलब्ध न कराना और hazards report न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Responsibilities स्पष्ट रूप से communicate करें, example set करें, workers को safety activities में शामिल करें और accountability सुनिश्चित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE policy और procedures, applicable ADOSH-SF requirements और relevant UAE workplace safety requirements।',

        'Malayalam_title': 'Key Safety Responsibilities',
        'Malayalam_what': 'Key Safety Responsibilities എന്താണ്?',
        'Malayalam_whatText':
            'Management, Supervisors, HSE personnel, Workers എന്നിവരുടെ safety duties, roles, responsibilities എന്നിവ വ്യക്തമായി നിർവചിക്കുന്നതാണ് Key Safety Responsibilities.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഓരോരുത്തരും അവരുടെ safety duties മനസ്സിലാക്കുകയും workplace risks നിയന്ത്രിക്കുന്നതിൽ സജീവമായി പങ്കെടുക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Roles/responsibilities define ചെയ്യുക, ആവശ്യമായ resources/training നൽകുക, safe work procedures നടപ്പാക്കുക, hazards communicate ചെയ്യുക, safety compliance monitor ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management leadership, resources നൽകണം. Supervisors safe work practices implement ചെയ്യണം. HSE personnel guidance/monitoring നൽകണം. Workers procedures, PPE എന്നിവ പാലിക്കുകയും hazards report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Safety Responsibilities Checklist',
        'Malayalam_checklistText':
            'Roles defined ആണോ, competent persons appointed ആണോ, training നൽകിയോ, procedures communicate ചെയ്തോ, PPE available ആണോ, inspections completed ആണോ, hazards report ചെയ്യുന്നുണ്ടോ എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Responsibilities വ്യക്തമല്ലാത്തത്, inadequate supervision, training ഇല്ലായ്മ, resources നൽകാത്തത്, unsafe work practices, hazards report ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Responsibilities വ്യക്തമായി communicate ചെയ്യുക, management മുതൽ workers വരെ safety-ൽ example നൽകുക, worker participation പ്രോത്സാഹിപ്പിക്കുക, accountability ഉറപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE Policy and Procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE workplace safety requirements.',

        'Tamil_title': 'Key Safety Responsibilities',
        'Tamil_what': 'Key Safety Responsibilities என்றால் என்ன?',
        'Tamil_whatText':
            'Management, Supervisors, HSE personnel மற்றும் Workers ஆகியோரின் safety duties மற்றும் responsibilities-ஐ தெளிவாக வரையறுப்பதே Key Safety Responsibilities ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'ஒவ்வொருவரும் தங்கள் safety duties-ஐ புரிந்து கொண்டு workplace risks-ஐ கட்டுப்படுத்துவதில் பங்கேற்பதை உறுதி செய்தல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Roles மற்றும் responsibilities-ஐ வரையறுத்து, resources மற்றும் training வழங்கி, safe work procedures-ஐ செயல்படுத்தி, hazards-ஐ communicate செய்து safety compliance-ஐ monitor செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management leadership மற்றும் resources வழங்க வேண்டும். Supervisors safe work practices-ஐ செயல்படுத்த வேண்டும். HSE personnel guidance மற்றும் monitoring வழங்க வேண்டும். Workers procedures மற்றும் PPE-ஐ பின்பற்றி hazards-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Safety Responsibilities Checklist',
        'Tamil_checklistText':
            'Roles defined, competent persons appointed, training provided, procedures communicated, PPE available, inspections completed மற்றும் hazards reported ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Responsibilities தெளிவில்லாமை, inadequate supervision, training இல்லாமை, resources வழங்காதது மற்றும் hazards report செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Responsibilities-ஐ தெளிவாக communicate செய்து, safety leadership-ஐ promote செய்து, workers participation மற்றும் accountability-ஐ உறுதி செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE Policy and Procedures, applicable ADOSH-SF requirements மற்றும் relevant UAE workplace safety requirements.',
      },
            {
        'letter': 'L',
        'title': 'Lifting Operations & Rigging',
        'desc':
            'Safe planning, lifting equipment control and rigging practices for lifting operations.',

        'English_title': 'Lifting Operations & Rigging',
        'English_what': 'What are Lifting Operations & Rigging?',
        'English_whatText':
            'Lifting operations involve raising, lowering or moving loads using cranes, hoists or other lifting equipment. Rigging involves selecting and attaching suitable lifting accessories to safely handle the load.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent dropped loads, equipment failure, struck-by incidents, crushing injuries and other lifting-related accidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Plan lifting operations, identify load weight and centre of gravity, use suitable certified equipment and accessories, inspect lifting gear, establish exclusion zones and ensure competent persons control the operation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable equipment and competent resources. Supervisors ensure the lifting plan and controls are implemented. Riggers and operators perform their duties safely and follow approved procedures.',
        'English_checklist': 'Lifting Checklist',
        'English_checklistText':
            'Lifting plan, equipment inspection, valid certification, load weight, lifting accessories, safe working load, ground condition, exclusion zone, communication, weather conditions and competent personnel.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Overloading, damaged slings, uncertified lifting equipment, improper rigging, lifting over people, inadequate exclusion zones and unauthorized operation.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a documented lifting plan, inspect equipment before use, select the correct lifting accessories, maintain clear communication and never allow people under suspended loads.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements, manufacturer instructions and company lifting procedures.',

        'Hindi_title': 'Lifting Operations & Rigging',
        'Hindi_what': 'Lifting Operations & Rigging क्या है?',
        'Hindi_whatText':
            'Crane, hoist या अन्य lifting equipment से load को उठाने, नीचे करने या स्थानांतरित करने की प्रक्रिया Lifting Operation है। Rigging में load को सुरक्षित रूप से उठाने के लिए सही lifting accessories का चयन और attachment शामिल है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Dropped load, equipment failure, struck-by और crushing injuries जैसे lifting accidents को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Lifting plan तैयार करें, load weight और centre of gravity पहचानें, certified equipment और lifting accessories उपयोग करें, equipment inspect करें और exclusion zone स्थापित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable equipment और competent resources प्रदान करे। Supervisors lifting controls लागू करें। Riggers और operators approved procedures का पालन करें।',
        'Hindi_checklist': 'Lifting Checklist',
        'Hindi_checklistText':
            'Lifting plan, equipment inspection, certification, load weight, lifting accessories, SWL, ground condition, exclusion zone, communication और competent personnel की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Overloading, damaged slings, uncertified equipment, improper rigging, suspended load के नीचे लोगों का होना और unauthorized operation।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Documented lifting plan का उपयोग करें, equipment को pre-use inspect करें, सही lifting accessories चुनें और suspended load के नीचे किसी को भी न जाने दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements, manufacturer instructions और company lifting procedures।',

        'Malayalam_title': 'Lifting Operations & Rigging',
        'Malayalam_what': 'Lifting Operations & Rigging എന്താണ്?',
        'Malayalam_whatText':
            'Crane, hoist അല്ലെങ്കിൽ മറ്റ് lifting equipment ഉപയോഗിച്ച് load ഉയർത്തുകയോ താഴ്ത്തുകയോ മാറ്റുകയോ ചെയ്യുന്ന പ്രവർത്തനമാണ് Lifting Operation. Load സുരക്ഷിതമായി ഉയർത്തുന്നതിനായി ശരിയായ lifting accessories തിരഞ്ഞെടുക്കുകയും ഘടിപ്പിക്കുകയും ചെയ്യുന്നതാണ് Rigging.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Dropped load, equipment failure, struck-by incidents, crushing injuries തുടങ്ങിയ lifting-related അപകടങ്ങൾ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Lifting plan തയ്യാറാക്കുക, load weight/centre of gravity തിരിച്ചറിയുക, certified equipment/accessories ഉപയോഗിക്കുക, lifting gear inspect ചെയ്യുക, exclusion zone സ്ഥാപിക്കുക, competent persons ഉപയോഗിച്ച് operation നിയന്ത്രിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable equipment, competent resources നൽകണം. Supervisors lifting plan/control നടപ്പാക്കണം. Riggers, operators എന്നിവർ approved procedures പാലിച്ച് സുരക്ഷിതമായി പ്രവർത്തിക്കണം.',
        'Malayalam_checklist': 'Lifting Checklist',
        'Malayalam_checklistText':
            'Lifting plan, equipment inspection, valid certification, load weight, lifting accessories, SWL, ground condition, exclusion zone, communication, weather condition, competent personnel എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Overloading, damaged slings, uncertified lifting equipment, improper rigging, suspended load-ന്റെ താഴെ ആളുകൾ നിൽക്കൽ, inadequate exclusion zone, unauthorized operation.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Documented lifting plan ഉപയോഗിക്കുക, equipment pre-use inspection നടത്തുക, ശരിയായ lifting accessories തിരഞ്ഞെടുക്കുക, clear communication ഉറപ്പാക്കുക, suspended load-ന്റെ താഴെ ആളുകളെ അനുവദിക്കരുത്.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE requirements, ADOSH-SF requirements, manufacturer instructions, company lifting procedures.',

        'Tamil_title': 'Lifting Operations & Rigging',
        'Tamil_what': 'Lifting Operations & Rigging என்றால் என்ன?',
        'Tamil_whatText':
            'Crane, hoist அல்லது பிற lifting equipment மூலம் load-ஐ தூக்குதல், இறக்குதல் அல்லது நகர்த்துதல் Lifting Operation ஆகும். Load-ஐ பாதுகாப்பாக தூக்குவதற்கு சரியான lifting accessories-ஐ தேர்வு செய்து இணைப்பது Rigging ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Dropped load, equipment failure, struck-by incidents மற்றும் crushing injuries போன்ற lifting-related accidents-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Lifting plan தயாரித்து, load weight மற்றும் centre of gravity-ஐ கண்டறிந்து, certified equipment மற்றும் lifting accessories பயன்படுத்தி, lifting gear-ஐ inspect செய்து exclusion zone அமைக்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management suitable equipment மற்றும் competent resources வழங்க வேண்டும். Supervisors lifting controls-ஐ செயல்படுத்த வேண்டும். Riggers மற்றும் operators approved procedures-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Lifting Checklist',
        'Tamil_checklistText':
            'Lifting plan, equipment inspection, certification, load weight, lifting accessories, SWL, ground condition, exclusion zone, communication மற்றும் competent personnel ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Overloading, damaged slings, uncertified lifting equipment, improper rigging, suspended load-க்கு கீழே மக்கள் இருப்பது மற்றும் unauthorized operation.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Documented lifting plan பயன்படுத்தவும், equipment-ஐ pre-use inspect செய்யவும், சரியான lifting accessories தேர்வு செய்யவும், clear communication உறுதி செய்யவும், suspended load-க்கு கீழே யாரையும் அனுமதிக்க வேண்டாம்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE requirements, ADOSH-SF requirements, manufacturer instructions மற்றும் company lifting procedures.',
      },
            {
        'letter': 'N',
        'title': 'Noise & Hearing Conservation',
        'desc':
            'Workplace noise control and hearing protection practices.',

        'English_title': 'Noise & Hearing Conservation',
        'English_what': 'What is Noise Exposure?',
        'English_whatText':
            'Noise exposure occurs when workers are exposed to sound levels that may affect hearing or cause other health and safety risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent occupational hearing loss and reduce the risks associated with excessive workplace noise.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify noisy activities, assess noise exposure, apply engineering and administrative controls, maintain equipment and provide suitable hearing protection where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides noise controls and suitable PPE. Supervisors monitor compliance. Workers use hearing protection correctly and report excessive noise or damaged equipment.',
        'English_checklist': 'Noise Safety Checklist',
        'English_checklistText':
            'Noise sources identified, exposure assessed, equipment maintained, noisy areas controlled, warning signs provided, hearing protection available and workers trained.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working in high-noise areas without protection, removing hearing protection, inadequate noise assessment, poor equipment maintenance and failure to follow designated controls.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Control noise at source where practicable, maintain equipment, limit exposure time, establish hearing protection zones and provide suitable hearing conservation training.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements and company noise control procedures.',

        'Hindi_title': 'Noise & Hearing Conservation',
        'Hindi_what': 'Noise Exposure क्या है?',
        'Hindi_whatText':
            'जब workers ऐसे sound levels के संपर्क में आते हैं जो hearing को नुकसान पहुँचा सकते हैं, उसे Noise Exposure कहा जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Occupational hearing loss को रोकना और excessive workplace noise से होने वाले risks को कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Noise sources की पहचान करें, exposure assess करें, engineering और administrative controls लागू करें और आवश्यक होने पर suitable hearing protection प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management noise controls और PPE प्रदान करे। Supervisors compliance monitor करें। Workers hearing protection सही तरीके से उपयोग करें और excessive noise report करें।',
        'Hindi_checklist': 'Noise Safety Checklist',
        'Hindi_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, warning signs, hearing protection और worker training की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'High-noise area में hearing protection के बिना काम करना, PPE हटाना, inadequate noise assessment और equipment maintenance की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो noise को source पर control करें, equipment maintain करें, exposure time कम करें और hearing protection zones स्थापित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements और company noise control procedures।',

        'Malayalam_title': 'Noise & Hearing Conservation',
        'Malayalam_what': 'Noise Exposure എന്താണ്?',
        'Malayalam_whatText':
            'കേൾവിക്ക് ദോഷം ഉണ്ടാക്കാൻ സാധ്യതയുള്ള ഉയർന്ന ശബ്ദനിലവാരത്തിന് തൊഴിലാളികൾ exposure ആകുന്ന സാഹചര്യമാണ് Noise Exposure.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Occupational hearing loss തടയുകയും excessive workplace noise മൂലമുള്ള അപകടസാധ്യത കുറയ്ക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Noise sources തിരിച്ചറിയുക, noise exposure assess ചെയ്യുക, engineering/administrative controls നടപ്പാക്കുക, equipment maintain ചെയ്യുക, ആവശ്യമായിടത്ത് suitable hearing protection നൽകുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management noise controls, suitable PPE എന്നിവ നൽകണം. Supervisors compliance monitor ചെയ്യണം. Workers hearing protection ശരിയായി ഉപയോഗിക്കുകയും excessive noise report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Noise Safety Checklist',
        'Malayalam_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, noisy area controls, warning signs, hearing protection, worker training എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'High-noise area-യിൽ hearing protection ഇല്ലാതെ ജോലി ചെയ്യൽ, hearing protection നീക്കം ചെയ്യൽ, noise assessment ഇല്ലായ്മ, equipment maintenance കുറവ്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമെങ്കിൽ noise source-ൽ തന്നെ control ചെയ്യുക, equipment maintain ചെയ്യുക, exposure time കുറയ്ക്കുക, hearing protection zones സ്ഥാപിക്കുക, workers-ന് training നൽകുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE occupational safety requirements, ADOSH-SF requirements, company noise control procedures.',

        'Tamil_title': 'Noise & Hearing Conservation',
        'Tamil_what': 'Noise Exposure என்றால் என்ன?',
        'Tamil_whatText':
            'கேள்வித்திறனை பாதிக்கக்கூடிய அதிக சத்தத்திற்கு workers exposure ஆகும் நிலை Noise Exposure எனப்படுகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Occupational hearing loss-ஐ தடுப்பதும் அதிகமான workplace noise-ன் அபாயங்களை குறைப்பதும் நோக்கமாகும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Noise sources-ஐ கண்டறிந்து exposure assess செய்து engineering மற்றும் administrative controls செயல்படுத்த வேண்டும். தேவையான இடங்களில் hearing protection வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management noise controls மற்றும் PPE வழங்க வேண்டும். Supervisors compliance-ஐ monitor செய்ய வேண்டும். Workers hearing protection-ஐ சரியாக பயன்படுத்தி excessive noise-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Noise Safety Checklist',
        'Tamil_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, warning signs, hearing protection மற்றும் worker training ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'High-noise area-ல் hearing protection இல்லாமல் வேலை செய்தல், PPE அகற்றுதல், noise assessment இல்லாமை மற்றும் equipment maintenance குறைபாடு.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'சாத்தியமான இடங்களில் noise-ஐ source-ல் control செய்யவும், equipment maintain செய்யவும், exposure time குறைக்கவும், hearing protection zones அமைக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE occupational safety requirements, ADOSH-SF requirements மற்றும் company noise control procedures.',
      },
            {
        'letter': 'N',
        'title': 'Noise & Hearing Conservation',
        'desc':
            'Workplace noise control and hearing protection practices.',

        'English_title': 'Noise & Hearing Conservation',
        'English_what': 'What is Noise Exposure?',
        'English_whatText':
            'Noise exposure occurs when workers are exposed to sound levels that may affect hearing or cause other health and safety risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent occupational hearing loss and reduce the risks associated with excessive workplace noise.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify noisy activities, assess noise exposure, apply engineering and administrative controls, maintain equipment and provide suitable hearing protection where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides noise controls and suitable PPE. Supervisors monitor compliance. Workers use hearing protection correctly and report excessive noise or damaged equipment.',
        'English_checklist': 'Noise Safety Checklist',
        'English_checklistText':
            'Noise sources identified, exposure assessed, equipment maintained, noisy areas controlled, warning signs provided, hearing protection available and workers trained.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working in high-noise areas without protection, removing hearing protection, inadequate noise assessment, poor equipment maintenance and failure to follow designated controls.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Control noise at source where practicable, maintain equipment, limit exposure time, establish hearing protection zones and provide suitable hearing conservation training.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements and company noise control procedures.',

        'Hindi_title': 'Noise & Hearing Conservation',
        'Hindi_what': 'Noise Exposure क्या है?',
        'Hindi_whatText':
            'जब workers ऐसे sound levels के संपर्क में आते हैं जो hearing को नुकसान पहुँचा सकते हैं, उसे Noise Exposure कहा जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Occupational hearing loss को रोकना और excessive workplace noise से होने वाले risks को कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Noise sources की पहचान करें, exposure assess करें, engineering और administrative controls लागू करें और आवश्यक होने पर suitable hearing protection प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management noise controls और PPE प्रदान करे। Supervisors compliance monitor करें। Workers hearing protection सही तरीके से उपयोग करें और excessive noise report करें।',
        'Hindi_checklist': 'Noise Safety Checklist',
        'Hindi_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, warning signs, hearing protection और worker training की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'High-noise area में hearing protection के बिना काम करना, PPE हटाना, inadequate noise assessment और equipment maintenance की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो noise को source पर control करें, equipment maintain करें, exposure time कम करें और hearing protection zones स्थापित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements और company noise control procedures।',

        'Malayalam_title': 'Noise & Hearing Conservation',
        'Malayalam_what': 'Noise Exposure എന്താണ്?',
        'Malayalam_whatText':
            'കേൾവിക്ക് ദോഷം ഉണ്ടാക്കാൻ സാധ്യതയുള്ള ഉയർന്ന ശബ്ദനിലവാരത്തിന് തൊഴിലാളികൾ exposure ആകുന്ന സാഹചര്യമാണ് Noise Exposure.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Occupational hearing loss തടയുകയും excessive workplace noise മൂലമുള്ള അപകടസാധ്യത കുറയ്ക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Noise sources തിരിച്ചറിയുക, noise exposure assess ചെയ്യുക, engineering/administrative controls നടപ്പാക്കുക, equipment maintain ചെയ്യുക, ആവശ്യമായിടത്ത് suitable hearing protection നൽകുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management noise controls, suitable PPE എന്നിവ നൽകണം. Supervisors compliance monitor ചെയ്യണം. Workers hearing protection ശരിയായി ഉപയോഗിക്കുകയും excessive noise report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Noise Safety Checklist',
        'Malayalam_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, noisy area controls, warning signs, hearing protection, worker training എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'High-noise area-യിൽ hearing protection ഇല്ലാതെ ജോലി ചെയ്യൽ, hearing protection നീക്കം ചെയ്യൽ, noise assessment ഇല്ലായ്മ, equipment maintenance കുറവ്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമെങ്കിൽ noise source-ൽ തന്നെ control ചെയ്യുക, equipment maintain ചെയ്യുക, exposure time കുറയ്ക്കുക, hearing protection zones സ്ഥാപിക്കുക, workers-ന് training നൽകുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE occupational safety requirements, ADOSH-SF requirements, company noise control procedures.',

        'Tamil_title': 'Noise & Hearing Conservation',
        'Tamil_what': 'Noise Exposure என்றால் என்ன?',
        'Tamil_whatText':
            'கேள்வித்திறனை பாதிக்கக்கூடிய அதிக சத்தத்திற்கு workers exposure ஆகும் நிலை Noise Exposure எனப்படுகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Occupational hearing loss-ஐ தடுப்பதும் அதிகமான workplace noise-ன் அபாயங்களை குறைப்பதும் நோக்கமாகும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Noise sources-ஐ கண்டறிந்து exposure assess செய்து engineering மற்றும் administrative controls செயல்படுத்த வேண்டும். தேவையான இடங்களில் hearing protection வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management noise controls மற்றும் PPE வழங்க வேண்டும். Supervisors compliance-ஐ monitor செய்ய வேண்டும். Workers hearing protection-ஐ சரியாக பயன்படுத்தி excessive noise-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Noise Safety Checklist',
        'Tamil_checklistText':
            'Noise sources, exposure assessment, equipment maintenance, warning signs, hearing protection மற்றும் worker training ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'High-noise area-ல் hearing protection இல்லாமல் வேலை செய்தல், PPE அகற்றுதல், noise assessment இல்லாமை மற்றும் equipment maintenance குறைபாடு.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'சாத்தியமான இடங்களில் noise-ஐ source-ல் control செய்யவும், equipment maintain செய்யவும், exposure time குறைக்கவும், hearing protection zones அமைக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE occupational safety requirements, ADOSH-SF requirements மற்றும் company noise control procedures.',
      },
            {
        'letter': 'O',
        'title': 'Occupational Health & Welfare',
        'desc':
            'Workplace health, welfare facilities and controls to protect worker wellbeing.',

        'English_title': 'Occupational Health & Welfare',
        'English_what': 'What is Occupational Health & Welfare?',
        'English_whatText':
            'Occupational health and welfare focus on protecting workers from work-related health risks and providing suitable workplace welfare facilities.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect worker health, support wellbeing and provide a safe, healthy and suitable working environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify occupational health hazards, provide suitable welfare facilities, maintain clean drinking water and sanitation, manage workplace conditions and provide appropriate health monitoring where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable welfare facilities and health controls. Supervisors monitor workplace conditions. Workers maintain hygiene, use facilities correctly and report health concerns or unsafe conditions.',
        'English_checklist': 'Occupational Health Checklist',
        'English_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature control, cleanliness, first aid and health monitoring where applicable.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Poor sanitation, insufficient drinking water, inadequate welfare facilities, poor housekeeping, unsuitable workplace conditions and failure to address occupational health hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain clean welfare facilities, monitor workplace conditions, encourage good hygiene, identify health risks early and provide suitable controls and support.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational health and welfare requirements, ADOSH-SF requirements and company HSE procedures.',

        'Hindi_title': 'Occupational Health & Welfare',
        'Hindi_what': 'Occupational Health & Welfare क्या है?',
        'Hindi_whatText':
            'Occupational Health और Welfare का उद्देश्य workers को work-related health risks से बचाना और उचित welfare facilities उपलब्ध कराना है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers के स्वास्थ्य और wellbeing की रक्षा करना तथा सुरक्षित और स्वस्थ working environment प्रदान करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Occupational health hazards की पहचान करें, drinking water, sanitation, toilets, washing facilities और suitable welfare facilities उपलब्ध कराएँ तथा आवश्यक health monitoring करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management welfare facilities और health controls प्रदान करे। Supervisors workplace conditions monitor करें। Workers hygiene बनाए रखें और unsafe conditions report करें।',
        'Hindi_checklist': 'Occupational Health Checklist',
        'Hindi_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature, cleanliness, first aid और health monitoring की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Poor sanitation, drinking water की कमी, inadequate welfare facilities, poor housekeeping और occupational health hazards को control न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Welfare facilities को साफ रखें, workplace conditions monitor करें, good hygiene को promote करें और health risks को समय पर control करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE occupational health and welfare requirements, ADOSH-SF requirements और company HSE procedures।',

        'Malayalam_title': 'Occupational Health & Welfare',
        'Malayalam_what': 'Occupational Health & Welfare എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിയുമായി ബന്ധപ്പെട്ട ആരോഗ്യ അപകടങ്ങളിൽ നിന്ന് തൊഴിലാളികളെ സംരക്ഷിക്കുകയും ആവശ്യമായ welfare facilities നൽകുകയും ചെയ്യുന്നതാണ് Occupational Health & Welfare.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'തൊഴിലാളികളുടെ ആരോഗ്യവും wellbeing-ഉം സംരക്ഷിക്കുകയും സുരക്ഷിതവും ആരോഗ്യകരവുമായ working environment ഉറപ്പാക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Occupational health hazards തിരിച്ചറിയുക, clean drinking water, toilets, washing facilities, rest areas എന്നിവ നൽകുക, workplace conditions നിയന്ത്രിക്കുക, ആവശ്യമായ health monitoring നടത്തുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management ആവശ്യമായ welfare facilities, health controls എന്നിവ നൽകണം. Supervisors workplace conditions monitor ചെയ്യണം. Workers hygiene പാലിക്കുകയും unsafe conditions report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Occupational Health Checklist',
        'Malayalam_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature control, cleanliness, first aid, health monitoring എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Poor sanitation, drinking water കുറവ്, welfare facilities അപര്യാപ്തം, poor housekeeping, unsuitable workplace conditions, occupational health hazards control ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Welfare facilities clean ആയി maintain ചെയ്യുക, workplace conditions monitor ചെയ്യുക, good hygiene പ്രോത്സാഹിപ്പിക്കുക, health risks നേരത്തെ തിരിച്ചറിഞ്ഞ് control ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE occupational health and welfare requirements, ADOSH-SF requirements, company HSE procedures.',

        'Tamil_title': 'Occupational Health & Welfare',
        'Tamil_what': 'Occupational Health & Welfare என்றால் என்ன?',
        'Tamil_whatText':
            'வேலையுடன் தொடர்புடைய உடல்நல அபாயங்களிலிருந்து workers-ஐ பாதுகாத்து, பொருத்தமான welfare facilities வழங்குவதே Occupational Health & Welfare ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Workers-ன் உடல்நலம் மற்றும் wellbeing-ஐ பாதுகாத்து, பாதுகாப்பான மற்றும் ஆரோக்கியமான working environment வழங்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Occupational health hazards-ஐ கண்டறிந்து, drinking water, toilets, washing facilities, rest areas மற்றும் தேவையான health monitoring வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management welfare facilities மற்றும் health controls வழங்க வேண்டும். Supervisors workplace conditions-ஐ monitor செய்ய வேண்டும். Workers hygiene-ஐ பின்பற்றி unsafe conditions-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Occupational Health Checklist',
        'Tamil_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature, cleanliness, first aid மற்றும் health monitoring ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Poor sanitation, drinking water பற்றாக்குறை, inadequate welfare facilities, poor housekeeping மற்றும் occupational health hazards-ஐ control செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Welfare facilities-ஐ சுத்தமாக பராமரிக்கவும், workplace conditions-ஐ monitor செய்யவும், good hygiene-ஐ ஊக்குவிக்கவும், health risks-ஐ ஆரம்பத்திலேயே control செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE occupational health and welfare requirements, ADOSH-SF requirements மற்றும் company HSE procedures.',
      },
            {
        'letter': 'O',
        'title': 'Occupational Health & Welfare',
        'desc':
            'Workplace health, welfare facilities and controls to protect worker wellbeing.',

        'English_title': 'Occupational Health & Welfare',
        'English_what': 'What is Occupational Health & Welfare?',
        'English_whatText':
            'Occupational health and welfare focus on protecting workers from work-related health risks and providing suitable workplace welfare facilities.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect worker health, support wellbeing and provide a safe, healthy and suitable working environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify occupational health hazards, provide suitable welfare facilities, maintain clean drinking water and sanitation, manage workplace conditions and provide appropriate health monitoring where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable welfare facilities and health controls. Supervisors monitor workplace conditions. Workers maintain hygiene, use facilities correctly and report health concerns or unsafe conditions.',
        'English_checklist': 'Occupational Health Checklist',
        'English_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature control, cleanliness, first aid and health monitoring where applicable.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Poor sanitation, insufficient drinking water, inadequate welfare facilities, poor housekeeping, unsuitable workplace conditions and failure to address occupational health hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain clean welfare facilities, monitor workplace conditions, encourage good hygiene, identify health risks early and provide suitable controls and support.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational health and welfare requirements, ADOSH-SF requirements and company HSE procedures.',

        'Hindi_title': 'Occupational Health & Welfare',
        'Hindi_what': 'Occupational Health & Welfare क्या है?',
        'Hindi_whatText':
            'Occupational Health और Welfare का उद्देश्य workers को work-related health risks से बचाना और उचित welfare facilities उपलब्ध कराना है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers के स्वास्थ्य और wellbeing की रक्षा करना तथा सुरक्षित और स्वस्थ working environment प्रदान करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Occupational health hazards की पहचान करें, drinking water, sanitation, toilets, washing facilities और suitable welfare facilities उपलब्ध कराएँ तथा आवश्यक health monitoring करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management welfare facilities और health controls प्रदान करे। Supervisors workplace conditions monitor करें। Workers hygiene बनाए रखें और unsafe conditions report करें।',
        'Hindi_checklist': 'Occupational Health Checklist',
        'Hindi_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature, cleanliness, first aid और health monitoring की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Poor sanitation, drinking water की कमी, inadequate welfare facilities, poor housekeeping और occupational health hazards को control न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Welfare facilities को साफ रखें, workplace conditions monitor करें, good hygiene को promote करें और health risks को समय पर control करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE occupational health and welfare requirements, ADOSH-SF requirements और company HSE procedures।',

        'Malayalam_title': 'Occupational Health & Welfare',
        'Malayalam_what': 'Occupational Health & Welfare എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിയുമായി ബന്ധപ്പെട്ട ആരോഗ്യ അപകടങ്ങളിൽ നിന്ന് തൊഴിലാളികളെ സംരക്ഷിക്കുകയും ആവശ്യമായ welfare facilities നൽകുകയും ചെയ്യുന്നതാണ് Occupational Health & Welfare.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'തൊഴിലാളികളുടെ ആരോഗ്യവും wellbeing-ഉം സംരക്ഷിക്കുകയും സുരക്ഷിതവും ആരോഗ്യകരവുമായ working environment ഉറപ്പാക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Occupational health hazards തിരിച്ചറിയുക, clean drinking water, toilets, washing facilities, rest areas എന്നിവ നൽകുക, workplace conditions നിയന്ത്രിക്കുക, ആവശ്യമായ health monitoring നടത്തുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management ആവശ്യമായ welfare facilities, health controls എന്നിവ നൽകണം. Supervisors workplace conditions monitor ചെയ്യണം. Workers hygiene പാലിക്കുകയും unsafe conditions report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Occupational Health Checklist',
        'Malayalam_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature control, cleanliness, first aid, health monitoring എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Poor sanitation, drinking water കുറവ്, welfare facilities അപര്യാപ്തം, poor housekeeping, unsuitable workplace conditions, occupational health hazards control ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Welfare facilities clean ആയി maintain ചെയ്യുക, workplace conditions monitor ചെയ്യുക, good hygiene പ്രോത്സാഹിപ്പിക്കുക, health risks നേരത്തെ തിരിച്ചറിഞ്ഞ് control ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE occupational health and welfare requirements, ADOSH-SF requirements, company HSE procedures.',

        'Tamil_title': 'Occupational Health & Welfare',
        'Tamil_what': 'Occupational Health & Welfare என்றால் என்ன?',
        'Tamil_whatText':
            'வேலையுடன் தொடர்புடைய உடல்நல அபாயங்களிலிருந்து workers-ஐ பாதுகாத்து, பொருத்தமான welfare facilities வழங்குவதே Occupational Health & Welfare ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Workers-ன் உடல்நலம் மற்றும் wellbeing-ஐ பாதுகாத்து, பாதுகாப்பான மற்றும் ஆரோக்கியமான working environment வழங்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Occupational health hazards-ஐ கண்டறிந்து, drinking water, toilets, washing facilities, rest areas மற்றும் தேவையான health monitoring வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management welfare facilities மற்றும் health controls வழங்க வேண்டும். Supervisors workplace conditions-ஐ monitor செய்ய வேண்டும். Workers hygiene-ஐ பின்பற்றி unsafe conditions-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Occupational Health Checklist',
        'Tamil_checklistText':
            'Drinking water, toilets, washing facilities, rest areas, ventilation, lighting, temperature, cleanliness, first aid மற்றும் health monitoring ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Poor sanitation, drinking water பற்றாக்குறை, inadequate welfare facilities, poor housekeeping மற்றும் occupational health hazards-ஐ control செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Welfare facilities-ஐ சுத்தமாக பராமரிக்கவும், workplace conditions-ஐ monitor செய்யவும், good hygiene-ஐ ஊக்குவிக்கவும், health risks-ஐ ஆரம்பத்திலேயே control செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE occupational health and welfare requirements, ADOSH-SF requirements மற்றும் company HSE procedures.',
      },
          {
        'letter': 'P',
        'title': 'Personal Protective Equipment (PPE)',
        'desc':
            'Selection, use, inspection and maintenance of personal protective equipment.',

        'English_title': 'Personal Protective Equipment (PPE)',
        'English_what': 'What is PPE?',
        'English_whatText':
            'Personal Protective Equipment is equipment or clothing designed to protect workers from specific workplace hazards when risks cannot be adequately controlled by other means.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce worker exposure to hazards and prevent or minimize workplace injuries and health effects.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, select suitable PPE, ensure correct fit, provide training, inspect PPE before use, maintain it properly and replace damaged or unsuitable equipment.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable PPE and training. Supervisors ensure correct use and compliance. Workers wear, inspect and maintain PPE correctly and report damaged PPE.',
        'English_checklist': 'PPE Checklist',
        'English_checklistText':
            'Hazard identified, correct PPE selected, proper fit, condition inspected, PPE available, workers trained, storage provided and replacement arrangements available.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to wear required PPE, incorrect PPE selection, damaged PPE, poor fit, failure to inspect PPE and improper storage.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use the hierarchy of controls first and treat PPE as the last line of defence. Select task-specific PPE, ensure proper fit and inspect it before every use.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements, manufacturer instructions and company PPE procedures.',

        'Hindi_title': 'Personal Protective Equipment (PPE)',
        'Hindi_what': 'PPE क्या है?',
        'Hindi_whatText':
            'PPE ऐसे उपकरण या कपड़े हैं जो workers को workplace hazards से बचाने के लिए उपयोग किए जाते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Hazard exposure को कम करना और workplace injuries तथा health effects को रोकना या कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazards की पहचान करें, suitable PPE चुनें, सही fit सुनिश्चित करें, training दें, PPE inspect करें और damaged PPE को replace करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable PPE और training प्रदान करे। Supervisors correct use monitor करें। Workers PPE सही तरीके से पहनें, inspect करें और damaged PPE report करें।',
        'Hindi_checklist': 'PPE Checklist',
        'Hindi_checklistText':
            'Hazard identified, correct PPE, proper fit, condition inspection, availability, worker training, storage और replacement arrangements की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Required PPE न पहनना, incorrect PPE, damaged PPE, poor fit, inspection न करना और improper storage।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'पहले hierarchy of controls लागू करें और PPE को last line of defence के रूप में उपयोग करें। Task-specific PPE चुनें और हर उपयोग से पहले inspect करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE occupational safety requirements, ADOSH-SF requirements, manufacturer instructions और company PPE procedures।',

        'Malayalam_title': 'Personal Protective Equipment (PPE)',
        'Malayalam_what': 'PPE എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്തെ പ്രത്യേക hazards-ൽ നിന്ന് തൊഴിലാളികളെ സംരക്ഷിക്കുന്നതിനായി ഉപയോഗിക്കുന്ന safety equipment അല്ലെങ്കിൽ protective clothing ആണ് Personal Protective Equipment (PPE).',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Hazard exposure കുറയ്ക്കുകയും workplace injuries, health effects എന്നിവ തടയുകയോ കുറയ്ക്കുകയോ ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazards തിരിച്ചറിയുക, suitable PPE തിരഞ്ഞെടുക്കുക, ശരിയായ fit ഉറപ്പാക്കുക, training നൽകുക, ഉപയോഗത്തിന് മുമ്പ് PPE inspect ചെയ്യുക, maintain ചെയ്യുക, damaged PPE replace ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable PPE, training എന്നിവ നൽകണം. Supervisors correct use monitor ചെയ്യണം. Workers PPE ശരിയായി ഉപയോഗിക്കുകയും inspect ചെയ്യുകയും damaged PPE report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'PPE Checklist',
        'Malayalam_checklistText':
            'Hazard identified, correct PPE selected, proper fit, condition inspection, PPE availability, worker training, storage, replacement arrangements എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Required PPE ഉപയോഗിക്കാത്തത്, തെറ്റായ PPE തിരഞ്ഞെടുക്കൽ, damaged PPE ഉപയോഗിക്കൽ, poor fit, PPE inspect ചെയ്യാത്തത്, improper storage.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'ആദ്യം hierarchy of controls പ്രയോഗിക്കുക. PPE last line of defence ആയി ഉപയോഗിക്കുക. Task-specific PPE തിരഞ്ഞെടുക്കുകയും ഓരോ ഉപയോഗത്തിനും മുമ്പ് inspect ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE occupational safety requirements, ADOSH-SF requirements, manufacturer instructions, company PPE procedures.',

        'Tamil_title': 'Personal Protective Equipment (PPE)',
        'Tamil_what': 'PPE என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட அபாயங்களிலிருந்து workers-ஐ பாதுகாக்க பயன்படுத்தப்படும் safety equipment அல்லது protective clothing PPE எனப்படுகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Hazard exposure-ஐ குறைத்து workplace injuries மற்றும் health effects-ஐ தடுக்க அல்லது குறைக்க வேண்டும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazards-ஐ கண்டறிந்து, பொருத்தமான PPE தேர்வு செய்து, சரியான fit உறுதி செய்து, training வழங்கி, பயன்படுத்துவதற்கு முன் PPE-ஐ inspect செய்து, damaged PPE-ஐ replace செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management suitable PPE மற்றும் training வழங்க வேண்டும். Supervisors correct use-ஐ monitor செய்ய வேண்டும். Workers PPE-ஐ சரியாக பயன்படுத்தி damaged PPE-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'PPE Checklist',
        'Tamil_checklistText':
            'Hazard identified, correct PPE, proper fit, condition inspection, availability, worker training, storage மற்றும் replacement arrangements ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Required PPE பயன்படுத்தாதது, incorrect PPE, damaged PPE, poor fit, PPE inspection செய்யாதது மற்றும் improper storage.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'முதலில் hierarchy of controls-ஐ பயன்படுத்தவும். PPE-ஐ last line of defence ஆக பயன்படுத்தி, task-specific PPE தேர்வு செய்து ஒவ்வொரு பயன்பாட்டிற்கும் முன் inspect செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE occupational safety requirements, ADOSH-SF requirements, manufacturer instructions மற்றும் company PPE procedures.',
      },
            // =========================
      // Q - Permit to Work (PTW)
      // =========================
      {
        'letter': 'Q',
        'title': 'Permit to Work (PTW)',
        'desc':
            'A formal system for controlling high-risk work activities.',

        'English_title': 'Permit to Work (PTW)',
        'English_what': 'What is Permit to Work?',
        'English_whatText':
            'A Permit to Work is a formal written or electronic authorization system used to control specific high-risk activities before work starts.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure hazards are identified, controls are established and responsible persons authorize the work before it begins.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify the work scope, hazards and controls, confirm isolations where required, inspect the work area, define validity and obtain authorization from competent persons before starting work.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides the PTW system. The issuing authority verifies controls. Supervisors ensure the permit conditions are followed. Workers understand and follow the permit requirements.',
        'English_checklist': 'PTW Checklist',
        'English_checklistText':
            'Work scope, risk assessment, required isolations, gas testing where applicable, PPE, emergency arrangements, work area inspection, authorization, permit validity and close-out.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Starting work without a valid permit, expired permit, incorrect work scope, missing isolation, inadequate controls and failure to close the permit.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a task-specific PTW system, verify controls at the worksite, communicate permit conditions to workers and formally suspend, extend or close permits as required.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company PTW procedure, applicable ADOSH-SF requirements, risk assessments and relevant UAE requirements.',

        'Hindi_title': 'Permit to Work (PTW)',
        'Hindi_what': 'Permit to Work क्या है?',
        'Hindi_whatText':
            'Permit to Work एक formal authorization system है जिसका उपयोग high-risk work activities को नियंत्रित करने के लिए किया जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'काम शुरू होने से पहले hazards की पहचान करना, controls सुनिश्चित करना और authorized approval प्राप्त करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Work scope, hazards और controls की पहचान करें, required isolations सुनिश्चित करें, work area inspect करें और competent person से authorization प्राप्त करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management PTW system उपलब्ध कराए। Issuing authority controls verify करे। Supervisors permit conditions लागू करें। Workers permit requirements का पालन करें।',
        'Hindi_checklist': 'PTW Checklist',
        'Hindi_checklistText':
            'Work scope, risk assessment, isolation, gas testing जहाँ आवश्यक हो, PPE, emergency arrangements, work area inspection, authorization, permit validity और close-out की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Valid permit के बिना काम शुरू करना, expired permit, incorrect work scope, missing isolation और permit close-out न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Task-specific PTW system उपयोग करें, site पर controls verify करें और workers को permit conditions स्पष्ट रूप से समझाएँ।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company PTW procedure, applicable ADOSH-SF requirements, risk assessments और relevant UAE requirements।',

        'Malayalam_title': 'Permit to Work (PTW)',
        'Malayalam_what': 'Permit to Work എന്താണ്?',
        'Malayalam_whatText':
            'High-risk work activities നിയന്ത്രിക്കുന്നതിനായി ജോലി ആരംഭിക്കുന്നതിന് മുമ്പ് നൽകുന്ന formal authorization system ആണ് Permit to Work.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജോലി ആരംഭിക്കുന്നതിന് മുമ്പ് hazards തിരിച്ചറിയുകയും controls ഉറപ്പാക്കുകയും authorized approval നേടുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Work scope, hazards, controls എന്നിവ തിരിച്ചറിയുക. ആവശ്യമായ isolation ഉറപ്പാക്കുക. Work area inspect ചെയ്യുക. Competent person-ൽ നിന്ന് authorization നേടുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management PTW system നൽകണം. Issuing authority controls verify ചെയ്യണം. Supervisors permit conditions പാലിക്കുന്നുവെന്ന് ഉറപ്പാക്കണം. Workers permit requirements പാലിക്കണം.',
        'Malayalam_checklist': 'PTW Checklist',
        'Malayalam_checklistText':
            'Work scope, Risk Assessment, isolation, gas testing ആവശ്യമെങ്കിൽ, PPE, emergency arrangements, work area inspection, authorization, permit validity, close-out എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Valid permit ഇല്ലാതെ ജോലി ആരംഭിക്കൽ, expired permit ഉപയോഗിക്കൽ, തെറ്റായ work scope, isolation ഇല്ലായ്മ, permit close ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Task-specific PTW system ഉപയോഗിക്കുക. Site-ൽ controls verify ചെയ്യുക. Permit conditions workers-ന് വ്യക്തമായി explain ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company PTW procedure, ബാധകമായ ADOSH-SF requirements, Risk Assessments, relevant UAE requirements.',

        'Tamil_title': 'Permit to Work (PTW)',
        'Tamil_what': 'Permit to Work என்றால் என்ன?',
        'Tamil_whatText':
            'High-risk work activities-ஐ கட்டுப்படுத்துவதற்காக வேலை தொடங்குவதற்கு முன் வழங்கப்படும் formal authorization system Permit to Work ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'வேலை தொடங்குவதற்கு முன் hazards-ஐ கண்டறிந்து controls உறுதி செய்து authorized approval பெறுதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Work scope, hazards மற்றும் controls-ஐ அடையாளம் காண வேண்டும். தேவையான isolation-ஐ உறுதி செய்து work area-ஐ inspect செய்து competent person-இடமிருந்து authorization பெற வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management PTW system வழங்க வேண்டும். Issuing authority controls-ஐ verify செய்ய வேண்டும். Supervisors permit conditions-ஐ உறுதி செய்ய வேண்டும். Workers permit requirements-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'PTW Checklist',
        'Tamil_checklistText':
            'Work scope, Risk Assessment, isolation, தேவையான இடங்களில் gas testing, PPE, emergency arrangements, work area inspection, authorization, permit validity மற்றும் close-out ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Valid permit இல்லாமல் வேலை தொடங்குதல், expired permit, incorrect work scope, isolation இல்லாமை மற்றும் permit close செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Task-specific PTW system பயன்படுத்தவும். Site-ல் controls-ஐ verify செய்து workers-க்கு permit conditions-ஐ தெளிவாக விளக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company PTW procedure, applicable ADOSH-SF requirements, Risk Assessments மற்றும் relevant UAE requirements.',
      },

      // =========================
      // R - Risk Assessment
      // =========================
      {
        'letter': 'R',
        'title': 'Risk Assessment',
        'desc':
            'Identification of hazards, evaluation of risks and implementation of controls.',

        'English_title': 'Risk Assessment',
        'English_what': 'What is Risk Assessment?',
        'English_whatText':
            'Risk assessment is the systematic process of identifying hazards, evaluating the likelihood and severity of harm and determining appropriate control measures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent incidents by identifying hazards before work starts and implementing effective risk controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, determine who may be affected, assess risk, apply the hierarchy of controls, communicate controls and review the assessment when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources. Competent persons conduct or support assessments. Supervisors implement controls. Workers understand and follow the identified controls.',
        'English_checklist': 'Risk Assessment Checklist',
        'English_checklistText':
            'Task steps, hazards, affected persons, existing controls, risk rating, additional controls, responsible persons, review date and worker communication.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Generic risk assessments, unidentified hazards, inadequate controls, outdated assessments and failure to communicate risks to workers.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use task-specific assessments, involve workers, apply the hierarchy of controls and review the assessment after incidents or significant changes.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company risk management procedure, applicable ADOSH-SF requirements and relevant UAE occupational safety requirements.',

        'Hindi_title': 'Risk Assessment',
        'Hindi_what': 'Risk Assessment क्या है?',
        'Hindi_whatText':
            'Risk Assessment hazards की पहचान, risk evaluation और उचित controls निर्धारित करने की systematic प्रक्रिया है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'काम शुरू होने से पहले hazards की पहचान करके incidents को रोकना और effective controls लागू करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazards की पहचान करें, affected persons निर्धारित करें, risk assess करें, hierarchy of controls लागू करें और conditions बदलने पर assessment review करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources प्रदान करे। Competent persons assessment करें। Supervisors controls लागू करें। Workers controls का पालन करें।',
        'Hindi_checklist': 'Risk Assessment Checklist',
        'Hindi_checklistText':
            'Task steps, hazards, affected persons, existing controls, risk rating, additional controls, responsible persons और review date की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Generic risk assessment, hazards की पहचान न करना, inadequate controls, outdated assessment और workers को risks न समझाना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Task-specific assessment करें, workers को शामिल करें और incidents या significant changes के बाद assessment review करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company risk management procedure, applicable ADOSH-SF requirements और relevant UAE occupational safety requirements।',

        'Malayalam_title': 'Risk Assessment',
        'Malayalam_what': 'Risk Assessment എന്താണ്?',
        'Malayalam_whatText':
            'Hazards തിരിച്ചറിയുകയും risk വിലയിരുത്തുകയും ആവശ്യമായ control measures നിശ്ചയിക്കുകയും ചെയ്യുന്ന systematic process ആണ് Risk Assessment.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് hazards തിരിച്ചറിഞ്ഞ് incidents തടയുകയും effective controls നടപ്പാക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazards തിരിച്ചറിയുക, ആരെ ബാധിക്കുമെന്ന് കണ്ടെത്തുക, risk assess ചെയ്യുക, hierarchy of controls പ്രയോഗിക്കുക, conditions മാറുമ്പോൾ assessment review ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Competent persons assessment നടത്തണം. Supervisors controls implement ചെയ്യണം. Workers controls പാലിക്കണം.',
        'Malayalam_checklist': 'Risk Assessment Checklist',
        'Malayalam_checklistText':
            'Task steps, hazards, affected persons, existing controls, risk rating, additional controls, responsible persons, review date എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Generic Risk Assessment, hazards തിരിച്ചറിയാത്തത്, inadequate controls, outdated assessment, workers-ന് risks explain ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Task-specific assessment ഉപയോഗിക്കുക. Workers-നെ ഉൾപ്പെടുത്തുക. Incident അല്ലെങ്കിൽ significant change ഉണ്ടായാൽ assessment review ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company Risk Management Procedure, ബാധകമായ ADOSH-SF requirements, relevant UAE occupational safety requirements.',

        'Tamil_title': 'Risk Assessment',
        'Tamil_what': 'Risk Assessment என்றால் என்ன?',
        'Tamil_whatText':
            'Hazards-ஐ கண்டறிந்து risk-ஐ மதிப்பீடு செய்து தேவையான control measures-ஐ நிர்ணயிக்கும் systematic process Risk Assessment ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'வேலை தொடங்குவதற்கு முன் hazards-ஐ கண்டறிந்து incidents-ஐ தடுத்து effective controls செயல்படுத்துதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazards, affected persons மற்றும் risks-ஐ கண்டறிந்து hierarchy of controls பயன்படுத்த வேண்டும். Conditions மாறும்போது assessment-ஐ review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources வழங்க வேண்டும். Competent persons assessment நடத்த வேண்டும். Supervisors controls செயல்படுத்த வேண்டும். Workers controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Risk Assessment Checklist',
        'Tamil_checklistText':
            'Task steps, hazards, affected persons, existing controls, risk rating, additional controls, responsible persons மற்றும் review date ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Generic Risk Assessment, hazards கண்டறியாமை, inadequate controls, outdated assessment மற்றும் workers-க்கு risks விளக்காதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Task-specific assessment பயன்படுத்தவும். Workers-ஐ ஈடுபடுத்தி incidents அல்லது significant changes ஏற்பட்ட பிறகு assessment-ஐ review செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company Risk Management Procedure, applicable ADOSH-SF requirements மற்றும் relevant UAE occupational safety requirements.',
      },

      // =========================
      // S - Scaffolding Safety
      // =========================
      {
        'letter': 'S',
        'title': 'Scaffolding Safety',
        'desc':
            'Safe erection, inspection, access and use of scaffolding systems.',

        'English_title': 'Scaffolding Safety',
        'English_what': 'What is Scaffolding Safety?',
        'English_whatText':
            'Scaffolding safety involves ensuring scaffolds are properly designed, erected, inspected, accessed and used to prevent falls and structural failures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide a safe temporary working platform and prevent falls, falling objects and scaffold collapse.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Scaffolds must be erected by competent persons, provided with suitable access, guardrails and toe boards, adequately supported and inspected before use and after conditions that may affect stability.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Competent persons erect and inspect scaffolds. Supervisors ensure safe use. Workers do not alter scaffolds and report defects immediately.',
        'English_checklist': 'Scaffolding Checklist',
        'English_checklistText':
            'Stable foundation, proper access, guardrails, midrails, toe boards, platform condition, safe working load, inspection status, ties/bracing and housekeeping.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Missing guardrails, unsafe access, damaged components, overloading, unauthorized alteration, gaps in platforms and use without inspection.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use competent scaffolders, inspect before use, maintain proper access and protection, display inspection status and prevent unauthorized modification.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE scaffolding requirements, ADOSH-SF requirements, approved scaffold design and company procedures.',

        'Hindi_title': 'Scaffolding Safety',
        'Hindi_what': 'Scaffolding Safety क्या है?',
        'Hindi_whatText':
            'Scaffolding safety का अर्थ scaffold को सही तरीके से erect, inspect, access और use करना है ताकि falls और collapse को रोका जा सके।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Safe temporary working platform प्रदान करना और falls, falling objects तथा scaffold collapse को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Scaffold competent persons द्वारा erect किया जाए और suitable access, guardrails, toe boards, proper support तथा inspection की व्यवस्था हो।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Competent persons scaffold erect और inspect करें। Supervisors safe use सुनिश्चित करें। Workers scaffold में unauthorized alteration न करें और defects report करें।',
        'Hindi_checklist': 'Scaffolding Checklist',
        'Hindi_checklistText':
            'Stable foundation, access, guardrails, midrails, toe boards, platform condition, safe working load, inspection status, ties/bracing और housekeeping की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Missing guardrails, unsafe access, damaged components, overloading, unauthorized alteration, platform gaps और inspection के बिना उपयोग।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Competent scaffolders का उपयोग करें, use से पहले inspect करें और unauthorized modification रोकें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE scaffolding requirements, ADOSH-SF requirements, approved scaffold design और company procedures।',

        'Malayalam_title': 'Scaffolding Safety',
        'Malayalam_what': 'Scaffolding Safety എന്താണ്?',
        'Malayalam_whatText':
            'Scaffold ശരിയായി design, erect, inspect, access, use ചെയ്യുന്നത് ഉറപ്പാക്കുന്ന safety system ആണ് Scaffolding Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Safe temporary working platform നൽകുകയും falls, falling objects, scaffold collapse എന്നിവ തടയുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Competent persons scaffold erect ചെയ്യണം. Proper access, guardrails, midrails, toe boards, adequate support എന്നിവ ഉണ്ടായിരിക്കണം. Use-ന് മുമ്പ് inspection നടത്തണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Competent persons scaffold erect/inspect ചെയ്യണം. Supervisors safe use ഉറപ്പാക്കണം. Workers scaffold unauthorized ആയി modify ചെയ്യരുത്; defects report ചെയ്യണം.',
        'Malayalam_checklist': 'Scaffolding Checklist',
        'Malayalam_checklistText':
            'Stable foundation, access, guardrails, midrails, toe boards, platform condition, safe working load, inspection status, ties/bracing, housekeeping എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Guardrails ഇല്ലായ്മ, unsafe access, damaged components, overloading, unauthorized alteration, platform gaps, inspection ഇല്ലാതെ ഉപയോഗിക്കൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Competent scaffolders ഉപയോഗിക്കുക. Use-ന് മുമ്പ് inspection നടത്തുക. Proper access/protection maintain ചെയ്യുക. Unauthorized modification തടയുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE scaffolding requirements, ADOSH-SF requirements, approved scaffold design, company procedures.',

        'Tamil_title': 'Scaffolding Safety',
        'Tamil_what': 'Scaffolding Safety என்றால் என்ன?',
        'Tamil_whatText':
            'Scaffold சரியாக design, erect, inspect, access மற்றும் use செய்யப்படுவதை உறுதி செய்யும் safety system Scaffolding Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'பாதுகாப்பான temporary working platform வழங்கி falls, falling objects மற்றும் scaffold collapse-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Competent persons scaffold-ஐ erect செய்ய வேண்டும். Proper access, guardrails, midrails, toe boards மற்றும் adequate support வழங்கப்பட வேண்டும். Use-க்கு முன் inspection செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Competent persons scaffold-ஐ erect மற்றும் inspect செய்ய வேண்டும். Supervisors safe use-ஐ உறுதி செய்ய வேண்டும். Workers unauthorized modification செய்யக்கூடாது மற்றும் defects report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Scaffolding Checklist',
        'Tamil_checklistText':
            'Stable foundation, access, guardrails, midrails, toe boards, platform condition, safe working load, inspection status, ties/bracing மற்றும் housekeeping ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Guardrails இல்லாமை, unsafe access, damaged components, overloading, unauthorized alteration, platform gaps மற்றும் inspection இல்லாமல் பயன்படுத்துதல்.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Competent scaffolders-ஐ பயன்படுத்தி, use-க்கு முன் inspection செய்து unauthorized modification-ஐ தடுக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE scaffolding requirements, ADOSH-SF requirements, approved scaffold design மற்றும் company procedures.',
      },

      // =========================
      // T - Traffic Management
      // =========================
      {
        'letter': 'T',
        'title': 'Traffic Management',
        'desc':
            'Control of vehicle and pedestrian movement within workplaces and construction sites.',

        'English_title': 'Traffic Management',
        'English_what': 'What is Traffic Management?',
        'English_whatText':
            'Traffic management is the planned control of vehicles, mobile equipment and pedestrians to reduce collision and struck-by risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To separate vehicles and pedestrians, control site traffic and prevent collisions, reversing incidents and pedestrian injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Establish traffic routes, pedestrian walkways, speed limits, signs, barriers and designated parking areas. Use trained drivers and suitable banksmen where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management establishes the traffic plan. Supervisors monitor implementation. Drivers follow site rules. Pedestrians use designated walkways.',
        'English_checklist': 'Traffic Management Checklist',
        'English_checklistText':
            'Traffic plan, speed limits, signs, barriers, pedestrian routes, vehicle inspection, reversing controls, lighting, trained drivers and banksman arrangements.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Speeding, unauthorized parking, poor segregation, uncontrolled reversing, missing signs and pedestrians entering vehicle routes.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use physical segregation wherever practicable, minimize reversing, maintain clear routes and continuously monitor traffic conditions.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE traffic and occupational safety requirements, site traffic management plan and company procedures.',

        'Hindi_title': 'Traffic Management',
        'Hindi_what': 'Traffic Management क्या है?',
        'Hindi_whatText':
            'Vehicles, mobile equipment और pedestrians की movement को planned तरीके से control करना Traffic Management है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Vehicles और pedestrians को अलग करना तथा collisions और struck-by incidents को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Traffic routes, pedestrian walkways, speed limits, signs, barriers और parking areas निर्धारित करें। Trained drivers और आवश्यकतानुसार banksman उपलब्ध करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management traffic plan बनाए। Supervisors implementation monitor करें। Drivers site rules follow करें। Pedestrians designated walkways का उपयोग करें।',
        'Hindi_checklist': 'Traffic Management Checklist',
        'Hindi_checklistText':
            'Traffic plan, speed limits, signs, barriers, pedestrian routes, vehicle inspection, reversing controls, lighting और trained drivers की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Speeding, unauthorized parking, poor segregation, uncontrolled reversing, missing signs और vehicle routes में pedestrians का प्रवेश।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो physical segregation करें, reversing कम करें और traffic routes को clear रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE traffic and occupational safety requirements, site traffic management plan और company procedures।',

        'Malayalam_title': 'Traffic Management',
        'Malayalam_what': 'Traffic Management എന്താണ്?',
        'Malayalam_whatText':
            'Vehicles, mobile equipment, pedestrians എന്നിവയുടെ movement നിയന്ത്രിച്ച് collision, struck-by risks കുറയ്ക്കുന്ന planned system ആണ് Traffic Management.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Vehicles-നും pedestrians-നും safe segregation നൽകുകയും collisions, reversing incidents, pedestrian injuries എന്നിവ തടയുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Traffic routes, pedestrian walkways, speed limits, signs, barriers, parking areas എന്നിവ സ്ഥാപിക്കുക. Trained drivers, ആവശ്യമായിടത്ത് banksman എന്നിവ ഉറപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management traffic plan തയ്യാറാക്കണം. Supervisors implementation monitor ചെയ്യണം. Drivers site rules പാലിക്കണം. Pedestrians designated walkways ഉപയോഗിക്കണം.',
        'Malayalam_checklist': 'Traffic Management Checklist',
        'Malayalam_checklistText':
            'Traffic plan, speed limits, signs, barriers, pedestrian routes, vehicle inspection, reversing controls, lighting, trained drivers, banksman arrangements എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Speeding, unauthorized parking, poor segregation, uncontrolled reversing, signs ഇല്ലായ്മ, vehicle routes-ൽ pedestrians പ്രവേശിക്കൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമാകുന്നിടത്ത് physical segregation ഉപയോഗിക്കുക. Reversing കുറയ്ക്കുക. Routes clear ആയി maintain ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE traffic and occupational safety requirements, site traffic management plan, company procedures.',

        'Tamil_title': 'Traffic Management',
        'Tamil_what': 'Traffic Management என்றால் என்ன?',
        'Tamil_whatText':
            'Vehicles, mobile equipment மற்றும் pedestrians movement-ஐ திட்டமிட்டு கட்டுப்படுத்தும் safety system Traffic Management ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Vehicles மற்றும் pedestrians-ஐ பிரித்து collisions, reversing incidents மற்றும் struck-by injuries-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Traffic routes, pedestrian walkways, speed limits, signs, barriers மற்றும் parking areas அமைக்க வேண்டும். Trained drivers மற்றும் தேவையான இடங்களில் banksman ஏற்பாடு செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management traffic plan உருவாக்க வேண்டும். Supervisors implementation-ஐ monitor செய்ய வேண்டும். Drivers site rules-ஐ பின்பற்ற வேண்டும். Pedestrians designated walkways பயன்படுத்த வேண்டும்.',
        'Tamil_checklist': 'Traffic Management Checklist',
        'Tamil_checklistText':
            'Traffic plan, speed limits, signs, barriers, pedestrian routes, vehicle inspection, reversing controls, lighting மற்றும் trained drivers ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Speeding, unauthorized parking, poor segregation, uncontrolled reversing, missing signs மற்றும் vehicle routes-ல் pedestrians நுழைதல்.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'சாத்தியமான இடங்களில் physical segregation பயன்படுத்தவும். Reversing-ஐ குறைத்து routes-ஐ clear ஆக வைத்திருக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE traffic மற்றும் occupational safety requirements, site traffic management plan மற்றும் company procedures.',
      },

      // =========================
      // U - Working at Height
      // =========================
      {
        'letter': 'U',
        'title': 'Working at Height',
        'desc':
            'Controls for preventing falls while working at height.',

        'English_title': 'Working at Height',
        'English_what': 'What is Working at Height?',
        'English_whatText':
            'Working at height includes work where a person could fall from one level to another and suffer injury.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent falls from height and reduce the consequences of a fall.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Avoid work at height where practicable. Use suitable platforms, guardrails and other collective protection. Where required, use suitable fall protection equipment, provide safe access and ensure workers are trained and competent.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable systems and equipment. Supervisors plan and monitor the work. Workers use access and fall protection systems correctly and report defects.',
        'English_checklist': 'Working at Height Checklist',
        'English_checklistText':
            'Risk assessment, safe access, platform condition, guardrails, edge protection, fall protection equipment, anchor points, rescue plan, weather conditions and worker competency.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unprotected edges, unsafe ladders, missing guardrails, improper harness use, unsuitable anchor points, overreaching and working during unsafe weather conditions.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan work to avoid height where possible, prioritize collective protection, inspect equipment before use and ensure a practical rescue plan is available.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE working-at-height requirements, ADOSH-SF requirements, approved risk assessments and company procedures.',

        'Hindi_title': 'Working at Height',
        'Hindi_what': 'Working at Height क्या है?',
        'Hindi_whatText':
            'ऐसा काम जिसमें व्यक्ति एक स्तर से दूसरे स्तर पर गिर सकता है और घायल हो सकता है, Working at Height कहलाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'ऊँचाई से गिरने की घटनाओं को रोकना और fall के परिणामों को कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'जहाँ संभव हो work at height से बचें। Suitable platforms, guardrails और collective protection का उपयोग करें। आवश्यक होने पर suitable fall protection equipment, safe access और trained workers उपलब्ध कराएँ।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable systems और equipment प्रदान करे। Supervisors work plan और monitor करें। Workers fall protection और access systems का सही उपयोग करें।',
        'Hindi_checklist': 'Working at Height Checklist',
        'Hindi_checklistText':
            'Risk assessment, safe access, platform, guardrails, edge protection, fall protection equipment, anchor points, rescue plan, weather conditions और worker competency की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Unprotected edges, unsafe ladders, missing guardrails, improper harness use, unsuitable anchor points, overreaching और unsafe weather में काम करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो height work avoid करें, collective protection को प्राथमिकता दें, equipment inspect करें और rescue plan सुनिश्चित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE working-at-height requirements, ADOSH-SF requirements, approved risk assessments और company procedures।',

        'Malayalam_title': 'Working at Height',
        'Malayalam_what': 'Working at Height എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു വ്യക്തിക്ക് ഒരു level-ൽ നിന്ന് മറ്റൊരു level-ലേക്ക് വീണ് പരിക്കേൽക്കാൻ സാധ്യതയുള്ള ജോലി Working at Height ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Height-ൽ നിന്ന് വീഴുന്നത് തടയുകയും fall സംഭവിച്ചാൽ അതിന്റെ ഗുരുതരമായ പ്രത്യാഘാതങ്ങൾ കുറയ്ക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'സാധ്യമെങ്കിൽ work at height ഒഴിവാക്കുക. Suitable platform, guardrails, collective protection എന്നിവ ഉപയോഗിക്കുക. ആവശ്യമായിടത്ത് fall protection equipment, safe access, trained competent workers എന്നിവ ഉറപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable systems/equipment നൽകണം. Supervisors ജോലി plan ചെയ്ത് monitor ചെയ്യണം. Workers fall protection, access systems ശരിയായി ഉപയോഗിക്കുകയും defects report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Working at Height Checklist',
        'Malayalam_checklistText':
            'Risk Assessment, safe access, platform condition, guardrails, edge protection, fall protection equipment, anchor points, rescue plan, weather conditions, worker competency എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Unprotected edges, unsafe ladder, guardrail ഇല്ലായ്മ, harness തെറ്റായി ഉപയോഗിക്കൽ, unsuitable anchor points, overreaching, unsafe weather-ൽ ജോലി ചെയ്യൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമെങ്കിൽ height work ഒഴിവാക്കുക. Collective protection-ന് priority നൽകുക. Equipment use-ന് മുമ്പ് inspect ചെയ്യുക. Practical rescue plan ഉറപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE working-at-height requirements, ADOSH-SF requirements, approved Risk Assessments, company procedures.',

        'Tamil_title': 'Working at Height',
        'Tamil_what': 'Working at Height என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு நபர் ஒரு level-லிருந்து மற்றொரு level-க்கு விழுந்து காயமடையக்கூடிய வேலை Working at Height ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Height-லிருந்து விழுவதைத் தடுப்பதும், fall ஏற்பட்டால் அதன் விளைவுகளை குறைப்பதும் ஆகும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'சாத்தியமான இடங்களில் work at height-ஐ தவிர்க்கவும். Suitable platforms, guardrails மற்றும் collective protection பயன்படுத்தவும். தேவையான இடங்களில் fall protection equipment, safe access மற்றும் trained workers ஏற்பாடு செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management suitable systems மற்றும் equipment வழங்க வேண்டும். Supervisors வேலைகளை plan மற்றும் monitor செய்ய வேண்டும். Workers fall protection மற்றும் access systems-ஐ சரியாக பயன்படுத்த வேண்டும்.',
        'Tamil_checklist': 'Working at Height Checklist',
        'Tamil_checklistText':
            'Risk Assessment, safe access, platform condition, guardrails, edge protection, fall protection equipment, anchor points, rescue plan, weather conditions மற்றும் worker competency ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Unprotected edges, unsafe ladders, guardrails இல்லாமை, improper harness use, unsuitable anchor points, overreaching மற்றும் unsafe weather conditions-ல் வேலை செய்தல்.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'சாத்தியமான இடங்களில் height work-ஐ தவிர்த்து collective protection-க்கு முன்னுரிமை அளிக்கவும். Equipment-ஐ inspect செய்து practical rescue plan வைத்திருக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE working-at-height requirements, ADOSH-SF requirements, approved Risk Assessments மற்றும் company procedures.',
      },
            {
        'letter': 'V',
        'title': 'Vehicle & Traffic Safety',
        'desc':
            'Safe vehicle operation, traffic management and pedestrian protection at the workplace.',

        'English_title': 'Vehicle & Traffic Safety',
        'English_what': 'What is Vehicle & Traffic Safety?',
        'English_whatText':
            'Vehicle and traffic safety involves controlling risks associated with workplace vehicles, mobile equipment, traffic movement and pedestrian interaction.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent vehicle collisions, struck-by incidents, reversing accidents and pedestrian injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use competent drivers, maintain vehicles, establish traffic routes, control reversing, provide suitable signage and separate pedestrians from vehicles where practicable.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides safe traffic arrangements. Supervisors monitor vehicle operations. Drivers follow site traffic rules and report defects.',
        'English_checklist': 'Vehicle Safety Checklist',
        'English_checklistText':
            'Driver competency, vehicle inspection, seat belts, reversing controls, warning devices, traffic routes, speed limits, parking and pedestrian segregation.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Speeding, unauthorized driving, defective vehicles, unsafe reversing, failure to wear seat belts and poor pedestrian segregation.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a traffic management plan, maintain vehicles properly, minimize reversing and continuously monitor vehicle-pedestrian interaction.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company traffic management procedures, applicable UAE requirements and site-specific risk assessments.',

        'Hindi_title': 'Vehicle & Traffic Safety',
        'Hindi_what': 'Vehicle & Traffic Safety क्या है?',
        'Hindi_whatText':
            'कार्यस्थल पर वाहनों, मोबाइल उपकरणों और पैदल यात्रियों से जुड़े जोखिमों को नियंत्रित करना Vehicle & Traffic Safety है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'वाहन दुर्घटनाओं, टक्कर और pedestrian injuries को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Competent drivers, vehicle inspection, traffic routes, speed limits, reversing controls और pedestrian segregation सुनिश्चित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management safe traffic व्यवस्था करे। Supervisors monitoring करें। Drivers traffic rules और vehicle safety requirements का पालन करें।',
        'Hindi_checklist': 'Vehicle Safety Checklist',
        'Hindi_checklistText':
            'Driver competency, vehicle inspection, seat belt, warning devices, traffic routes, speed limits और pedestrian segregation की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Speeding, unsafe reversing, defective vehicles, seat belt न पहनना और pedestrian segregation की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Traffic Management Plan लागू करें, vehicles maintain करें और reversing को minimum रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company traffic procedures, applicable UAE requirements और site risk assessments।',

        'Malayalam_title': 'Vehicle & Traffic Safety',
        'Malayalam_what': 'Vehicle & Traffic Safety എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്ത് vehicles, mobile equipment, traffic movement, pedestrians എന്നിവയുമായി ബന്ധപ്പെട്ട അപകടസാധ്യതകൾ നിയന്ത്രിക്കുന്നതാണ് Vehicle & Traffic Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Vehicle collision, struck-by incidents, reversing accidents, pedestrian injuries എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Competent drivers, vehicle inspection, traffic routes, speed limits, reversing controls, warning signs, pedestrian segregation എന്നിവ ഉറപ്പാക്കണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management safe traffic arrangements നൽകണം. Supervisors vehicle operations monitor ചെയ്യണം. Drivers site traffic rules പാലിക്കുകയും defects report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Vehicle Safety Checklist',
        'Malayalam_checklistText':
            'Driver competency, vehicle inspection, seat belt, warning devices, traffic routes, speed limits, parking, pedestrian segregation എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Speeding, unauthorized driving, defective vehicle, unsafe reversing, seat belt ഉപയോഗിക്കാത്തത്, pedestrian segregation ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Traffic Management Plan ഉപയോഗിക്കുക, vehicles ശരിയായി maintain ചെയ്യുക, reversing കുറയ്ക്കുക, vehicle-pedestrian interaction monitor ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company Traffic Management Procedures, ബാധകമായ UAE requirements, site-specific Risk Assessments.',

        'Tamil_title': 'Vehicle & Traffic Safety',
        'Tamil_what': 'Vehicle & Traffic Safety என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட வாகனங்கள், mobile equipment மற்றும் pedestrians தொடர்பான அபாயங்களை கட்டுப்படுத்துவது Vehicle & Traffic Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'வாகன மோதல்கள், reversing accidents மற்றும் pedestrian injuries-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Competent drivers, vehicle inspection, traffic routes, speed limits, reversing controls மற்றும் pedestrian segregation ஆகியவற்றை உறுதி செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management பாதுகாப்பான traffic arrangements வழங்க வேண்டும். Supervisors monitoring செய்ய வேண்டும். Drivers traffic rules-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Vehicle Safety Checklist',
        'Tamil_checklistText':
            'Driver competency, vehicle inspection, seat belt, warning devices, traffic routes, speed limits மற்றும் pedestrian segregation ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Speeding, unsafe reversing, defective vehicles, seat belt பயன்படுத்தாமை மற்றும் pedestrian segregation இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Traffic Management Plan பயன்படுத்தி, vehicles-ஐ முறையாக maintain செய்து, reversing-ஐ குறைக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company traffic procedures, applicable UAE requirements மற்றும் site risk assessments.',
      },

      {
        'letter': 'W',
        'title': 'Work at Height Safety',
        'desc':
            'Safe planning and control of activities where workers may fall from height.',

        'English_title': 'Work at Height Safety',
        'English_what': 'What is Work at Height?',
        'English_whatText':
            'Work at height is work where a person could fall from one level to another and suffer injury.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent falls from height and protect workers from falling objects.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Plan the work, assess risks, use suitable access equipment, provide edge protection and use fall protection systems where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable equipment and resources. Supervisors ensure controls are implemented. Workers use equipment correctly and follow procedures.',
        'English_checklist': 'Work at Height Checklist',
        'English_checklistText':
            'Risk assessment, safe access, scaffold condition, guardrails, platforms, ladders, fall protection, dropped-object controls and rescue arrangements.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without edge protection, unsafe ladders, incomplete scaffolds, missing fall protection and dropped-object hazards.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Avoid work at height where possible, use collective protection first and ensure suitable rescue arrangements are available.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements, company procedures and approved risk assessments.',

        'Hindi_title': 'Work at Height Safety',
        'Hindi_what': 'Work at Height क्या है?',
        'Hindi_whatText':
            'ऐसा कार्य जिसमें व्यक्ति एक स्तर से दूसरे स्तर पर गिर सकता है और घायल हो सकता है, Work at Height कहलाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'ऊँचाई से गिरने और falling objects से होने वाली चोटों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Work planning, risk assessment, safe access, edge protection और suitable fall protection प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management equipment प्रदान करे। Supervisors controls लागू करें। Workers procedures का पालन करें।',
        'Hindi_checklist': 'Work at Height Checklist',
        'Hindi_checklistText':
            'Risk assessment, scaffold, guardrails, ladders, platforms, fall protection और rescue arrangements की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Edge protection के बिना काम करना, unsafe ladders, incomplete scaffold और fall protection की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो height work avoid करें और collective protection को प्राथमिकता दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements, company procedures और risk assessments।',

        'Malayalam_title': 'Work at Height Safety',
        'Malayalam_what': 'Work at Height എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു വ്യക്തി ഒരു level-ൽ നിന്ന് മറ്റൊരു level-ലേക്ക് വീഴാൻ സാധ്യതയുള്ള ജോലി Work at Height ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഉയരത്തിൽ നിന്ന് വീഴുന്നതും falling objects മൂലമുള്ള അപകടങ്ങളും തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Work planning, Risk Assessment, safe access, edge protection, scaffold, ladder, fall protection എന്നിവ ഉറപ്പാക്കണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable equipment നൽകണം. Supervisors controls implement ചെയ്യണം. Workers procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Work at Height Checklist',
        'Malayalam_checklistText':
            'Risk Assessment, scaffold condition, guardrails, platforms, ladders, fall protection, dropped-object controls, rescue arrangements എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Edge protection ഇല്ലാതെ ജോലി ചെയ്യൽ, unsafe ladder, incomplete scaffold, fall protection ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമെങ്കിൽ Work at Height ഒഴിവാക്കുക. ആദ്യം collective protection ഉപയോഗിക്കുക, ആവശ്യമായ rescue plan ഒരുക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE requirements, ADOSH-SF requirements, company procedures, approved Risk Assessments.',

        'Tamil_title': 'Work at Height Safety',
        'Tamil_what': 'Work at Height என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு நபர் ஒரு level-இலிருந்து மற்றொரு level-க்கு விழக்கூடிய பணிகள் Work at Height எனப்படும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'உயரத்திலிருந்து விழுதல் மற்றும் falling objects மூலம் ஏற்படும் காயங்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Work planning, Risk Assessment, safe access, edge protection மற்றும் fall protection வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management பொருத்தமான equipment வழங்க வேண்டும். Supervisors controls செயல்படுத்த வேண்டும். Workers procedures-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Work at Height Checklist',
        'Tamil_checklistText':
            'Risk Assessment, scaffold, guardrails, ladders, platforms, fall protection மற்றும் rescue arrangements ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Edge protection இல்லாமல் வேலை செய்தல், unsafe ladders, incomplete scaffold மற்றும் fall protection இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'முடிந்தவரை Work at Height-ஐ தவிர்த்து, collective protection-ஐ முதலில் பயன்படுத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements, company procedures மற்றும் approved Risk Assessments.',
      },

      {
        'letter': 'X',
        'title': 'Excavation & Trenching Safety',
        'desc':
            'Safe excavation, trenching and protection against collapse and underground services.',

        'English_title': 'Excavation & Trenching Safety',
        'English_what': 'What is Excavation Safety?',
        'English_whatText':
            'Excavation safety is the management of hazards associated with digging, trenches, underground services, collapse and access.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent trench collapse, falls, underground service strikes and other excavation-related incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify underground services, assess ground conditions, provide suitable shoring or sloping, control access and provide safe entry and exit.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Competent persons inspect excavations. Supervisors maintain controls. Workers follow excavation procedures and report unsafe conditions.',
        'English_checklist': 'Excavation Checklist',
        'English_checklistText':
            'Permit, service drawings, ground assessment, shoring or sloping, access, edge protection, spoil placement, water control and inspection records.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unprotected trenches, unsafe access, spoil too close to edges, unidentified services and lack of inspection.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan excavation work carefully, verify underground services and inspect excavations before each shift and after changing conditions.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE requirements, authority requirements, company excavation procedures and risk assessments.',

        'Hindi_title': 'Excavation & Trenching Safety',
        'Hindi_what': 'Excavation Safety क्या है?',
        'Hindi_whatText':
            'Excavation और trenching से जुड़े collapse, underground services और access hazards को नियंत्रित करना Excavation Safety है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Trench collapse, falls और underground service strikes को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Underground services की पहचान, ground assessment, shoring/sloping और safe access प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Competent person excavation inspect करे। Supervisors controls maintain करें। Workers procedures का पालन करें।',
        'Hindi_checklist': 'Excavation Checklist',
        'Hindi_checklistText':
            'Permit, service drawings, ground condition, shoring, access, edge protection, spoil placement और inspection records की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Unprotected trench, unsafe access, edge के पास spoil और underground services की पहचान न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Excavation से पहले planning करें और हर shift से पहले inspection करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE requirements, authority requirements, company excavation procedures और risk assessments।',

        'Malayalam_title': 'Excavation & Trenching Safety',
        'Malayalam_what': 'Excavation Safety എന്താണ്?',
        'Malayalam_whatText':
            'Excavation, trench collapse, underground services, falls, access തുടങ്ങിയ അപകടങ്ങൾ നിയന്ത്രിക്കുന്നതാണ് Excavation Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Trench collapse, falls, underground service damage എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Underground services തിരിച്ചറിയുക, ground conditions പരിശോധിക്കുക, shoring/sloping നൽകുക, safe access ഒരുക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Competent person excavation inspect ചെയ്യണം. Supervisors controls maintain ചെയ്യണം. Workers excavation procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Excavation Checklist',
        'Malayalam_checklistText':
            'Permit, service drawings, ground assessment, shoring/sloping, access, edge protection, spoil placement, water control, inspection records എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Unprotected trench, unsafe access, edge-ന്റെ അടുത്ത് spoil വയ്ക്കൽ, underground services identify ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Excavation മുൻകൂട്ടി plan ചെയ്യുക, underground services verify ചെയ്യുക, ഓരോ shift-നും മുമ്പ് inspection നടത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE requirements, authority requirements, company excavation procedures, Risk Assessments.',

        'Tamil_title': 'Excavation & Trenching Safety',
        'Tamil_what': 'Excavation Safety என்றால் என்ன?',
        'Tamil_whatText':
            'Excavation மற்றும் trenching தொடர்பான collapse, underground services மற்றும் access hazards-ஐ கட்டுப்படுத்துவது Excavation Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Trench collapse, falls மற்றும் underground service damage-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Underground services-ஐ அடையாளம் காணுதல், ground assessment, shoring/sloping மற்றும் safe access வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Competent person excavation-ஐ inspect செய்ய வேண்டும். Supervisors controls-ஐ maintain செய்ய வேண்டும்.',
        'Tamil_checklist': 'Excavation Checklist',
        'Tamil_checklistText':
            'Permit, service drawings, ground assessment, shoring, access, edge protection, spoil placement மற்றும் inspection records ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Unprotected trench, unsafe access, edge அருகில் spoil வைப்பது மற்றும் underground services identify செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Excavation-ஐ முன்கூட்டியே plan செய்து, underground services-ஐ verify செய்து, ஒவ்வொரு shift-க்கும் inspection செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Applicable UAE requirements, authority requirements, company excavation procedures மற்றும் Risk Assessments.',
      },

      {
        'letter': 'Y',
        'title': 'Electrical Safety',
        'desc':
            'Safe use, inspection and control of electrical systems, equipment and temporary power.',

        'English_title': 'Electrical Safety',
        'English_what': 'What is Electrical Safety?',
        'English_whatText':
            'Electrical safety is the prevention of electric shock, burns, arc flash, fire and other hazards associated with electrical systems and equipment.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect workers from electrical shock, burns, fire and electrical-related incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Use competent electrical personnel, inspect equipment, provide proper earthing and protection, control temporary electrical systems and isolate energy before maintenance.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Qualified personnel perform electrical work. Supervisors ensure controls are followed. Workers report damaged cables, equipment and electrical hazards.',
        'English_checklist': 'Electrical Safety Checklist',
        'English_checklistText':
            'Cables, plugs, sockets, earthing, RCD/GFCI protection, distribution boards, temporary power, isolation, inspection and warning signs.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Damaged cables, overloaded sockets, poor connections, missing earthing, unauthorized electrical work and unsafe temporary wiring.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use competent persons, inspect electrical equipment regularly, isolate before maintenance and keep electrical systems protected from damage and moisture.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE electrical requirements, company procedures and approved electrical risk assessments.',

        'Hindi_title': 'Electrical Safety',
        'Hindi_what': 'Electrical Safety क्या है?',
        'Hindi_whatText':
            'Electrical shock, burns, arc flash और electrical fire जैसे जोखिमों को रोकना Electrical Safety है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers को electrical shock, burns और fire से बचाना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Competent electrical personnel, inspection, earthing, protective devices और maintenance से पहले isolation सुनिश्चित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Qualified personnel electrical work करें। Supervisors controls की निगरानी करें। Workers electrical hazards report करें।',
        'Hindi_checklist': 'Electrical Safety Checklist',
        'Hindi_checklistText':
            'Cables, plugs, sockets, earthing, RCD/GFCI, distribution boards, temporary power और isolation की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Damaged cables, overloaded sockets, poor connections, missing earthing और unauthorized electrical work।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Competent persons का उपयोग करें, equipment inspect करें और maintenance से पहले isolation करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE electrical requirements, company procedures और electrical risk assessments।',

        'Malayalam_title': 'Electrical Safety',
        'Malayalam_what': 'Electrical Safety എന്താണ്?',
        'Malayalam_whatText':
            'Electrical shock, burns, arc flash, fire തുടങ്ങിയ electrical അപകടങ്ങൾ തടയുന്നതിനുള്ള സുരക്ഷാ നടപടികളാണ് Electrical Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Electrical shock, burns, fire എന്നിവയിൽ നിന്ന് തൊഴിലാളികളെ സംരക്ഷിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Competent electrical personnel, equipment inspection, proper earthing, protective devices, temporary power controls, maintenance-ന് മുമ്പ് isolation എന്നിവ ഉറപ്പാക്കണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Qualified personnel electrical work ചെയ്യണം. Supervisors controls monitor ചെയ്യണം. Workers damaged cables/equipment report ചെയ്യണം.',
        'Malayalam_checklist': 'Electrical Safety Checklist',
        'Malayalam_checklistText':
            'Cables, plugs, sockets, earthing, RCD/GFCI, distribution boards, temporary power, isolation, warning signs എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Damaged cables, overloaded sockets, poor connections, earthing ഇല്ലായ്മ, unauthorized electrical work, unsafe temporary wiring.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Competent persons ഉപയോഗിക്കുക, electrical equipment regular ആയി inspect ചെയ്യുക, maintenance-ന് മുമ്പ് isolation നടത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE electrical requirements, company procedures, approved electrical Risk Assessments.',

        'Tamil_title': 'Electrical Safety',
        'Tamil_what': 'Electrical Safety என்றால் என்ன?',
        'Tamil_whatText':
            'Electrical shock, burns, arc flash மற்றும் electrical fire போன்ற அபாயங்களைத் தடுப்பது Electrical Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Workers-ஐ electrical shock, burns மற்றும் fire ஆகியவற்றிலிருந்து பாதுகாப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Competent electrical personnel, inspection, earthing, protective devices மற்றும் maintenance முன் isolation ஆகியவற்றை உறுதி செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Qualified personnel electrical work செய்ய வேண்டும். Supervisors controls-ஐ கண்காணிக்க வேண்டும்.',
        'Tamil_checklist': 'Electrical Safety Checklist',
        'Tamil_checklistText':
            'Cables, plugs, sockets, earthing, RCD/GFCI, distribution boards, temporary power மற்றும் isolation ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Damaged cables, overloaded sockets, poor connections, earthing இல்லாமை மற்றும் unauthorized electrical work.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Competent persons பயன்படுத்தி, electrical equipment-ஐ தொடர்ந்து inspect செய்து, maintenance முன் isolation செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Applicable UAE electrical requirements, company procedures மற்றும் electrical Risk Assessments.',
      },

      {
        'letter': 'Z',
        'title': 'Zero Harm & Safety Culture',
        'desc':
            'A proactive safety culture focused on preventing incidents and continuously improving workplace safety.',

        'English_title': 'Zero Harm & Safety Culture',
        'English_what': 'What is Zero Harm?',
        'English_whatText':
            'Zero Harm is a safety goal that focuses on preventing injuries, occupational illness, environmental harm and avoidable incidents through proactive risk management.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To create a workplace where everyone takes responsibility for safety and actively prevents harm.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, assess risks, implement controls, encourage reporting, investigate incidents, learn from findings and continuously improve safety performance.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management demonstrates leadership. Supervisors lead by example. Workers participate in safety activities, follow procedures and report hazards and near misses.',
        'English_checklist': 'Safety Culture Checklist',
        'English_checklistText':
            'Leadership, worker participation, hazard reporting, near-miss reporting, inspections, training, incident learning, corrective actions and continuous improvement.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Ignoring hazards, under-reporting incidents, poor safety communication, repeated unsafe acts and failure to close corrective actions.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Promote open reporting, recognize safe behaviour, learn from near misses, involve workers in risk controls and continuously improve the HSE system.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE management system, applicable ADOSH-SF requirements, risk assessments and continuous improvement procedures.',

        'Hindi_title': 'Zero Harm & Safety Culture',
        'Hindi_what': 'Zero Harm क्या है?',
        'Hindi_whatText':
            'Zero Harm एक safety goal है जिसका उद्देश्य injuries, occupational illness और avoidable incidents को रोकना है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'ऐसी workplace culture बनाना जहाँ हर व्यक्ति safety की जिम्मेदारी ले।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazards पहचानें, risk assessment करें, controls लागू करें, reporting को प्रोत्साहित करें और corrective actions close करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management leadership दे। Supervisors example set करें। Workers procedures का पालन और hazards report करें।',
        'Hindi_checklist': 'Safety Culture Checklist',
        'Hindi_checklistText':
            'Leadership, worker participation, hazard reporting, near-miss reporting, inspections, training और corrective actions की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Hazards को ignore करना, incidents report न करना, poor communication और corrective actions close न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Open reporting को बढ़ावा दें, near misses से सीखें और workers को safety improvement में शामिल करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE management system, applicable ADOSH-SF requirements और risk assessments।',

        'Malayalam_title': 'Zero Harm & Safety Culture',
        'Malayalam_what': 'Zero Harm എന്താണ്?',
        'Malayalam_whatText':
            'Injuries, occupational illness, environmental harm, avoidable incidents എന്നിവ തടയുന്നതിൽ ശ്രദ്ധ കേന്ദ്രീകരിക്കുന്ന proactive safety goal ആണ് Zero Harm.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഓരോ വ്യക്തിയും safety-യുടെ ഉത്തരവാദിത്തം ഏറ്റെടുക്കുന്ന ശക്തമായ safety culture സൃഷ്ടിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazards തിരിച്ചറിയുക, Risk Assessment നടത്തുക, controls നടപ്പാക്കുക, hazard/near-miss reporting പ്രോത്സാഹിപ്പിക്കുക, incidents investigate ചെയ്യുക, corrective actions close ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management safety leadership നൽകണം. Supervisors example ആയി പ്രവർത്തിക്കണം. Workers procedures പാലിക്കുകയും hazards/near misses report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Safety Culture Checklist',
        'Malayalam_checklistText':
            'Leadership, worker participation, hazard reporting, near-miss reporting, inspections, training, incident learning, corrective actions, continuous improvement എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Hazards അവഗണിക്കൽ, incidents report ചെയ്യാത്തത്, poor safety communication, repeated unsafe acts, corrective actions close ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Open reporting പ്രോത്സാഹിപ്പിക്കുക, safe behaviour recognize ചെയ്യുക, near misses-ൽ നിന്ന് പഠിക്കുക, workers-നെ safety improvement-ൽ ഉൾപ്പെടുത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE Management System, ബാധകമായ ADOSH-SF requirements, Risk Assessments, Continuous Improvement Procedures.',

        'Tamil_title': 'Zero Harm & Safety Culture',
        'Tamil_what': 'Zero Harm என்றால் என்ன?',
        'Tamil_whatText':
            'காயங்கள், தொழில் சார்ந்த நோய்கள் மற்றும் தவிர்க்கக்கூடிய சம்பவங்களைத் தடுப்பதை நோக்கமாகக் கொண்ட proactive safety approach ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'ஒவ்வொருவரும் safety-க்கு பொறுப்பு ஏற்கும் வலுவான safety culture உருவாக்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazards identify செய்து, Risk Assessment செய்து, controls செயல்படுத்தி, reporting-ஐ ஊக்குவித்து, corrective actions-ஐ close செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management safety leadership வழங்க வேண்டும். Supervisors example ஆக செயல்பட வேண்டும். Workers procedures-ஐ பின்பற்றி hazards மற்றும் near misses-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Safety Culture Checklist',
        'Tamil_checklistText':
            'Leadership, worker participation, hazard reporting, near-miss reporting, inspections, training மற்றும் corrective actions ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Hazards-ஐ புறக்கணித்தல், incidents report செய்யாமை, poor communication மற்றும் corrective actions close செய்யாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Open reporting-ஐ ஊக்குவித்து, near misses-லிருந்து கற்றுக்கொண்டு, workers-ஐ safety improvement-ல் ஈடுபடுத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE Management System, applicable ADOSH-SF requirements மற்றும் Risk Assessments.',
      },
            {
        'letter': 'V',
        'title': 'Vehicle & Traffic Safety',
        'desc':
            'Workplace vehicle movement, pedestrian safety and traffic management controls.',

        'English_title': 'Vehicle & Traffic Safety',
        'English_what': 'What is Vehicle & Traffic Safety?',
        'English_whatText':
            'Vehicle and traffic safety involves controlling vehicle movement, pedestrian interaction and traffic-related hazards at the workplace.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent vehicle collisions, struck-by incidents and injuries involving pedestrians and mobile equipment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Establish traffic routes, speed limits, pedestrian walkways, reversing controls, vehicle inspections and competent driver requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides traffic controls. Supervisors monitor compliance. Drivers and pedestrians follow designated routes and site traffic rules.',
        'English_checklist': 'Traffic Safety Checklist',
        'English_checklistText':
            'Vehicle inspection, seat belts, speed control, pedestrian segregation, reversing alarms, warning signs, lighting and driver competency.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Speeding, unsafe reversing, unauthorized drivers, blocked pedestrian routes, failure to wear seat belts and poor vehicle condition.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Separate pedestrians and vehicles wherever practicable, use banksmen for reversing where required and maintain effective traffic management.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE traffic requirements, company traffic management plan and relevant HSE procedures.',

        'Hindi_title': 'Vehicle & Traffic Safety',
        'Hindi_what': 'Vehicle & Traffic Safety क्या है?',
        'Hindi_whatText':
            'कार्यस्थल पर वाहनों, पैदल यात्रियों और यातायात से जुड़े खतरों को नियंत्रित करने की प्रक्रिया।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Vehicle collision और pedestrian accidents को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Traffic routes, speed limits, pedestrian walkways, vehicle inspection और competent drivers सुनिश्चित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management traffic controls प्रदान करे। Supervisors compliance देखें। Drivers और pedestrians site traffic rules का पालन करें।',
        'Hindi_checklist': 'Traffic Safety Checklist',
        'Hindi_checklistText':
            'Vehicle inspection, seat belt, speed control, pedestrian segregation, reversing alarm और warning signs की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Speeding, unsafe reversing, unauthorized driving और pedestrian routes block करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Vehicles और pedestrians को अलग रखें और reversing के दौरान आवश्यकतानुसार banksman का उपयोग करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE traffic requirements, company traffic management plan और HSE procedures।',

        'Malayalam_title': 'Vehicle & Traffic Safety',
        'Malayalam_what': 'Vehicle & Traffic Safety എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്തെ വാഹനങ്ങൾ, pedestrians, mobile equipment എന്നിവയുമായി ബന്ധപ്പെട്ട traffic hazards നിയന്ത്രിക്കുന്ന safety സംവിധാനമാണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Vehicle collision, struck-by incidents, pedestrian accidents എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Traffic routes, speed limits, pedestrian walkways, reversing controls, vehicle inspection, competent drivers എന്നിവ ഉറപ്പാക്കണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management traffic controls നൽകണം. Supervisors compliance പരിശോധിക്കണം. Drivers, pedestrians എന്നിവർ site traffic rules പാലിക്കണം.',
        'Malayalam_checklist': 'Traffic Safety Checklist',
        'Malayalam_checklistText':
            'Vehicle inspection, seat belt, speed control, pedestrian segregation, reversing alarm, warning signs, lighting എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Speeding, unsafe reversing, unauthorized driving, pedestrian route block ചെയ്യൽ, seat belt ഉപയോഗിക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Vehicles-ഉം pedestrians-ഉം സാധ്യമായിടത്ത് വേർതിരിക്കുക. Reversing സമയത്ത് ആവശ്യമായിടത്ത് banksman ഉപയോഗിക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE traffic requirements, Company Traffic Management Plan, HSE procedures.',
      },

      {
        'letter': 'W',
        'title': 'Work at Height Safety',
        'desc':
            'Safe planning and control of activities where workers may fall from height.',

        'English_title': 'Work at Height Safety',
        'English_what': 'What is Work at Height?',
        'English_whatText':
            'Work at height is work where a person could fall from one level to another and suffer injury.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent falls from height and protect workers from falling objects.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Plan the work, avoid work at height where practicable, use suitable access equipment, provide edge protection and use fall protection systems where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable systems and equipment. Supervisors ensure controls are implemented. Workers use equipment correctly and follow procedures.',
        'English_checklist': 'Work at Height Checklist',
        'English_checklistText':
            'Risk assessment, access equipment, scaffold inspection, guardrails, toe boards, harness where required, anchor points and dropped-object controls.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unprotected edges, unsafe ladders, incomplete scaffolds, missing guardrails and failure to use required fall protection.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Avoid work at height where possible and prioritize collective protection such as guardrails before personal fall protection.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable ADOSH-SF requirements, company work-at-height procedure and relevant UAE requirements.',

        'Hindi_title': 'Work at Height Safety',
        'Hindi_what': 'Work at Height क्या है?',
        'Hindi_whatText':
            'ऐसा काम जिसमें व्यक्ति एक स्तर से दूसरे स्तर पर गिर सकता है और घायल हो सकता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'ऊँचाई से गिरने और falling objects से होने वाली चोटों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Risk assessment, suitable access equipment, guardrails और आवश्यक fall protection उपलब्ध होना चाहिए।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable equipment दे। Supervisors controls लागू करें। Workers procedures का पालन करें।',
        'Hindi_checklist': 'Work at Height Checklist',
        'Hindi_checklistText':
            'Risk assessment, scaffold, ladders, guardrails, toe boards, harness और anchor points की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Unprotected edges, unsafe ladders, incomplete scaffolds और fall protection की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'जहाँ संभव हो work at height से बचें और collective protection को प्राथमिकता दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable ADOSH-SF requirements, company work-at-height procedure और UAE requirements।',

        'Malayalam_title': 'Work at Height Safety',
        'Malayalam_what': 'Work at Height എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു വ്യക്തിക്ക് ഒരു ഉയരത്തിൽ നിന്ന് മറ്റൊരു level-ലേക്ക് വീഴാൻ സാധ്യതയുള്ള ജോലി Work at Height ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Height-ൽ നിന്ന് വീഴുന്നതും falling objects മൂലമുള്ള അപകടങ്ങളും തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Risk Assessment, safe access equipment, guardrails, edge protection, fall protection എന്നിവ ആവശ്യമായിടത്ത് നൽകണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable equipment നൽകണം. Supervisors controls ഉറപ്പാക്കണം. Workers procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Work at Height Checklist',
        'Malayalam_checklistText':
            'Risk Assessment, scaffold inspection, ladder, guardrails, toe boards, harness, anchor points എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Unprotected edge, unsafe ladder, incomplete scaffold, guardrail ഇല്ലായ്മ, fall protection ഉപയോഗിക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'സാധ്യമെങ്കിൽ work at height ഒഴിവാക്കുക. Collective protection ആദ്യം നൽകുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ ADOSH-SF requirements, Company Work at Height Procedure, UAE requirements.',
      },

      {
        'letter': 'X',
        'title': 'Excavation & Trenching Safety',
        'desc':
            'Safety controls for excavation, trenching and underground work.',

        'English_title': 'Excavation & Trenching Safety',
        'English_what': 'What is Excavation Safety?',
        'English_whatText':
            'Excavation safety involves controlling hazards associated with digging, trenches, unstable ground and underground services.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent collapse, falls, struck-by incidents and damage to underground services.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify underground services, assess ground conditions, provide suitable protective systems, safe access and egress, barricading and inspections.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Competent persons inspect excavations. Supervisors control access and work activities. Workers follow excavation procedures.',
        'English_checklist': 'Excavation Checklist',
        'English_checklistText':
            'Permit where required, underground services, soil condition, shoring or sloping, access ladder, barricades, water control and daily inspection.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unprotected excavation, unsafe access, unsupported sides, missing barricades and failure to identify underground services.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a competent-person inspection system and ensure protective measures are in place before workers enter an excavation.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements and company excavation procedure.',

        'Hindi_title': 'Excavation & Trenching Safety',
        'Hindi_what': 'Excavation Safety क्या है?',
        'Hindi_whatText':
            'Excavation और trench में digging, unstable soil और underground services से जुड़े hazards को नियंत्रित करना।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Collapse, falls और underground services damage को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Underground services की पहचान, ground assessment, shoring या sloping, safe access और barricading सुनिश्चित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Competent person excavation inspect करे। Supervisors work control करें। Workers procedures का पालन करें।',
        'Hindi_checklist': 'Excavation Checklist',
        'Hindi_checklistText':
            'Permit, underground services, soil condition, shoring, ladder, barricades और inspection की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Unprotected excavation, unsafe access, unsupported sides और missing barricades।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Workers के प्रवेश से पहले competent person inspection और protective measures सुनिश्चित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE requirements, ADOSH-SF requirements और company excavation procedure।',

        'Malayalam_title': 'Excavation & Trenching Safety',
        'Malayalam_what': 'Excavation Safety എന്താണ്?',
        'Malayalam_whatText':
            'Excavation, trenching, unstable soil, underground services എന്നിവയുമായി ബന്ധപ്പെട്ട hazards നിയന്ത്രിക്കുന്ന safety process ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Excavation collapse, falls, struck-by incidents, underground services damage എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Underground services identify ചെയ്യുക, ground condition assess ചെയ്യുക, shoring/sloping, safe access, barricading എന്നിവ നൽകുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Competent person excavation inspect ചെയ്യണം. Supervisors access/work control ചെയ്യണം. Workers procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Excavation Checklist',
        'Malayalam_checklistText':
            'Permit, underground services, soil condition, shoring/sloping, ladder, barricades, water control, inspection എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Unprotected excavation, unsafe access, unsupported sides, barricade ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Workers excavation-ൽ പ്രവേശിക്കുന്നതിന് മുമ്പ് competent-person inspection ഉറപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE requirements, ADOSH-SF requirements, Company Excavation Procedure.',
      },

      {
        'letter': 'Y',
        'title': 'Young & New Workers Safety',
        'desc':
            'Safety controls for young, new and inexperienced workers.',

        'English_title': 'Young & New Workers Safety',
        'English_what': 'Who are Young & New Workers?',
        'English_whatText':
            'Young and new workers may have limited experience, knowledge or familiarity with workplace hazards and therefore may require additional supervision and training.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect inexperienced workers through suitable induction, supervision, training and task controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Provide induction, task-specific training, competent supervision and ensure workers are assigned only suitable tasks according to their competence and applicable requirements.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides training and supervision. Supervisors monitor new workers closely. Workers ask questions and follow instructions.',
        'English_checklist': 'Worker Safety Checklist',
        'English_checklistText':
            'Induction, competency, task training, supervision, PPE, emergency information and understanding of site rules.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Assigning unfamiliar tasks without training, inadequate supervision and allowing workers to perform tasks beyond their competence.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a structured induction and mentoring approach and gradually increase responsibilities as competence is demonstrated.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE labour and OSH requirements, company competency procedure and ADOSH-SF requirements.',

        'Hindi_title': 'Young & New Workers Safety',
        'Hindi_what': 'Young & New Workers कौन हैं?',
        'Hindi_whatText':
            'ऐसे कर्मचारी जिनके पास workplace hazards के बारे में सीमित अनुभव या जानकारी हो सकती है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Training, induction और supervision के माध्यम से inexperienced workers की सुरक्षा करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Induction, task training, competent supervision और competency के अनुसार suitable tasks प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management training और supervision दे। Supervisors closely monitor करें। Workers instructions का पालन करें।',
        'Hindi_checklist': 'Worker Safety Checklist',
        'Hindi_checklistText':
            'Induction, competency, training, supervision, PPE और emergency information की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'बिना training task देना, inadequate supervision और competence से बाहर काम देना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Structured induction और mentoring system लागू करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Applicable UAE labour/OSH requirements, company competency procedure और ADOSH-SF requirements।',

        'Malayalam_title': 'Young & New Workers Safety',
        'Malayalam_what': 'Young & New Workers ആരാണ്?',
        'Malayalam_whatText':
            'Workplace hazards-നെ കുറിച്ച് പരിചയവും അറിവും കുറവായിരിക്കാവുന്ന പുതിയ അല്ലെങ്കിൽ young workers ആണ് ഇവർ.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Induction, training, supervision എന്നിവയിലൂടെ inexperienced workers-ന്റെ safety ഉറപ്പാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Induction, task-specific training, competent supervision എന്നിവ നൽകുകയും competency അനുസരിച്ചുള്ള ജോലി മാത്രം നൽകുകയും വേണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management training/supervision നൽകണം. Supervisors new workers-നെ closely monitor ചെയ്യണം. Workers instructions പാലിക്കണം.',
        'Malayalam_checklist': 'Worker Safety Checklist',
        'Malayalam_checklistText':
            'Induction, competency, task training, supervision, PPE, emergency information എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Training ഇല്ലാതെ unfamiliar task നൽകൽ, inadequate supervision, competency-ക്ക് പുറത്തുള്ള ജോലി നൽകൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Structured induction, mentoring, close supervision എന്നിവ നടപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE labour/OSH requirements, Company Competency Procedure, ADOSH-SF requirements.',
      },

      {
        'letter': 'Z',
        'title': 'Zero Harm & Safety Culture',
        'desc':
            'Continuous improvement, proactive hazard prevention and positive safety culture.',

        'English_title': 'Zero Harm & Safety Culture',
        'English_what': 'What is a Safety Culture?',
        'English_whatText':
            'Safety culture is the shared values, attitudes and behaviours that influence how an organization manages health and safety.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To promote proactive hazard prevention, responsible behaviour and continuous improvement in workplace safety.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Encourage hazard reporting, worker participation, leadership involvement, inspections, learning from incidents and timely corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Leaders demonstrate commitment. Supervisors reinforce safe behaviours. Workers participate, report hazards and stop unsafe work when necessary.',
        'English_checklist': 'Safety Culture Checklist',
        'English_checklistText':
            'Leadership commitment, worker participation, hazard reporting, inspections, training, incident learning and corrective action closure.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Ignoring hazards, discouraging reporting, repeating unsafe practices, poor follow-up and treating safety as a paperwork exercise.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Build a just and proactive reporting culture, recognize positive safety behaviour and use lessons learned to prevent recurrence.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE management system, applicable ADOSH-SF requirements and relevant UAE OSH requirements.',

        'Hindi_title': 'Zero Harm & Safety Culture',
        'Hindi_what': 'Safety Culture क्या है?',
        'Hindi_whatText':
            'Safety culture संगठन के साझा values, attitudes और behaviours हैं जो workplace safety को प्रभावित करते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Hazards की proactive prevention और continuous safety improvement को बढ़ावा देना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazard reporting, worker participation, leadership involvement, inspections और corrective actions को बढ़ावा दें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Leaders safety commitment दिखाएँ। Supervisors safe behaviour reinforce करें। Workers hazards report करें।',
        'Hindi_checklist': 'Safety Culture Checklist',
        'Hindi_checklistText':
            'Leadership, worker participation, reporting, inspection, training और corrective action की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Hazards ignore करना, reporting को discourage करना और unsafe practices को repeat करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Positive reporting culture बनाएं और lessons learned का उपयोग करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE Management System, ADOSH-SF requirements और UAE OSH requirements।',

        'Malayalam_title': 'Zero Harm & Safety Culture',
        'Malayalam_what': 'Safety Culture എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു സ്ഥാപനത്തിലെ safety-യെ സ്വാധീനിക്കുന്ന shared values, attitudes, behaviours എന്നിവയുടെ സമാഹാരമാണ് Safety Culture.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Hazards proactive ആയി തടയുകയും workplace safety തുടർച്ചയായി മെച്ചപ്പെടുത്തുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazard reporting, worker participation, leadership involvement, inspections, training, incident learning, corrective actions എന്നിവ പ്രോത്സാഹിപ്പിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Leaders safety commitment കാണിക്കണം. Supervisors safe behaviour reinforce ചെയ്യണം. Workers hazards report ചെയ്യണം.',
        'Malayalam_checklist': 'Safety Culture Checklist',
        'Malayalam_checklistText':
            'Leadership commitment, worker participation, hazard reporting, inspection, training, incident learning, corrective action closure എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Hazards ignore ചെയ്യൽ, reporting discourage ചെയ്യൽ, unsafe practices ആവർത്തിക്കൽ, follow-up ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Positive safety reporting culture വളർത്തുക. Lessons learned ഉപയോഗിച്ച് incidents ആവർത്തിക്കുന്നത് തടയുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE Management System, ബാധകമായ ADOSH-SF requirements, UAE OSH requirements.',
      },
      
