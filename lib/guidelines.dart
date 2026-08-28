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
