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

        'Hindi_title': 'Dubai Code of Practice (CoP)',
        'Hindi_what': 'Code of Practice क्या है?',
        'Hindi_whatText':
            'Code of Practice किसी विशेष सुरक्षा जोखिम या कार्य के लिए व्यावहारिक आवश्यकताएँ और मार्गदर्शन प्रदान करता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'विशिष्ट कार्यों और खतरों के लिए एक समान सुरक्षा नियंत्रण स्थापित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'लागू Authority requirements की पहचान करें, वर्तमान दस्तावेजों का उपयोग करें और उचित risk controls लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management और HSE team applicable requirements पहचानें। Supervisors site पर लागू करें। Workers controls का पालन करें।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'Applicable authority, current document, risk assessment, controls, worker briefing और inspection records की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'पुराने requirements का उपयोग, inadequate controls, worker briefing की कमी और inspection records का अभाव।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Legal register बनाए रखें और documents के latest revisions को नियमित रूप से verify करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू Dubai authority requirements और current Codes of Practice। Compliance decision से पहले official publication verify करें।',

        'Malayalam_title': 'Dubai Code of Practice (CoP)',
        'Malayalam_what': 'Code of Practice എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു പ്രത്യേക ജോലി അല്ലെങ്കിൽ safety hazard നിയന്ത്രിക്കുന്നതിനുള്ള practical requirements / guidance നൽകുന്ന രേഖയാണ് Code of Practice.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'പ്രത്യേക ജോലികൾക്കും hazards-നും സ്ഥിരതയുള്ള safety controls നൽകുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'ബാധകമായ Authority requirements തിരിച്ചറിയുക, current approved documents ഉപയോഗിക്കുക, Risk Controls നടപ്പാക്കുക, records maintain ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management/HSE team applicable requirements തിരിച്ചറിയണം. Supervisors site-ൽ implement ചെയ്യണം. Workers controls പാലിക്കണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'Applicable authority, current document, Risk Assessment, controls, worker briefing, inspection records എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'പഴയ requirements ഉപയോഗിക്കൽ, risk controls ഇല്ലായ്മ, worker briefing ഇല്ലായ്മ, documentation/inspection കുറവ്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Legal/Regulatory Register maintain ചെയ്യുക. Documents-ന്റെ latest revision സ്ഥിരമായി verify ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ Dubai Authority requirements, current Codes of Practice. Compliance decision എടുക്കുന്നതിന് മുമ്പ് official publication പരിശോധിക്കുക.',

        'Tamil_title': 'Dubai Code of Practice (CoP)',
        'Tamil_what': 'Code of Practice என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு குறிப்பிட்ட வேலை அல்லது பாதுகாப்பு அபாயத்தை நிர்வகிப்பதற்கான நடைமுறை தேவைகள் அல்லது வழிகாட்டுதலை Code of Practice வழங்குகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'குறிப்பிட்ட பணிகள் மற்றும் அபாயங்களுக்கு ஒரே மாதிரியான பாதுகாப்பு கட்டுப்பாடுகளை வழங்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'பொருந்தும் Authority requirements-ஐ கண்டறிந்து, current approved documents பயன்படுத்தி, risk controls செயல்படுத்த வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management/HSE team requirements-ஐ கண்டறிய வேண்டும். Supervisors site-ல் செயல்படுத்த வேண்டும். Workers controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'Authority, current document, Risk Assessment, controls, worker briefing மற்றும் inspection records ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'பழைய requirements பயன்படுத்துதல், risk controls இல்லாமை, worker briefing இல்லாமை மற்றும் inspection records குறைபாடு.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Legal/Regulatory Register பராமரித்து, documents-ன் latest revision-ஐ தொடர்ந்து verify செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் Dubai Authority requirements மற்றும் current Codes of Practice. Compliance முடிவுகளுக்கு முன் official publication-ஐ சரிபார்க்கவும்.',
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

        'Hindi_title': 'Daily Toolbox Talk (TBT)',
        'Hindi_what': 'Toolbox Talk क्या है?',
        'Hindi_whatText':
            'Toolbox Talk काम शुरू होने से पहले किया जाने वाला छोटा और focused safety briefing है जिसमें task, hazards और controls पर चर्चा होती है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers को दिन के कार्य, hazards, controls और emergency arrangements समझाना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Actual task, hazards, controls, PPE और emergency arrangements पर चर्चा करें तथा attendance record करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Supervisor या competent person briefing lead करे। Workers भाग लें और hazards report करें।',
        'Hindi_checklist': 'TBT चेकलिस्ट',
        'Hindi_checklistText':
            'Task, hazards, controls, PPE, equipment, emergency arrangements और attendance की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'केवल formality के लिए TBT करना, worker participation न होना और attendance records का अभाव।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Briefing को task-specific और interactive रखें। Recent incidents और site observations का उपयोग करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements और site risk assessments।',

        'Malayalam_title': 'Daily Toolbox Talk (TBT)',
        'Malayalam_what': 'Toolbox Talk എന്താണ്?',
        'Malayalam_whatText':
            'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് planned task, hazards, controls, PPE, emergency arrangements എന്നിവ ചർച്ച ചെയ്യുന്ന ചെറിയ safety briefing ആണ് Toolbox Talk.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ദിവസത്തെ ജോലി, hazards, controls, emergency arrangements എന്നിവ തൊഴിലാളികൾക്ക് വ്യക്തമായി മനസ്സിലാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Actual task, hazards, controls, PPE, equipment, emergency arrangements എന്നിവ ചർച്ച ചെയ്യുകയും attendance record ചെയ്യുകയും വേണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Supervisor/competent person briefing നടത്തണം. Workers പങ്കെടുക്കുകയും hazards/concerns report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'TBT Checklist',
        'Malayalam_checklistText':
            'Task, hazards, controls, PPE, equipment, emergency arrangements, attendance എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Formality ആയി മാത്രം TBT നടത്തുക, worker participation ഇല്ലായ്മ, attendance record ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'TBT task-specific, interactive ആക്കുക. Recent incidents, site observations, lessons learned എന്നിവ ഉപയോഗിക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE procedures, ബാധകമായ ADOSH-SF requirements, site-specific Risk Assessments.',

        'Tamil_title': 'Daily Toolbox Talk (TBT)',
        'Tamil_what': 'Toolbox Talk என்றால் என்ன?',
        'Tamil_whatText':
            'வேலை தொடங்குவதற்கு முன் planned task, hazards, controls, PPE மற்றும் emergency arrangements குறித்து நடத்தப்படும் குறுகிய safety briefing.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'அன்றைய வேலை, hazards, controls மற்றும் emergency arrangements குறித்து workers புரிந்துகொள்ளச் செய்வது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Task, hazards, controls, PPE மற்றும் emergency arrangements பற்றி விவாதித்து attendance record செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Supervisor/competent person briefing நடத்த வேண்டும். Workers கலந்து கொண்டு hazards-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'TBT Checklist',
        'Tamil_checklistText':
            'Task, hazards, controls, PPE, equipment, emergency arrangements மற்றும் attendance ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Formality-க்காக மட்டும் TBT நடத்துதல், worker participation இல்லாமை மற்றும் records இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'TBT-ஐ task-specific மற்றும் interactive ஆக வைத்துக்கொள்ளவும். Recent incidents மற்றும் site observations பயன்படுத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements மற்றும் site-specific Risk Assessments.',
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

        'Hindi_title': 'Emergency Preparedness',
        'Hindi_what': 'Emergency Preparedness क्या है?',
        'Hindi_whatText':
            'आपातकाल के लिए लोगों, प्रक्रियाओं और संसाधनों को पहले से तैयार करने की प्रक्रिया Emergency Preparedness है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'जीवन की रक्षा करना, चोटों और property damage को कम करना तथा व्यवस्थित emergency response सुनिश्चित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'संभावित emergencies की पहचान, emergency procedures, alarms, communication, equipment, assembly point और training/drills की व्यवस्था करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources प्रदान करे। Emergency team अपने roles के अनुसार response करे। Workers evacuation instructions का पालन करें।',
        'Hindi_checklist': 'Emergency Checklist',
        'Hindi_checklistText':
            'Emergency plan, alarm, contacts, evacuation route, assembly point, fire equipment, first aid और drill records की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Blocked exits, unavailable extinguishers, unclear assembly points, outdated contacts और untrained workers।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Emergency plans की नियमित समीक्षा करें, drills करें और drill findings पर corrective actions बंद करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू UAE/local authority emergency requirements, company emergency response plan और ADOSH-SF requirements।',

        'Malayalam_title': 'Emergency Preparedness',
        'Malayalam_what': 'Emergency Preparedness എന്താണ്?',
        'Malayalam_whatText':
            'Fire, accident, medical emergency തുടങ്ങിയ സാഹചര്യങ്ങളിൽ ഫലപ്രദമായി പ്രതികരിക്കാൻ ആളുകളെയും സംവിധാനങ്ങളെയും ഉപകരണങ്ങളെയും മുൻകൂട്ടി തയ്യാറാക്കുന്ന പ്രക്രിയയാണ് Emergency Preparedness.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജീവൻ സംരക്ഷിക്കുക, പരിക്കുകളും property damage-ഉം കുറയ്ക്കുക, organized emergency response ഉറപ്പാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Credible emergencies തിരിച്ചറിയുക, Emergency Plan, alarm, communication, emergency equipment, assembly point, training, drills എന്നിവ ഒരുക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Emergency team സ്വന്തം roles അനുസരിച്ച് പ്രവർത്തിക്കണം. Workers alarm, evacuation instructions, assembly procedure എന്നിവ പാലിക്കണം.',
        'Malayalam_checklist': 'Emergency Checklist',
        'Malayalam_checklistText':
            'Emergency Plan, alarm, emergency contacts, evacuation routes, assembly point, fire equipment, first aid, emergency access, drill records എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Emergency exit block ചെയ്യൽ, extinguisher unavailable, assembly point വ്യക്തമല്ലാത്തത്, outdated contacts, training ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Emergency Plan regular ആയി review ചെയ്യുക, drills നടത്തുക, drill findings പരിശോധിച്ച് corrective actions close ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE/local authority emergency requirements, Company Emergency Response Plan, ADOSH-SF requirements.',

        'Tamil_title': 'Emergency Preparedness',
        'Tamil_what': 'Emergency Preparedness என்றால் என்ன?',
        'Tamil_whatText':
            'தீ, விபத்து மற்றும் பிற அவசரநிலைகளுக்கு முன்கூட்டியே மக்கள், நடைமுறைகள் மற்றும் வளங்களைத் தயார்படுத்தும் செயல்முறை.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'உயிர்களைப் பாதுகாத்தல், காயங்கள் மற்றும் சொத்து சேதத்தை குறைத்தல் மற்றும் ஒழுங்கான emergency response உறுதி செய்தல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Possible emergencies, emergency procedures, alarms, communication, equipment, assembly point மற்றும் training/drills ஏற்பாடு செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources வழங்க வேண்டும். Emergency team தங்கள் roles-க்கு ஏற்ப செயல்பட வேண்டும். Workers evacuation instructions-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Emergency Checklist',
        'Tamil_checklistText':
            'Emergency plan, alarm, contacts, evacuation routes, assembly point, fire equipment, first aid மற்றும் drill records ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Emergency exits block செய்தல், extinguishers இல்லாமை, assembly point தெளிவில்லாமை மற்றும் training இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Emergency plans-ஐ தொடர்ந்து review செய்து drills நடத்தி corrective actions-ஐ close செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE/local authority emergency requirements, Company Emergency Response Plan மற்றும் ADOSH-SF requirements.',
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
              // =========================
      // G - Green Building Regulations
      // =========================
      {
        'letter': 'G',
        'title': 'Green Building Regulations',
        'desc': 'UAE sustainable construction and environmental protection requirements.',

        'English_title': 'Green Building Regulations',
        'English_what': 'What are Green Building Regulations?',
        'English_whatText': 'Green Building Regulations are requirements and practices that promote sustainable construction, energy efficiency, water conservation, responsible material use and environmental protection.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To reduce environmental impact, conserve resources, improve building efficiency and support a healthier working and living environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Follow approved environmental procedures, control waste, prevent pollution, conserve water and energy, and use approved sustainable materials and systems where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Management shall provide resources and procedures. Supervisors shall monitor implementation. Workers shall follow environmental controls and report spills, waste issues and unsafe practices.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Waste segregation, dust control, spill prevention, water conservation, energy conservation, approved materials, housekeeping and environmental inspections.',
        'English_violations': 'Violations',
        'English_violationsText': 'Improper waste disposal, uncontrolled dust, pollution, unnecessary resource consumption and failure to follow approved environmental procedures may result in corrective action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Plan environmental controls before work, segregate waste at source, prevent pollution, monitor resource consumption and maintain good housekeeping throughout the project.',
        'English_reference': 'Reference',
        'English_referenceText': 'Applicable UAE environmental requirements, local authority requirements and approved project environmental procedures.',

        'Hindi_title': 'Green Building Regulations',
        'Hindi_what': 'ग्रीन बिल्डिंग नियम क्या हैं?',
        'Hindi_whatText': 'ग्रीन बिल्डिंग नियम टिकाऊ निर्माण, ऊर्जा दक्षता, जल संरक्षण, जिम्मेदार सामग्री उपयोग और पर्यावरण संरक्षण को बढ़ावा देने वाले नियम और कार्यप्रणालियाँ हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'पर्यावरण पर प्रभाव कम करना, संसाधनों का संरक्षण करना, भवन की दक्षता बढ़ाना और स्वस्थ कार्य एवं रहने का वातावरण बनाना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'स्वीकृत पर्यावरणीय प्रक्रियाओं का पालन करें, कचरे को नियंत्रित करें, प्रदूषण रोकें, पानी और ऊर्जा बचाएँ तथा आवश्यकतानुसार स्वीकृत टिकाऊ सामग्री और प्रणालियों का उपयोग करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'प्रबंधन आवश्यक संसाधन और प्रक्रियाएँ उपलब्ध कराए। सुपरवाइजर कार्यान्वयन की निगरानी करें। कर्मचारी पर्यावरणीय नियंत्रणों का पालन करें और रिसाव, कचरा तथा असुरक्षित कार्य की रिपोर्ट करें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'कचरा पृथक्करण, धूल नियंत्रण, रिसाव रोकथाम, जल संरक्षण, ऊर्जा संरक्षण, स्वीकृत सामग्री, हाउसकीपिंग और पर्यावरणीय निरीक्षण।',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'कचरे का गलत निपटान, अनियंत्रित धूल, प्रदूषण, संसाधनों की अनावश्यक खपत और पर्यावरणीय प्रक्रियाओं का पालन न करना सुधारात्मक कार्रवाई का कारण बन सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'काम शुरू करने से पहले पर्यावरणीय नियंत्रण की योजना बनाएं, स्रोत पर कचरे को अलग करें, प्रदूषण रोकें और अच्छी हाउसकीपिंग बनाए रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'लागू UAE पर्यावरणीय आवश्यकताएँ, स्थानीय प्राधिकरण की आवश्यकताएँ और स्वीकृत परियोजना पर्यावरणीय प्रक्रियाएँ।',

        'Malayalam_title': 'Green Building Regulations',
        'Malayalam_what': 'Green Building Regulations എന്താണ്?',
        'Malayalam_whatText': 'സുസ്ഥിര നിർമ്മാണം, ഊർജ്ജ കാര്യക്ഷമത, ജലസംരക്ഷണം, ഉത്തരവാദിത്തമുള്ള മെറ്റീരിയൽ ഉപയോഗം, പരിസ്ഥിതി സംരക്ഷണം എന്നിവ പ്രോത്സാഹിപ്പിക്കുന്ന നിയമങ്ങളും പ്രവർത്തനരീതികളുമാണ് Green Building Regulations.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'പരിസ്ഥിതിയിലെ ആഘാതം കുറയ്ക്കുക, പ്രകൃതി വിഭവങ്ങൾ സംരക്ഷിക്കുക, കെട്ടിടങ്ങളുടെ കാര്യക്ഷമത വർധിപ്പിക്കുക, ആരോഗ്യകരമായ ജോലി-ജീവിത അന്തരീക്ഷം ഉറപ്പാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'അംഗീകരിച്ച Environmental Procedures പാലിക്കുക, മാലിന്യങ്ങൾ നിയന്ത്രിക്കുക, മലിനീകരണം തടയുക, വെള്ളവും വൈദ്യുതിയും സംരക്ഷിക്കുക, ആവശ്യമായിടത്ത് അംഗീകരിച്ച സുസ്ഥിര മെറ്റീരിയലുകൾ ഉപയോഗിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Management ആവശ്യമായ വിഭവങ്ങളും നടപടിക്രമങ്ങളും നൽകണം. Supervisors നടപ്പാക്കൽ നിരീക്ഷിക്കണം. Workers Environmental Controls പാലിക്കുകയും Spill, Waste പ്രശ്നങ്ങൾ റിപ്പോർട്ട് ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'Waste Segregation, Dust Control, Spill Prevention, Water Conservation, Energy Conservation, Approved Materials, Housekeeping, Environmental Inspection.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'മാലിന്യം തെറ്റായി സംസ്കരിക്കൽ, നിയന്ത്രണമില്ലാത്ത പൊടി, മലിനീകരണം, വിഭവങ്ങളുടെ അനാവശ്യ ഉപയോഗം, Environmental Procedures പാലിക്കാത്തത് എന്നിവ Corrective Action-ന് കാരണമാകാം.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് Environmental Controls പ്ലാൻ ചെയ്യുക, ഉറവിടത്തിൽ തന്നെ മാലിന്യങ്ങൾ വേർതിരിക്കുക, മലിനീകരണം തടയുക, നല്ല Housekeeping നിലനിർത്തുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'ബാധകമായ UAE Environmental Requirements, Local Authority Requirements, Approved Project Environmental Procedures.',

        'Tamil_title': 'Green Building Regulations',
        'Tamil_what': 'Green Building Regulations என்றால் என்ன?',
        'Tamil_whatText': 'நிலையான கட்டுமானம், ஆற்றல் திறன், நீர் பாதுகாப்பு, பொறுப்பான பொருள் பயன்பாடு மற்றும் சுற்றுச்சூழல் பாதுகாப்பை ஊக்குவிக்கும் விதிமுறைகள் மற்றும் நடைமுறைகளே Green Building Regulations ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'சுற்றுச்சூழல் பாதிப்பைக் குறைத்தல், வளங்களைப் பாதுகாத்தல், கட்டிட செயல்திறனை மேம்படுத்துதல் மற்றும் ஆரோக்கியமான பணிச்சூழலை உருவாக்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'அங்கீகரிக்கப்பட்ட சுற்றுச்சூழல் நடைமுறைகளைப் பின்பற்றுதல், கழிவுகளை கட்டுப்படுத்துதல், மாசுபாட்டைத் தடுத்தல், நீர் மற்றும் ஆற்றலைச் சேமித்தல் மற்றும் தேவையான இடங்களில் அங்கீகரிக்கப்பட்ட நிலையான பொருட்களைப் பயன்படுத்துதல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Management தேவையான வளங்களையும் நடைமுறைகளையும் வழங்க வேண்டும். Supervisors செயல்படுத்தலை கண்காணிக்க வேண்டும். Workers சுற்றுச்சூழல் கட்டுப்பாடுகளைப் பின்பற்றி Spill மற்றும் Waste பிரச்சினைகளைப் புகாரளிக்க வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'கழிவு பிரித்தல், தூசி கட்டுப்பாடு, Spill Prevention, நீர் சேமிப்பு, ஆற்றல் சேமிப்பு, அங்கீகரிக்கப்பட்ட பொருட்கள், Housekeeping மற்றும் சுற்றுச்சூழல் ஆய்வுகள்.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'கழிவுகளை தவறாக அகற்றுதல், கட்டுப்பாடற்ற தூசி, மாசுபாடு, வளங்களை தேவையின்றி பயன்படுத்துதல் மற்றும் சுற்றுச்சூழல் நடைமுறைகளைப் பின்பற்றாதது Corrective Action-க்கு வழிவகுக்கலாம்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'வேலை தொடங்குவதற்கு முன் சுற்றுச்சூழல் கட்டுப்பாடுகளைத் திட்டமிடுதல், கழிவுகளை மூலத்திலேயே பிரித்தல், மாசுபாட்டைத் தடுத்தல் மற்றும் நல்ல Housekeeping பராமரித்தல்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'பொருந்தக்கூடிய UAE சுற்றுச்சூழல் தேவைகள், உள்ளூர் அதிகாரிகளின் தேவைகள் மற்றும் அங்கீகரிக்கப்பட்ட திட்ட சுற்றுச்சூழல் நடைமுறைகள்.',
      },

      // =========================
      // H - Heat Stress Management
      // =========================
      {
        'letter': 'H',
        'title': 'Heat Stress Management',
        'desc': 'Heat stress precautions and UAE midday break requirements.',

        'English_title': 'Heat Stress Management',
        'English_what': 'What is Heat Stress Management?',
        'English_whatText': 'Heat stress management is the process of preventing and controlling heat-related illness caused by high temperature, humidity and physical work.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To prevent heat exhaustion, heat stroke, dehydration and other heat-related illnesses.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Provide drinking water, suitable rest areas, heat-stress awareness, appropriate work-rest arrangements and controls required by applicable UAE rules and project procedures.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Management shall provide heat-stress controls and resources. Supervisors shall monitor workers. Workers shall hydrate, use rest periods and report symptoms immediately.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Drinking water, shaded/rest area, worker awareness, work-rest schedule, buddy monitoring, first-aid arrangements and emergency response.',
        'English_violations': 'Violations',
        'English_violationsText': 'Working without required heat controls, denying adequate rest or water, ignoring symptoms and failing to follow applicable midday work restrictions can create serious risk.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Schedule heavy work during cooler periods, encourage frequent hydration, monitor new workers and vulnerable workers, and stop work when heat illness symptoms appear.',
        'English_reference': 'Reference',
        'English_referenceText': 'Applicable UAE Ministry of Human Resources and Emiratisation requirements, local authority requirements and project heat-stress procedures.',

        'Hindi_title': 'Heat Stress Management',
        'Hindi_what': 'हीट स्ट्रेस मैनेजमेंट क्या है?',
        'Hindi_whatText': 'उच्च तापमान, नमी और शारीरिक मेहनत के कारण होने वाली गर्मी से संबंधित बीमारी को रोकने और नियंत्रित करने की प्रक्रिया Heat Stress Management है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'हीट एक्सॉशन, हीट स्ट्रोक, डिहाइड्रेशन और गर्मी से संबंधित अन्य बीमारियों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'पीने का पानी, उचित विश्राम स्थान, हीट स्ट्रेस जागरूकता, उचित कार्य-विराम व्यवस्था और लागू UAE नियमों के अनुसार आवश्यक नियंत्रण उपलब्ध कराएँ।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'प्रबंधन हीट स्ट्रेस नियंत्रण और संसाधन उपलब्ध कराए। सुपरवाइजर कर्मचारियों की निगरानी करें। कर्मचारी पानी पिएँ, विश्राम लें और लक्षण तुरंत रिपोर्ट करें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'पीने का पानी, छायादार विश्राम स्थान, कर्मचारी जागरूकता, कार्य-विराम कार्यक्रम, Buddy Monitoring, First Aid और Emergency Response.',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'हीट स्ट्रेस नियंत्रण के बिना काम करना, पर्याप्त पानी या विश्राम न देना, लक्षणों को नजरअंदाज करना और लागू Midday Work Restrictions का पालन न करना गंभीर जोखिम पैदा कर सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'भारी काम ठंडे समय में करें, नियमित पानी पीने को प्रोत्साहित करें, नए कर्मचारियों की निगरानी करें और Heat Illness के लक्षण दिखने पर काम रोकें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'लागू UAE Ministry of Human Resources and Emiratisation आवश्यकताएँ, स्थानीय प्राधिकरण की आवश्यकताएँ और परियोजना Heat Stress Procedures.',

        'Malayalam_title': 'Heat Stress Management',
        'Malayalam_what': 'Heat Stress Management എന്താണ്?',
        'Malayalam_whatText': 'ഉയർന്ന താപനില, ഈർപ്പം, ശാരീരിക അധ്വാനം എന്നിവ മൂലം ഉണ്ടാകുന്ന ചൂട് സംബന്ധമായ അസുഖങ്ങൾ തടയുകയും നിയന്ത്രിക്കുകയും ചെയ്യുന്ന പ്രക്രിയയാണ് Heat Stress Management.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'Heat Exhaustion, Heat Stroke, Dehydration തുടങ്ങിയ ചൂട് സംബന്ധമായ അസുഖങ്ങൾ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'കുടിവെള്ളം, അനുയോജ്യമായ വിശ്രമസ്ഥലം, Heat Stress Awareness, Work-Rest Arrangement, ബാധകമായ UAE നിയമങ്ങൾ ആവശ്യപ്പെടുന്ന നിയന്ത്രണങ്ങൾ എന്നിവ നൽകണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Management Heat Stress Controls നൽകണം. Supervisors തൊഴിലാളികളെ നിരീക്ഷിക്കണം. Workers ആവശ്യമായ വെള്ളം കുടിക്കുകയും Rest Period ഉപയോഗിക്കുകയും ലക്ഷണങ്ങൾ ഉടൻ റിപ്പോർട്ട് ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'കുടിവെള്ളം, തണലുള്ള വിശ്രമസ്ഥലം, Worker Awareness, Work-Rest Schedule, Buddy Monitoring, First Aid, Emergency Response.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'Heat Controls ഇല്ലാതെ ജോലി ചെയ്യൽ, ആവശ്യമായ വെള്ളമോ വിശ്രമമോ നൽകാതിരിക്കൽ, ലക്ഷണങ്ങൾ അവഗണിക്കൽ, ബാധകമായ Midday Work Restrictions പാലിക്കാതിരിക്കൽ എന്നിവ ഗുരുതര അപകടസാധ്യത സൃഷ്ടിക്കും.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'ഭാരമുള്ള ജോലികൾ തണുത്ത സമയങ്ങളിൽ നടത്തുക, ഇടയ്ക്കിടെ വെള്ളം കുടിക്കാൻ പ്രോത്സാഹിപ്പിക്കുക, പുതിയ തൊഴിലാളികളെ നിരീക്ഷിക്കുക, Heat Illness ലക്ഷണങ്ങൾ കണ്ടാൽ ജോലി നിർത്തുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'ബാധകമായ UAE Ministry of Human Resources and Emiratisation Requirements, Local Authority Requirements, Project Heat Stress Procedures.',

        'Tamil_title': 'Heat Stress Management',
        'Tamil_what': 'Heat Stress Management என்றால் என்ன?',
        'Tamil_whatText': 'அதிக வெப்பநிலை, ஈரப்பதம் மற்றும் உடல் உழைப்பால் ஏற்படும் வெப்பம் தொடர்பான நோய்களைத் தடுக்கும் மற்றும் கட்டுப்படுத்தும் செயல்முறையே Heat Stress Management ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'Heat Exhaustion, Heat Stroke, Dehydration மற்றும் பிற வெப்பம் தொடர்பான நோய்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'குடிநீர், பொருத்தமான ஓய்வு இடம், Heat Stress Awareness, Work-Rest Arrangement மற்றும் பொருந்தக்கூடிய UAE விதிகளின் கட்டுப்பாடுகளை வழங்குதல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Management Heat Stress Controls வழங்க வேண்டும். Supervisors தொழிலாளர்களைக் கண்காணிக்க வேண்டும். Workers தண்ணீர் குடித்து ஓய்வு நேரத்தைப் பயன்படுத்தி அறிகுறிகளை உடனடியாகப் புகாரளிக்க வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'குடிநீர், நிழலான ஓய்வு இடம், Worker Awareness, Work-Rest Schedule, Buddy Monitoring, First Aid மற்றும் Emergency Response.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'Heat Controls இல்லாமல் வேலை செய்தல், போதுமான தண்ணீர் அல்லது ஓய்வு வழங்காதது, அறிகுறிகளைப் புறக்கணித்தல் மற்றும் Midday Work Restrictions-ஐப் பின்பற்றாதது கடுமையான ஆபத்தை உருவாக்கும்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'கனமான பணிகளை குளிரான நேரங்களில் செய்யுங்கள், அடிக்கடி தண்ணீர் குடிக்க ஊக்குவிக்கவும், புதிய தொழிலாளர்களைக் கண்காணிக்கவும், Heat Illness அறிகுறிகள் தோன்றினால் பணியை நிறுத்தவும்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'பொருந்தக்கூடிய UAE Ministry of Human Resources and Emiratisation தேவைகள், உள்ளூர் அதிகாரிகளின் தேவைகள் மற்றும் Project Heat Stress Procedures.',
      },

      // =========================
      // I - Incident Investigation
      // =========================
      {
        'letter': 'I',
        'title': 'Incident Investigation',
        'desc': 'Investigation to identify the causes of incidents and near misses.',

        'English_title': 'Incident Investigation',
        'English_what': 'What is Incident Investigation?',
        'English_whatText': 'Incident investigation is a structured process used to identify what happened, why it happened and what controls are required to prevent recurrence.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To identify immediate, underlying and root causes and prevent similar incidents from happening again.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Report the incident promptly, preserve evidence, interview relevant persons, identify causes, document findings and implement corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Management shall ensure appropriate investigation. Investigators shall collect facts objectively. Workers shall cooperate and provide accurate information.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Initial notification, scene preservation, photographs, witness statements, documents, root-cause analysis, corrective actions and close-out verification.',
        'English_violations': 'Violations',
        'English_violationsText': 'Failure to report incidents, altering evidence, blaming individuals without investigation, or failing to implement corrective actions may lead to recurrence.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Focus on facts and system failures rather than blame. Use suitable root-cause methods and verify that corrective actions are effective.',
        'English_reference': 'Reference',
        'English_referenceText': 'Company incident reporting procedure, applicable UAE requirements and approved HSE investigation procedures.',

        'Hindi_title': 'Incident Investigation',
        'Hindi_what': 'Incident Investigation क्या है?',
        'Hindi_whatText': 'घटना की जाँच एक व्यवस्थित प्रक्रिया है जिसमें यह पता लगाया जाता है कि क्या हुआ, क्यों हुआ और दोबारा घटना रोकने के लिए कौन से नियंत्रण आवश्यक हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'तत्काल, मूल और अंतर्निहित कारणों की पहचान करना तथा समान घटनाओं की पुनरावृत्ति रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'घटना की तुरंत रिपोर्ट करें, साक्ष्य सुरक्षित रखें, संबंधित व्यक्तियों से जानकारी लें, कारणों की पहचान करें और सुधारात्मक कार्रवाई लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'प्रबंधन उचित जाँच सुनिश्चित करे। जाँचकर्ता तथ्यों को निष्पक्ष रूप से एकत्र करें। कर्मचारी सहयोग करें और सही जानकारी दें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'प्रारंभिक सूचना, घटना स्थल सुरक्षित करना, फोटो, गवाह बयान, दस्तावेज, Root Cause Analysis, Corrective Actions और Close-out Verification.',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'घटना की रिपोर्ट न करना, साक्ष्य बदलना, जाँच के बिना व्यक्ति को दोष देना या सुधारात्मक कार्रवाई लागू न करना घटना की पुनरावृत्ति का कारण बन सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'दोष देने के बजाय तथ्यों और सिस्टम की कमियों पर ध्यान दें। उचित Root Cause Methods का उपयोग करें और Corrective Actions की प्रभावशीलता जाँचें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'Company Incident Reporting Procedure, लागू UAE Requirements और Approved HSE Investigation Procedures.',

        'Malayalam_title': 'Incident Investigation',
        'Malayalam_what': 'Incident Investigation എന്താണ്?',
        'Malayalam_whatText': 'ഒരു സംഭവം എന്താണ് സംഭവിച്ചത്, എന്തുകൊണ്ട് സംഭവിച്ചു, വീണ്ടും സംഭവിക്കാതിരിക്കാൻ എന്ത് നിയന്ത്രണങ്ങൾ വേണം എന്നിവ കണ്ടെത്തുന്നതിനുള്ള ക്രമബദ്ധമായ അന്വേഷണ പ്രക്രിയയാണ് Incident Investigation.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'Immediate, Underlying, Root Causes കണ്ടെത്തുകയും സമാനമായ സംഭവങ്ങൾ വീണ്ടും ഉണ്ടാകുന്നത് തടയുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'Incident ഉടൻ റിപ്പോർട്ട് ചെയ്യുക, തെളിവുകൾ സംരക്ഷിക്കുക, ബന്ധപ്പെട്ട വ്യക്തികളിൽ നിന്ന് വിവരങ്ങൾ ശേഖരിക്കുക, കാരണങ്ങൾ കണ്ടെത്തുക, Findings രേഖപ്പെടുത്തുക, Corrective Actions നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Management ശരിയായ Investigation ഉറപ്പാക്കണം. Investigators വസ്തുതകൾ നിഷ്പക്ഷമായി ശേഖരിക്കണം. Workers സഹകരിക്കുകയും ശരിയായ വിവരങ്ങൾ നൽകുകയും വേണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'Initial Notification, Scene Preservation, Photographs, Witness Statements, Documents, Root Cause Analysis, Corrective Actions, Close-out Verification.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'Incident റിപ്പോർട്ട് ചെയ്യാതിരിക്കുക, തെളിവുകൾ മാറ്റുക, Investigation ഇല്ലാതെ വ്യക്തികളെ കുറ്റപ്പെടുത്തുക, Corrective Actions നടപ്പാക്കാതിരിക്കുക എന്നിവ വീണ്ടും അപകടം ഉണ്ടാകാൻ കാരണമാകാം.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'കുറ്റപ്പെടുത്തലിന് പകരം Facts, System Failures എന്നിവയിൽ ശ്രദ്ധ കേന്ദ്രീകരിക്കുക. ശരിയായ Root Cause Methods ഉപയോഗിക്കുകയും Corrective Actions ഫലപ്രദമാണെന്ന് പരിശോധിക്കുകയും ചെയ്യുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'Company Incident Reporting Procedure, ബാധകമായ UAE Requirements, Approved HSE Investigation Procedures.',

        'Tamil_title': 'Incident Investigation',
        'Tamil_what': 'Incident Investigation என்றால் என்ன?',
        'Tamil_whatText': 'என்ன நடந்தது, ஏன் நடந்தது மற்றும் மீண்டும் நடைபெறாமல் இருக்க என்ன கட்டுப்பாடுகள் தேவை என்பதை கண்டறியும் முறையான செயல்முறையே Incident Investigation ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'Immediate, Underlying மற்றும் Root Causes-ஐ கண்டறிந்து இதுபோன்ற சம்பவங்கள் மீண்டும் நடைபெறுவதைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'Incident-ஐ உடனடியாகப் புகாரளித்தல், ஆதாரங்களைப் பாதுகாத்தல், சம்பந்தப்பட்டவர்களிடம் தகவல் பெறுதல், காரணங்களை கண்டறிதல் மற்றும் Corrective Actions செயல்படுத்துதல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Management சரியான Investigation-ஐ உறுதி செய்ய வேண்டும். Investigators உண்மைகளை நடுநிலையாக சேகரிக்க வேண்டும். Workers ஒத்துழைத்து சரியான தகவல்களை வழங்க வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'Initial Notification, Scene Preservation, Photographs, Witness Statements, Documents, Root Cause Analysis, Corrective Actions மற்றும் Close-out Verification.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'Incident-ஐ புகாரளிக்காதது, ஆதாரங்களை மாற்றுதல், Investigation இல்லாமல் ஒருவரைக் குற்றம் சாட்டுதல் அல்லது Corrective Actions செயல்படுத்தாதது சம்பவம் மீண்டும் ஏற்பட வழிவகுக்கும்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'குற்றம் சாட்டுவதற்குப் பதிலாக உண்மைகள் மற்றும் System Failures மீது கவனம் செலுத்துங்கள். சரியான Root Cause Methods பயன்படுத்தி Corrective Actions பயனுள்ளதாக உள்ளதா என்பதை சரிபார்க்கவும்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'Company Incident Reporting Procedure, பொருந்தக்கூடிய UAE Requirements மற்றும் Approved HSE Investigation Procedures.',
      },

      // =========================
      // J - Job Safety Analysis
      // =========================
      {
        'letter': 'J',
        'title': 'Job Safety Analysis (JSA)',
        'desc': 'Identifying hazards and controls before starting a job.',

        'English_title': 'Job Safety Analysis (JSA)',
        'English_what': 'What is JSA?',
        'English_whatText': 'Job Safety Analysis is a systematic method of breaking a job into steps, identifying hazards and defining controls before work starts.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To prevent incidents by identifying hazards and implementing effective controls before work begins.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Identify job steps, hazards, persons at risk and control measures. Communicate the JSA to the work team and review it when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Supervisors shall prepare or verify the JSA. Workers shall understand and follow controls. HSE personnel shall provide guidance and monitoring where required.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Job steps, hazards, risk level, hierarchy of controls, PPE, permits, tools, competency, emergency arrangements and worker briefing.',
        'English_violations': 'Violations',
        'English_violationsText': 'Starting work without an appropriate JSA, ignoring identified controls or continuing work after significant changes without review can create unacceptable risk.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Involve workers in the JSA, use the hierarchy of controls, keep the document task-specific and review it whenever the work method or conditions change.',
        'English_reference': 'Reference',
        'English_referenceText': 'Company JSA procedure, approved risk assessment methodology and applicable UAE HSE requirements.',

        'Hindi_title': 'Job Safety Analysis (JSA)',
        'Hindi_what': 'JSA क्या है?',
        'Hindi_whatText': 'Job Safety Analysis एक व्यवस्थित तरीका है जिसमें काम को चरणों में बाँटकर खतरों की पहचान और काम शुरू होने से पहले नियंत्रण उपाय निर्धारित किए जाते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'काम शुरू होने से पहले खतरों की पहचान और प्रभावी नियंत्रण लागू करके घटनाओं को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'कार्य चरण, खतरे, जोखिम वाले व्यक्ति और नियंत्रण उपायों की पहचान करें। JSA को टीम के साथ समझाएँ और परिस्थितियाँ बदलने पर इसकी समीक्षा करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'सुपरवाइजर JSA तैयार या सत्यापित करें। कर्मचारी नियंत्रण उपायों को समझें और उनका पालन करें। HSE कर्मचारी आवश्यकतानुसार मार्गदर्शन और निगरानी दें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'कार्य चरण, खतरे, Risk Level, Hierarchy of Controls, PPE, Permits, Tools, Competency, Emergency Arrangements और Worker Briefing.',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'उचित JSA के बिना काम शुरू करना, पहचाने गए नियंत्रणों को नजरअंदाज करना या परिस्थितियाँ बदलने के बाद JSA की समीक्षा न करना गंभीर जोखिम पैदा कर सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'JSA में कर्मचारियों को शामिल करें, Hierarchy of Controls का उपयोग करें और काम की विधि या परिस्थितियाँ बदलने पर JSA की समीक्षा करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'Company JSA Procedure, Approved Risk Assessment Methodology और लागू UAE HSE Requirements.',

        'Malayalam_title': 'Job Safety Analysis (JSA)',
        'Malayalam_what': 'JSA എന്താണ്?',
        'Malayalam_whatText': 'ഒരു ജോലി വിവിധ ഘട്ടങ്ങളായി വിഭജിച്ച് ഓരോ ഘട്ടത്തിലുമുള്ള അപകടസാധ്യതകൾ തിരിച്ചറിയുകയും ജോലി തുടങ്ങുന്നതിന് മുമ്പ് നിയന്ത്രണ നടപടികൾ നിർണ്ണയിക്കുകയും ചെയ്യുന്ന ക്രമബദ്ധമായ രീതിയാണ് Job Safety Analysis.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'ജോലി ആരംഭിക്കുന്നതിന് മുമ്പ് അപകടസാധ്യതകൾ തിരിച്ചറിഞ്ഞ് ഫലപ്രദമായ നിയന്ത്രണങ്ങൾ നടപ്പാക്കി Incident തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'Job Steps, Hazards, Persons at Risk, Control Measures എന്നിവ തിരിച്ചറിയണം. JSA Work Team-ന് വിശദീകരിക്കുകയും Conditions മാറുമ്പോൾ Review ചെയ്യുകയും വേണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Supervisors JSA തയ്യാറാക്കുകയോ Verify ചെയ്യുകയോ വേണം. Workers Controls മനസ്സിലാക്കി പാലിക്കണം. HSE Personnel ആവശ്യമായ Guidance, Monitoring നൽകണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'Job Steps, Hazards, Risk Level, Hierarchy of Controls, PPE, Permits, Tools, Competency, Emergency Arrangements, Worker Briefing.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'ശരിയായ JSA ഇല്ലാതെ ജോലി തുടങ്ങുക, തിരിച്ചറിഞ്ഞ Controls അവഗണിക്കുക, Conditions മാറിയിട്ടും JSA Review ചെയ്യാതിരിക്കുക എന്നിവ ഗുരുതര അപകടസാധ്യത സൃഷ്ടിക്കും.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'JSA തയ്യാറാക്കുമ്പോൾ Workers-നെ ഉൾപ്പെടുത്തുക, Hierarchy of Controls ഉപയോഗിക്കുക, Work Method അല്ലെങ്കിൽ Conditions മാറുമ്പോൾ JSA Review ചെയ്യുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'Company JSA Procedure, Approved Risk Assessment Methodology, Applicable UAE HSE Requirements.',

        'Tamil_title': 'Job Safety Analysis (JSA)',
        'Tamil_what': 'JSA என்றால் என்ன?',
        'Tamil_whatText': 'ஒரு பணியை படிகளாகப் பிரித்து ஒவ்வொரு படியிலும் உள்ள அபாயங்களை கண்டறிந்து, வேலை தொடங்குவதற்கு முன் கட்டுப்பாட்டு நடவடிக்கைகளை நிர்ணயிக்கும் முறையே Job Safety Analysis ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'வேலை தொடங்குவதற்கு முன் அபாயங்களை கண்டறிந்து பயனுள்ள கட்டுப்பாடுகளை செயல்படுத்தி Incident-களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'Job Steps, Hazards, Persons at Risk மற்றும் Control Measures-ஐ கண்டறிய வேண்டும். JSA-வை Work Team-க்கு விளக்கி Conditions மாறும்போது Review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Supervisors JSA-வை தயாரிக்க அல்லது Verify செய்ய வேண்டும். Workers Controls-ஐ புரிந்து பின்பற்ற வேண்டும். HSE Personnel தேவையான Guidance மற்றும் Monitoring வழங்க வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'Job Steps, Hazards, Risk Level, Hierarchy of Controls, PPE, Permits, Tools, Competency, Emergency Arrangements மற்றும் Worker Briefing.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'சரியான JSA இல்லாமல் வேலை தொடங்குதல், கண்டறியப்பட்ட Controls-ஐ புறக்கணித்தல் அல்லது Conditions மாறிய பிறகு JSA Review செய்யாதது கடுமையான ஆபத்தை உருவாக்கும்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'JSA-வில் Workers-ஐ ஈடுபடுத்துங்கள், Hierarchy of Controls பயன்படுத்துங்கள் மற்றும் Work Method அல்லது Conditions மாறும்போது JSA-வை Review செய்யுங்கள்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'Company JSA Procedure, Approved Risk Assessment Methodology மற்றும் Applicable UAE HSE Requirements.',
      },

      // =========================
      // K - Key Performance Indicators
      // =========================
      {
        'letter': 'K',
        'title': 'Key Performance Indicators (KPI)',
        'desc': 'Measures used to evaluate safety performance.',

        'English_title': 'Key Performance Indicators (KPI)',
        'English_what': 'What are HSE KPIs?',
        'English_whatText': 'HSE Key Performance Indicators are measurable values used to monitor and evaluate an organisation’s health and safety performance.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To measure safety performance, identify trends, evaluate controls and support continuous improvement.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Define relevant leading and lagging indicators, collect reliable data, review trends and take corrective action when performance is below target.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'Management shall establish objectives. HSE teams shall collect and analyse data. Supervisors shall support reporting and improvement actions.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Incident rates, near-miss reports, inspections, training completion, corrective-action closure, audits, observations and safety meetings.',
        'English_violations': 'Violations',
        'English_violationsText': 'Manipulating data, under-reporting incidents, failing to review trends or ignoring repeated negative indicators can weaken the HSE management system.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Use both leading and lagging indicators. Focus on meaningful trends and use KPI results to drive preventive action rather than only measuring numbers.',
        'English_reference': 'Reference',
        'English_referenceText': 'Company HSE KPI procedure, approved performance-monitoring system and applicable ISO 45001 requirements where adopted.',

        'Hindi_title': 'Key Performance Indicators (KPI)',
        'Hindi_what': 'HSE KPI क्या हैं?',
        'Hindi_whatText': 'HSE Key Performance Indicators ऐसे मापने योग्य मान हैं जिनका उपयोग संगठन के स्वास्थ्य और सुरक्षा प्रदर्शन की निगरानी और मूल्यांकन के लिए किया जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'सुरक्षा प्रदर्शन को मापना, रुझानों की पहचान करना, नियंत्रणों का मूल्यांकन करना और निरंतर सुधार करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'उपयुक्त Leading और Lagging Indicators निर्धारित करें, विश्वसनीय डेटा एकत्र करें, Trends की समीक्षा करें और लक्ष्य से कम प्रदर्शन होने पर Corrective Action लें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'प्रबंधन Objectives निर्धारित करे। HSE Team डेटा एकत्र और विश्लेषण करे। Supervisors Reporting और Improvement Actions में सहयोग करें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'Incident Rates, Near Miss Reports, Inspections, Training Completion, Corrective Action Closure, Audits, Observations और Safety Meetings.',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'डेटा में हेरफेर, घटनाओं की कम रिपोर्टिंग, Trends की समीक्षा न करना या लगातार खराब Indicators को नजरअंदाज करना HSE System को कमजोर कर सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'Leading और Lagging दोनों Indicators का उपयोग करें। केवल संख्या मापने के बजाय Trends पर ध्यान देकर Preventive Actions लागू करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'Company HSE KPI Procedure, Approved Performance Monitoring System और जहाँ लागू हो ISO 45001 Requirements.',

        'Malayalam_title': 'Key Performance Indicators (KPI)',
        'Malayalam_what': 'HSE KPI എന്താണ്?',
        'Malayalam_whatText': 'ഒരു സ്ഥാപനത്തിന്റെ Health & Safety Performance നിരീക്ഷിക്കാനും വിലയിരുത്താനും ഉപയോഗിക്കുന്ന അളക്കാവുന്ന സൂചകങ്ങളാണ് HSE Key Performance Indicators.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'Safety Performance അളക്കുക, Trends കണ്ടെത്തുക, Controls വിലയിരുത്തുക, Continuous Improvement പിന്തുണയ്ക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'പ്രസക്തമായ Leading, Lagging Indicators നിർണ്ണയിക്കുക, വിശ്വസനീയമായ Data ശേഖരിക്കുക, Trends Review ചെയ്യുക, Target-നേക്കാൾ Performance കുറവാണെങ്കിൽ Corrective Action എടുക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Management Objectives നിശ്ചയിക്കണം. HSE Team Data ശേഖരിക്കുകയും Analyse ചെയ്യുകയും വേണം. Supervisors Reporting, Improvement Actions എന്നിവയിൽ സഹായിക്കണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'Incident Rates, Near Miss Reports, Inspections, Training Completion, Corrective Action Closure, Audits, Observations, Safety Meetings.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'Data Manipulation, Incident Under-reporting, Trends Review ചെയ്യാതിരിക്കൽ, തുടർച്ചയായ Negative Indicators അവഗണിക്കൽ എന്നിവ HSE Management System ദുർബലമാക്കാം.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'Leading, Lagging Indicators രണ്ടും ഉപയോഗിക്കുക. Numbers മാത്രം നോക്കാതെ Meaningful Trends കണ്ടെത്തി Preventive Actions നടപ്പാക്കുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'Company HSE KPI Procedure, Approved Performance Monitoring System, ബാധകമായിടത്ത് ISO 45001 Requirements.',

        'Tamil_title': 'Key Performance Indicators (KPI)',
        'Tamil_what': 'HSE KPI என்றால் என்ன?',
        'Tamil_whatText': 'ஒரு நிறுவனத்தின் Health & Safety Performance-ஐ கண்காணித்து மதிப்பிட பயன்படுத்தப்படும் அளவிடக்கூடிய குறியீடுகளே HSE Key Performance Indicators ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'Safety Performance-ஐ அளவிடுதல், Trends கண்டறிதல், Controls-ஐ மதிப்பிடுதல் மற்றும் Continuous Improvement-ஐ ஆதரித்தல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'பொருத்தமான Leading மற்றும் Lagging Indicators நிர்ணயித்தல், நம்பகமான Data சேகரித்தல், Trends Review செய்தல் மற்றும் Target-க்கு குறைவாக இருந்தால் Corrective Action எடுப்பது.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Management Objectives நிர்ணயிக்க வேண்டும். HSE Team Data சேகரித்து Analyse செய்ய வேண்டும். Supervisors Reporting மற்றும் Improvement Actions-க்கு ஆதரவு வழங்க வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'Incident Rates, Near Miss Reports, Inspections, Training Completion, Corrective Action Closure, Audits, Observations மற்றும் Safety Meetings.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'Data Manipulation, Incident Under-reporting, Trends Review செய்யாதது மற்றும் Negative Indicators-ஐப் புறக்கணிப்பது HSE Management System-ஐ பலவீனப்படுத்தும்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'Leading மற்றும் Lagging Indicators இரண்டையும் பயன்படுத்துங்கள். Numbers மட்டும் அல்லாமல் Meaningful Trends மீது கவனம் செலுத்தி Preventive Actions செயல்படுத்துங்கள்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'Company HSE KPI Procedure, Approved Performance Monitoring System மற்றும் பொருந்தும் இடங்களில் ISO 45001 Requirements.',
      },

      // =========================
      // L - Lifting Operations
      // =========================
      {
        'letter': 'L',
        'title': 'Lifting Operations',
        'desc': 'Safety requirements for cranes and lifting operations.',

        'English_title': 'Lifting Operations',
        'English_what': 'What are Lifting Operations?',
        'English_whatText': 'Lifting operations involve the planned movement of loads using cranes, hoists or other lifting equipment and require competent people and suitable controls.',
        'English_purpose': 'Purpose',
        'English_purposeText': 'To prevent dropped loads, equipment failure, struck-by incidents, overturning and other lifting-related accidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText': 'Use suitable and inspected lifting equipment, competent operators and riggers, approved lifting plans where required, correct lifting accessories and a controlled lifting area.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText': 'The lifting team shall follow the approved plan and communicate effectively. Operators, riggers, signalers and supervisors shall perform only within their competence and authorization.',
        'English_checklist': 'Checklist',
        'English_checklistText': 'Lifting plan, equipment inspection, load weight, SWL/WLL, lifting accessories, ground condition, exclusion zone, weather, communication and competent personnel.',
        'English_violations': 'Violations',
        'English_violationsText': 'Overloading, using damaged accessories, lifting over people, poor rigging, unauthorized operation or failure to establish an exclusion zone can cause serious or fatal incidents.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText': 'Plan every lift according to its risk, inspect equipment before use, use trained personnel, establish an exclusion zone and stop the lift if conditions become unsafe.',
        'English_reference': 'Reference',
        'English_referenceText': 'Applicable UAE lifting requirements, manufacturer instructions, approved lifting procedures and recognised lifting-equipment standards.',

        'Hindi_title': 'Lifting Operations',
        'Hindi_what': 'Lifting Operations क्या हैं?',
        'Hindi_whatText': 'Lifting Operations में Crane, Hoist या अन्य Lifting Equipment की सहायता से भार को योजनाबद्ध तरीके से उठाना और स्थानांतरित करना शामिल है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'गिरते हुए भार, उपकरण विफलता, Struck-by घटनाएँ, Crane overturning और अन्य Lifting Accidents को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText': 'उपयुक्त और निरीक्षित Lifting Equipment, Competent Operators और Riggers, आवश्यकतानुसार Approved Lifting Plan, सही Lifting Accessories और Controlled Lifting Area का उपयोग करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText': 'Lifting Team Approved Plan का पालन करे और प्रभावी Communication बनाए रखे। Operators, Riggers, Signalers और Supervisors केवल अपनी Competence और Authorization के अनुसार काम करें।',
        'Hindi_checklist': 'चेकलिस्ट',
        'Hindi_checklistText': 'Lifting Plan, Equipment Inspection, Load Weight, SWL/WLL, Lifting Accessories, Ground Condition, Exclusion Zone, Weather, Communication और Competent Personnel.',
        'Hindi_violations': 'उल्लंघन',
        'Hindi_violationsText': 'Overloading, खराब Accessories का उपयोग, लोगों के ऊपर Load उठाना, गलत Rigging, Unauthorized Operation या Exclusion Zone न बनाना गंभीर या घातक दुर्घटना का कारण बन सकता है।',
        'Hindi_bestPractice': 'सर्वोत्तम अभ्यास',
        'Hindi_bestPracticeText': 'हर Lift को उसके Risk के अनुसार Plan करें, उपयोग से पहले Equipment Inspect करें, Trained Personnel का उपयोग करें और असुरक्षित स्थिति में Lift रोक दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText': 'लागू UAE Lifting Requirements, Manufacturer Instructions, Approved Lifting Procedures और मान्यता प्राप्त Lifting Equipment Standards.',

        'Malayalam_title': 'Lifting Operations',
        'Malayalam_what': 'Lifting Operations എന്താണ്?',
        'Malayalam_whatText': 'Crane, Hoist അല്ലെങ്കിൽ മറ്റ് Lifting Equipment ഉപയോഗിച്ച് ഭാരങ്ങൾ പ്ലാൻ ചെയ്ത് ഉയർത്തുകയും മാറ്റുകയും ചെയ്യുന്ന പ്രവർത്തനങ്ങളാണ് Lifting Operations.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText': 'Dropped Load, Equipment Failure, Struck-by Incident, Crane Overturning തുടങ്ങിയ അപകടങ്ങൾ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText': 'യോഗ്യവും Inspected ആയ Lifting Equipment, Competent Operators/Riggers, ആവശ്യമായിടത്ത് Approved Lifting Plan, ശരിയായ Lifting Accessories, Controlled Lifting Area എന്നിവ ഉപയോഗിക്കണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText': 'Lifting Team Approved Plan പാലിക്കുകയും നല്ല Communication ഉറപ്പാക്കുകയും വേണം. Operators, Riggers, Signalers, Supervisors എന്നിവർ അവരുടെ Competence, Authorization പരിധിയിൽ മാത്രം പ്രവർത്തിക്കണം.',
        'Malayalam_checklist': 'ചെക്ക്ലിസ്റ്റ്',
        'Malayalam_checklistText': 'Lifting Plan, Equipment Inspection, Load Weight, SWL/WLL, Lifting Accessories, Ground Condition, Exclusion Zone, Weather, Communication, Competent Personnel.',
        'Malayalam_violations': 'ലംഘനങ്ങൾ',
        'Malayalam_violationsText': 'Overloading, Damaged Accessories ഉപയോഗിക്കൽ, ആളുകളുടെ മുകളിൽ Load ഉയർത്തൽ, Poor Rigging, Unauthorized Operation, Exclusion Zone ഇല്ലാത്തത് എന്നിവ ഗുരുതരമോ മരണകാരണമോ ആയ അപകടങ്ങൾക്ക് കാരണമാകാം.',
        'Malayalam_bestPractice': 'മികച്ച പ്രവർത്തനരീതി',
        'Malayalam_bestPracticeText': 'ഓരോ Lift-ഉം Risk അനുസരിച്ച് Plan ചെയ്യുക, ഉപയോഗിക്കുന്നതിന് മുമ്പ് Equipment Inspect ചെയ്യുക, Trained Personnel ഉപയോഗിക്കുക, Conditions Unsafe ആകുമ്പോൾ Lift നിർത്തുക.',
        'Malayalam_reference': 'റഫറൻസ്',
        'Malayalam_referenceText': 'ബാധകമായ UAE Lifting Requirements, Manufacturer Instructions, Approved Lifting Procedures, Recognised Lifting Equipment Standards.',

        'Tamil_title': 'Lifting Operations',
        'Tamil_what': 'Lifting Operations என்றால் என்ன?',
        'Tamil_whatText': 'Crane, Hoist அல்லது பிற Lifting Equipment பயன்படுத்தி சுமைகளை திட்டமிட்டு தூக்கி நகர்த்தும் பணிகளே Lifting Operations ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText': 'Dropped Load, Equipment Failure, Struck-by Incident, Crane Overturning மற்றும் பிற Lifting Accidents-ஐத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText': 'பொருத்தமான மற்றும் ஆய்வு செய்யப்பட்ட Lifting Equipment, Competent Operators/Riggers, தேவையான இடங்களில் Approved Lifting Plan, சரியான Lifting Accessories மற்றும் Controlled Lifting Area பயன்படுத்த வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText': 'Lifting Team Approved Plan-ஐ பின்பற்றி சரியான Communication உறுதி செய்ய வேண்டும். Operators, Riggers, Signalers மற்றும் Supervisors தங்கள் Competence மற்றும் Authorization வரம்புக்குள் மட்டுமே செயல்பட வேண்டும்.',
        'Tamil_checklist': 'சரிபார்ப்பு பட்டியல்',
        'Tamil_checklistText': 'Lifting Plan, Equipment Inspection, Load Weight, SWL/WLL, Lifting Accessories, Ground Condition, Exclusion Zone, Weather, Communication மற்றும் Competent Personnel.',
        'Tamil_violations': 'மீறல்கள்',
        'Tamil_violationsText': 'Overloading, Damaged Accessories பயன்படுத்துதல், மனிதர்களுக்கு மேல் Load தூக்குதல், Poor Rigging, Unauthorized Operation அல்லது Exclusion Zone அமைக்காதது கடுமையான அல்லது உயிரிழப்பு விபத்துகளை ஏற்படுத்தலாம்.',
        'Tamil_bestPractice': 'சிறந்த நடைமுறை',
        'Tamil_bestPracticeText': 'ஒவ்வொரு Lift-ஐயும் Risk அடிப்படையில் Plan செய்யுங்கள், பயன்படுத்துவதற்கு முன் Equipment Inspect செய்யுங்கள், Trained Personnel பயன்படுத்துங்கள் மற்றும் நிலைமை பாதுகாப்பற்றதாக இருந்தால் Lift-ஐ நிறுத்துங்கள்.',
        'Tamil_reference': 'குறிப்பு',
        'Tamil_referenceText': 'பொருந்தக்கூடிய UAE Lifting Requirements, Manufacturer Instructions, Approved Lifting Procedures மற்றும் Recognised Lifting Equipment Standards.',
      },
            'Applicable UAE Civil Defence/fire safety requirements, local authority requirements, company fire safety procedures and relevant ADOSH-SF requirements.',

        'Hindi_title': 'Fire Safety & Prevention',
        'Hindi_what': 'Fire Safety क्या है?',
        'Hindi_whatText':
            'Fire Safety में आग को रोकना, आग का जल्दी पता लगाना, लोगों और संपत्ति की सुरक्षा तथा सुरक्षित emergency response शामिल है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'आग की घटनाओं को रोकना, आग के फैलाव को सीमित करना और लोगों की सुरक्षा करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Ignition sources और combustible materials को नियंत्रित करें, suitable extinguishers रखें, exits clear रखें और hot work के लिए आवश्यक controls/permit लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management fire protection उपलब्ध कराए। Supervisors fire hazards और hot work control करें। Workers fire procedures का पालन करें।',
        'Hindi_checklist': 'Fire Safety Checklist',
        'Hindi_checklistText':
            'Extinguishers, exits, alarms, combustible materials, electrical equipment, hot-work controls और emergency contacts की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Blocked exits, inaccessible extinguishers, uncontrolled ignition sources, poor housekeeping और unsafe electrical connections।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Good housekeeping रखें, fire equipment inspect करें, ignition sources को combustibles से अलग रखें और proper hot-work control लागू करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू UAE Civil Defence/fire safety requirements, local authority requirements, company fire procedures और ADOSH-SF requirements।',

        'Malayalam_title': 'Fire Safety & Prevention',
        'Malayalam_what': 'Fire Safety എന്താണ്?',
        'Malayalam_whatText':
            'തീ ഉണ്ടാകുന്നത് തടയുക, തീ നേരത്തെ കണ്ടെത്തുക, ആളുകളെയും property-യെയും സംരക്ഷിക്കുക, സുരക്ഷിതമായ emergency response ഉറപ്പാക്കുക എന്നിവയാണ് Fire Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'തീപിടിത്തം തടയുക, തീ പടരുന്നത് നിയന്ത്രിക്കുക, workers, visitors, assets എന്നിവ സംരക്ഷിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Ignition sources, combustible materials നിയന്ത്രിക്കുക, fire extinguishers/fire systems maintain ചെയ്യുക, exits clear ആക്കുക, hot work controls/permit ആവശ്യമായിടത്ത് നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management fire protection arrangements നൽകണം. Supervisors fire hazards, hot work നിയന്ത്രിക്കണം. Workers fire procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Fire Safety Checklist',
        'Malayalam_checklistText':
            'Fire extinguisher access, emergency exits, fire alarm, combustible materials, electrical safety, hot-work controls, emergency contacts എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Exit block ചെയ്യൽ, extinguisher access ഇല്ലായ്മ, uncontrolled ignition source, poor housekeeping, unsafe electrical connection, required hot-work controls ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Good housekeeping maintain ചെയ്യുക, fire equipment inspect ചെയ്യുക, ignition sources combustibles-ൽ നിന്ന് വേർതിരിക്കുക, proper hot-work control system ഉപയോഗിക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE Civil Defence/fire safety requirements, local authority requirements, Company Fire Safety Procedures, ADOSH-SF requirements.',

        'Tamil_title': 'Fire Safety & Prevention',
        'Tamil_what': 'Fire Safety என்றால் என்ன?',
        'Tamil_whatText':
            'தீ ஏற்படுவதைத் தடுப்பது, தீயை ஆரம்பத்திலேயே கண்டறிதல், மக்கள் மற்றும் சொத்துக்களைப் பாதுகாத்தல் மற்றும் பாதுகாப்பான emergency response ஆகியவை Fire Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'தீ விபத்துகளைத் தடுப்பது, தீ பரவலைக் கட்டுப்படுத்துவது மற்றும் workers/visitors/assets-ஐ பாதுகாப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Ignition sources மற்றும் combustible materials-ஐ கட்டுப்படுத்தவும், fire extinguishers/fire systems பராமரிக்கவும், exits clear வைத்திருக்கவும், hot work controls/permit தேவையான இடங்களில் பயன்படுத்தவும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management fire protection ஏற்பாடுகளை வழங்க வேண்டும். Supervisors fire hazards மற்றும் hot work-ஐ கட்டுப்படுத்த வேண்டும். Workers fire procedures-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Fire Safety Checklist',
        'Tamil_checklistText':
            'Fire extinguishers, exits, alarms, combustible materials, electrical safety, hot-work controls மற்றும் emergency contacts ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Exits block செய்தல், extinguishers access இல்லாமை, uncontrolled ignition sources, poor housekeeping மற்றும் unsafe electrical connections.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Good housekeeping பராமரிக்கவும், fire equipment inspect செய்யவும், ignition sources-ஐ combustibles-இலிருந்து பிரிக்கவும், proper hot-work control பயன்படுத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE Civil Defence/fire safety requirements, local authority requirements, Company Fire Safety Procedures மற்றும் ADOSH-SF requirements.',
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
    final Map<String, String> detailGuideline =
        Map<String, String>.from(item);

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
