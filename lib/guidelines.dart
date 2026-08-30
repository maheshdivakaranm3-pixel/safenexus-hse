import 'package:flutter/material.dart';
import 'guideline_detail_page.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({Key? key}) : super(key: key);

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  String _language = 'English';

  final Map<String, List<Map<String, dynamic>>> guidelines = {
    'English': [
      {
        'letter': 'A',
        'title': 'ADOSH (Abu Dhabi OSH)',
        'desc':
            'Abu Dhabi Occupational Safety and Health System Framework and workplace safety requirements.',
        'English_title': 'ADOSH (Abu Dhabi OSH)',
        'English_what': 'What is ADOSH?',
        'English_whatText':
            'ADOSH-SF is the Abu Dhabi Occupational Safety and Health System Framework. It provides a structured framework for managing occupational safety and health risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent workplace injuries, occupational illness and unsafe conditions by identifying hazards, assessing risks and implementing effective controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Organizations must identify applicable OSH requirements, establish policies and procedures, assess workplace risks, provide competent resources, implement controls and maintain required records.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and leadership. Supervisors implement safe work practices. Workers follow procedures, use required PPE and report hazards.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'OSH policy, risk assessment, training, competency, PPE, emergency arrangements, inspections, incident reporting and corrective actions.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without required controls, inadequate risk assessment, lack of PPE or training, poor housekeeping and failure to report incidents.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use proactive risk management, conduct regular inspections, involve workers and close corrective actions promptly.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Abu Dhabi Public Health Centre (ADPHC), ADOSH-SF and applicable Codes of Practice.',

        'Hindi_title': 'ADOSH (Abu Dhabi OSH)',
        'Hindi_what': 'ADOSH क्या है?',
        'Hindi_whatText':
            'ADOSH-SF अबू धाबी का Occupational Safety and Health System Framework है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'कार्यस्थल की चोटों, व्यावसायिक बीमारी और असुरक्षित परिस्थितियों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Risk Assessment, सुरक्षित प्रक्रियाएँ, प्रशिक्षण, PPE, Emergency Plan और Inspection लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources प्रदान करे। Supervisors सुरक्षित कार्य सुनिश्चित करें। Workers procedures का पालन करें।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'OSH policy, Risk Assessment, Training, PPE, Emergency Plan, Inspection और Incident Reporting जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'बिना controls काम करना, PPE की कमी, training की कमी और incidents report न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'नियमित inspection करें और corrective actions समय पर बंद करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'ADPHC, ADOSH-SF और लागू Codes of Practice।',

        'Malayalam_title': 'ADOSH (Abu Dhabi OSH)',
        'Malayalam_what': 'ADOSH എന്താണ്?',
        'Malayalam_whatText':
            'ADOSH-SF എന്നത് അബുദാബിയിലെ Occupational Safety and Health System Framework ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ജോലിസ്ഥലത്തെ അപകടങ്ങൾ, തൊഴിൽ സംബന്ധമായ അസുഖങ്ങൾ, unsafe conditions എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Risk Assessment, Safe Procedures, Training, PPE, Emergency Arrangements, Inspection എന്നിവ നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Supervisors safe work ഉറപ്പാക്കണം. Workers procedures പാലിക്കണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'OSH Policy, Risk Assessment, Training, PPE, Emergency Plan, Inspection, Incident Reporting എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Controls ഇല്ലാതെ ജോലി ചെയ്യൽ, PPE/Training കുറവ്, incidents report ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Regular inspection നടത്തുകയും corrective actions സമയത്ത് close ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ADPHC, ADOSH-SF, ബാധകമായ Codes of Practice.',

        'Tamil_title': 'ADOSH (Abu Dhabi OSH)',
        'Tamil_what': 'ADOSH என்றால் என்ன?',
        'Tamil_whatText':
            'ADOSH-SF என்பது அபுதாபியின் Occupational Safety and Health System Framework ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'பணியிட விபத்துகள், தொழில் சார்ந்த நோய்கள் மற்றும் பாதுகாப்பற்ற நிலைகளைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Risk Assessment, Training, PPE, Emergency Arrangements மற்றும் Inspection செயல்படுத்தப்பட வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management வளங்களை வழங்க வேண்டும். Supervisors பாதுகாப்பான வேலை முறைகளை உறுதி செய்ய வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'OSH Policy, Risk Assessment, Training, PPE, Emergency Plan மற்றும் Inspection ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Controls இல்லாமல் வேலை செய்தல், PPE இல்லாமை மற்றும் incidents report செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Regular Inspection செய்து corrective actions-ஐ நேரத்தில் close செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'ADPHC, ADOSH-SF மற்றும் பொருந்தும் Codes of Practice.',
      },
      {
        'letter': 'B',
        'title': 'Basic Safety Rules',
        'desc':
            'Essential workplace safety rules that every worker must follow.',
        'English_title': 'Basic Safety Rules',
        'English_what': 'What are Basic Safety Rules?',
        'English_whatText':
            'Basic safety rules are fundamental precautions that help workers perform tasks safely.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent injuries, unsafe acts, property damage and avoidable incidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Follow site procedures, use required PPE, maintain housekeeping, use tools correctly and report hazards.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Workers follow procedures. Supervisors monitor compliance. Management provides training and resources.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'PPE, housekeeping, access, tools, electrical safety, signage, emergency equipment and hazard reporting.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to wear PPE, blocked access, unsafe tool use, bypassing safety devices and ignoring warning signs.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Stop unsafe work when necessary, follow approved procedures and report hazards immediately.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and UAE legislation.',

        'Hindi_title': 'Basic Safety Rules',
        'Hindi_what': 'Basic Safety Rules क्या हैं?',
        'Hindi_whatText':
            'ये मूल सुरक्षा सावधानियाँ हैं जिनका पालन करके कर्मचारी सुरक्षित रूप से काम कर सकते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'चोटों और असुरक्षित कार्यों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Site procedures, PPE, housekeeping और hazard reporting का पालन करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Workers procedures का पालन करें और Supervisors compliance की निगरानी करें।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'PPE, housekeeping, access, tools, electrical safety और emergency equipment जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'PPE न पहनना, blocked access और safety devices bypass करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Unsafe work रोकें और hazards तुरंत report करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, ADOSH-SF requirements और UAE legislation।',

        'Malayalam_title': 'Basic Safety Rules',
        'Malayalam_what': 'Basic Safety Rules എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്ത് സുരക്ഷിതമായി ജോലി ചെയ്യാൻ ഓരോ തൊഴിലാളിയും പാലിക്കേണ്ട അടിസ്ഥാന സുരക്ഷാ നിയമങ്ങളാണ് Basic Safety Rules.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'പരിക്കുകൾ, unsafe acts, property damage, incidents എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Site procedures പാലിക്കുക, PPE ഉപയോഗിക്കുക, housekeeping maintain ചെയ്യുക, tools ശരിയായി ഉപയോഗിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Workers procedures പാലിക്കണം. Supervisors compliance പരിശോധിക്കണം. Management training നൽകണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'PPE, housekeeping, access, tools, electrical safety, signage, emergency equipment എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'PPE ഉപയോഗിക്കാത്തത്, access block ചെയ്യൽ, unsafe tools, safety devices bypass ചെയ്യൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Unsafe work stop ചെയ്യുക, approved procedures പാലിക്കുക, hazards report ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE Procedures, ADOSH-SF requirements, UAE legislation.',

        'Tamil_title': 'Basic Safety Rules',
        'Tamil_what': 'Basic Safety Rules என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிடத்தில் பாதுகாப்பாக வேலை செய்வதற்கான அடிப்படை பாதுகாப்பு விதிகள்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'காயங்கள் மற்றும் தவிர்க்கக்கூடிய சம்பவங்களைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Site procedures, PPE, housekeeping மற்றும் hazard reporting ஆகியவற்றைப் பின்பற்றவும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Workers நடைமுறைகளைப் பின்பற்ற வேண்டும். Supervisors compliance-ஐ கண்காணிக்க வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'PPE, housekeeping, access, tools, electrical safety மற்றும் emergency equipment சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'PPE பயன்படுத்தாதது, access block செய்தல் மற்றும் safety devices bypass செய்தல்.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Unsafe work-ஐ நிறுத்தி hazards-ஐ உடனடியாக report செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE Procedures, ADOSH-SF requirements மற்றும் UAE legislation.',
      },
      {
        'letter': 'C',
        'title': 'Dubai Code of Practice (CoP)',
        'desc':
            'Safety requirements and good practices applicable to workplace activities in Dubai.',
        'English_title': 'Dubai Code of Practice (CoP)',
        'English_what': 'What is a Code of Practice?',
        'English_whatText':
            'A Code of Practice provides practical requirements and guidance for managing specific workplace safety risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide consistent safety practices and controls for specific activities and hazards.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify applicable authority requirements, use current approved documents, implement risk controls and maintain records.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management and HSE personnel identify applicable requirements. Supervisors implement them at site level. Workers follow approved controls.',
        'English_checklist': 'HSE Checklist',
        'English_checklistText':
            'Applicable authority identified, current document available, risk assessment completed, controls implemented, workers briefed and inspections recorded.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Using outdated requirements, missing risk controls, inadequate worker briefing and poor documentation.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain a legal and regulatory register and verify document revisions regularly.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable Dubai authority requirements and current Codes of Practice.',

        'Hindi_title': 'Dubai Code of Practice (CoP)',
        'Hindi_what': 'Code of Practice क्या है?',
        'Hindi_whatText':
            'Code of Practice किसी विशेष सुरक्षा जोखिम या कार्य के लिए व्यावहारिक आवश्यकताएँ और मार्गदर्शन प्रदान करता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'विशिष्ट कार्यों और खतरों के लिए समान सुरक्षा नियंत्रण स्थापित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'लागू Authority requirements की पहचान करें और current documents का उपयोग करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management requirements पहचानता है। Supervisors site पर लागू करते हैं। Workers controls का पालन करते हैं।',
        'Hindi_checklist': 'HSE चेकलिस्ट',
        'Hindi_checklistText':
            'Authority, current document, risk assessment, controls, worker briefing और inspection records जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'पुराने requirements का उपयोग, inadequate controls और worker briefing की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Legal register बनाए रखें और document revisions verify करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू Dubai authority requirements और current Codes of Practice।',

        'Malayalam_title': 'Dubai Code of Practice (CoP)',
        'Malayalam_what': 'Code of Practice എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു പ്രത്യേക ജോലി അല്ലെങ്കിൽ safety hazard നിയന്ത്രിക്കുന്നതിനുള്ള practical requirements / guidance നൽകുന്ന രേഖയാണ് Code of Practice.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'പ്രത്യേക ജോലികൾക്കും hazards-നും സ്ഥിരതയുള്ള safety controls നൽകുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'ബാധകമായ authority requirements തിരിച്ചറിയുക, current documents ഉപയോഗിക്കുക, risk controls നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management/HSE team requirements തിരിച്ചറിയണം. Supervisors site-ൽ implement ചെയ്യണം. Workers controls പാലിക്കണം.',
        'Malayalam_checklist': 'HSE Checklist',
        'Malayalam_checklistText':
            'Authority, current document, Risk Assessment, controls, worker briefing, inspection records പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'പഴയ requirements ഉപയോഗിക്കൽ, risk controls ഇല്ലായ്മ, worker briefing ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Legal/Regulatory Register maintain ചെയ്യുകയും latest revision verify ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ Dubai Authority requirements, current Codes of Practice.',

        'Tamil_title': 'Dubai Code of Practice (CoP)',
        'Tamil_what': 'Code of Practice என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு குறிப்பிட்ட வேலை அல்லது பாதுகாப்பு அபாயத்தை நிர்வகிப்பதற்கான நடைமுறை தேவைகள் மற்றும் வழிகாட்டுதலை Code of Practice வழங்குகிறது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'குறிப்பிட்ட பணிகள் மற்றும் அபாயங்களுக்கு ஒரே மாதிரியான பாதுகாப்பு கட்டுப்பாடுகளை வழங்குதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'பொருந்தும் Authority requirements-ஐ கண்டறிந்து current documents பயன்படுத்த வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management requirements-ஐ கண்டறிய வேண்டும். Supervisors site-ல் செயல்படுத்த வேண்டும். Workers controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'HSE Checklist',
        'Tamil_checklistText':
            'Authority, current document, Risk Assessment, controls மற்றும் inspection records சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'பழைய requirements பயன்படுத்துதல், risk controls இல்லாமை மற்றும் worker briefing இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Legal/Regulatory Register பராமரித்து latest revision-ஐ verify செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் Dubai Authority requirements மற்றும் current Codes of Practice.',
      },
      {
        'letter': 'D',
        'title': 'Daily Toolbox Talk (TBT)',
        'desc': 'Daily safety briefing conducted before work starts.',
        'English_title': 'Daily Toolbox Talk (TBT)',
        'English_what': 'What is a Toolbox Talk?',
        'English_whatText':
            'A Toolbox Talk is a short safety briefing conducted before work to discuss the planned activity, hazards and controls.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure workers understand the day’s tasks, hazards, controls and expected safe behaviour.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Discuss the actual task, hazards and controls. Confirm worker understanding and record attendance.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisor or competent person leads the briefing. Workers participate and raise hazards or concerns.',
        'English_checklist': 'TBT Checklist',
        'English_checklistText':
            'Task discussed, hazards identified, controls explained, PPE confirmed, equipment checked and attendance recorded.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'TBT conducted only as a formality, poor attendance, no worker participation and missing records.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep the briefing task-specific and interactive. Use recent incidents and site observations.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE procedures, applicable ADOSH-SF requirements and site-specific risk assessments.',

        'Hindi_title': 'Daily Toolbox Talk (TBT)',
        'Hindi_what': 'Toolbox Talk क्या है?',
        'Hindi_whatText':
            'Toolbox Talk काम शुरू होने से पहले किया जाने वाला छोटा safety briefing है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText': 'Workers को कार्य, hazards और controls समझाना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Task, hazards, controls, PPE और emergency arrangements पर चर्चा करें और attendance record करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Supervisor briefing lead करे। Workers भाग लें और hazards report करें।',
        'Hindi_checklist': 'TBT चेकलिस्ट',
        'Hindi_checklistText':
            'Task, hazards, controls, PPE, equipment और attendance जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'केवल formality के लिए TBT करना और worker participation न होना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Briefing को task-specific और interactive रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE procedures, ADOSH-SF requirements और site risk assessments।',

        'Malayalam_title': 'Daily Toolbox Talk (TBT)',
        'Malayalam_what': 'Toolbox Talk എന്താണ്?',
        'Malayalam_whatText':
            'ജോലി തുടങ്ങുന്നതിന് മുമ്പ് task, hazards, controls, PPE എന്നിവ ചർച്ച ചെയ്യുന്ന ചെറിയ safety briefing ആണ് Toolbox Talk.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ദിവസത്തെ ജോലി, hazards, controls എന്നിവ തൊഴിലാളികൾക്ക് മനസ്സിലാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Actual task, hazards, controls, PPE, equipment എന്നിവ ചർച്ച ചെയ്യുകയും attendance record ചെയ്യുകയും വേണം.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Supervisor/competent person briefing നടത്തണം. Workers പങ്കെടുക്കുകയും hazards report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'TBT Checklist',
        'Malayalam_checklistText':
            'Task, hazards, controls, PPE, equipment, emergency arrangements, attendance പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Formality ആയി മാത്രം TBT നടത്തുക, worker participation ഇല്ലായ്മ, attendance record ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'TBT task-specific, interactive ആക്കുക. Recent incidents, site observations ഉപയോഗിക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE procedures, ADOSH-SF requirements, site-specific Risk Assessments.',

        'Tamil_title': 'Daily Toolbox Talk (TBT)',
        'Tamil_what': 'Toolbox Talk என்றால் என்ன?',
        'Tamil_whatText':
            'வேலை தொடங்குவதற்கு முன் task, hazards, controls மற்றும் PPE குறித்து நடத்தப்படும் குறுகிய safety briefing.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'அன்றைய வேலை, hazards மற்றும் controls குறித்து workers புரிந்துகொள்ளச் செய்வது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Task, hazards, controls, PPE பற்றி விவாதித்து attendance record செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Supervisor briefing நடத்த வேண்டும். Workers கலந்து கொண்டு hazards-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'TBT Checklist',
        'Tamil_checklistText':
            'Task, hazards, controls, PPE, equipment மற்றும் attendance சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Formality-க்காக மட்டும் TBT நடத்துதல் மற்றும் worker participation இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'TBT-ஐ task-specific மற்றும் interactive ஆக வைத்துக்கொள்ளவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE procedures, ADOSH-SF requirements மற்றும் site-specific Risk Assessments.',
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
            'Identify emergencies, establish procedures, provide alarms and communication, maintain emergency equipment, identify assembly points and conduct training and drills.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources. Emergency teams respond according to their roles. Workers follow alarms, evacuation instructions and assembly procedures.',
        'English_checklist': 'Emergency Checklist',
        'English_checklistText':
            'Emergency plan, alarm, contacts, evacuation routes, assembly point, fire equipment, first aid, emergency lighting and drill records.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Blocked emergency exits, unavailable extinguishers, unclear assembly points, outdated contacts and untrained personnel.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Review emergency plans regularly, conduct drills, investigate findings and close corrective actions.',
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
            'Emergency procedures, alarms, communication, equipment, assembly point और training/drills की व्यवस्था करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources प्रदान करे। Emergency team अपने roles के अनुसार response करे। Workers evacuation instructions का पालन करें।',
        'Hindi_checklist': 'Emergency Checklist',
        'Hindi_checklistText':
            'Emergency plan, alarm, contacts, evacuation route, assembly point, fire equipment, first aid और drill records की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Blocked exits, unavailable extinguishers, unclear assembly points और untrained workers।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Emergency plans की नियमित समीक्षा करें और drills के बाद corrective actions बंद करें।',
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
            'Emergency Plan, alarm, communication, emergency equipment, assembly point, training, drills എന്നിവ ഒരുക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Emergency team roles അനുസരിച്ച് പ്രവർത്തിക്കണം. Workers evacuation instructions പാലിക്കണം.',
        'Malayalam_checklist': 'Emergency Checklist',
        'Malayalam_checklistText':
            'Emergency Plan, alarm, contacts, evacuation routes, assembly point, fire equipment, first aid, emergency access, drill records പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Emergency exit block ചെയ്യൽ, extinguisher unavailable, assembly point വ്യക്തമല്ലാത്തത്, outdated contacts, training ഇല്ലായ്മ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Emergency Plan regular ആയി review ചെയ്യുക, drills നടത്തുക, corrective actions close ചെയ്യുക.',
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
            'Emergency procedures, alarms, communication, equipment, assembly point மற்றும் training/drills ஏற்பாடு செய்ய வேண்டும்.',
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
            'Control ignition sources and combustible materials, maintain suitable fire extinguishers and fire systems, keep exits clear and control hot work.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides fire protection arrangements. Supervisors control fire hazards and hot work. Workers follow fire procedures and report hazards.',
        'English_checklist': 'Fire Safety Checklist',
        'English_checklistText':
            'Fire extinguishers accessible, exits clear, alarm systems maintained, combustible materials controlled, electrical equipment safe and hot-work controls in place.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Blocked exits, inaccessible extinguishers, uncontrolled ignition sources, poor housekeeping and unsafe electrical connections.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Maintain good housekeeping, inspect fire equipment, separate ignition sources from combustibles and use proper hot-work controls.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE fire safety requirements, local authority requirements, company procedures and relevant ADOSH-SF requirements.',

        'Hindi_title': 'Fire Safety & Prevention',
        'Hindi_what': 'Fire Safety क्या है?',
        'Hindi_whatText':
            'Fire Safety आग को रोकने, जल्दी पहचानने और लोगों तथा संपत्ति की सुरक्षा करने की प्रक्रिया है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'आग की घटनाओं को रोकना और आग के फैलाव को सीमित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Fire extinguishers, fire systems, clear exits और hot-work controls बनाए रखें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management fire protection प्रदान करे। Supervisors hazards control करें। Workers fire procedures का पालन करें।',
        'Hindi_checklist': 'Fire Safety Checklist',
        'Hindi_checklistText':
            'Extinguishers, exits, alarms, electrical equipment, housekeeping और hot-work controls जाँचें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Blocked exits, unavailable extinguishers, unsafe electrical connections और poor housekeeping।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Fire equipment inspect करें और combustible materials को ignition sources से अलग रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू UAE fire safety requirements और company HSE procedures।',

        'Malayalam_title': 'Fire Safety & Prevention',
        'Malayalam_what': 'Fire Safety എന്താണ്?',
        'Malayalam_whatText':
            'തീ ഉണ്ടാകുന്നത് തടയുക, നേരത്തെ കണ്ടെത്തുക, ആളുകളെയും property-യെയും സംരക്ഷിക്കുക എന്നിവയാണ് Fire Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Fire incidents തടയുകയും തീ പടരുന്നത് നിയന്ത്രിക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Fire extinguishers, fire systems, clear exits, combustible material control, electrical safety, hot-work controls എന്നിവ ഉറപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management fire protection നൽകണം. Supervisors fire hazards നിയന്ത്രിക്കണം. Workers fire procedures പാലിക്കണം.',
        'Malayalam_checklist': 'Fire Safety Checklist',
        'Malayalam_checklistText':
            'Extinguishers, exits, alarms, electrical equipment, housekeeping, combustible materials, hot-work controls പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Blocked exits, extinguisher unavailable, unsafe electrical connections, poor housekeeping, uncontrolled hot work.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Fire equipment regular ആയി inspect ചെയ്യുക, ignition sources-നെ combustibles-ൽ നിന്ന് അകറ്റുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE fire safety requirements, local authority requirements, company HSE procedures.',

        'Tamil_title': 'Fire Safety & Prevention',
        'Tamil_what': 'Fire Safety என்றால் என்ன?',
        'Tamil_whatText':
            'தீயைத் தடுப்பது, ஆரம்பத்திலேயே கண்டறிவது மற்றும் மக்கள் மற்றும் சொத்துக்களைப் பாதுகாப்பது Fire Safety ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'தீ விபத்துகளைத் தடுப்பதும் தீ பரவலைக் கட்டுப்படுத்துவதும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Fire extinguishers, fire systems, clear exits மற்றும் hot-work controls ஆகியவற்றை உறுதி செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management fire protection வழங்க வேண்டும். Supervisors fire hazards-ஐ கட்டுப்படுத்த வேண்டும். Workers fire procedures-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Fire Safety Checklist',
        'Tamil_checklistText':
            'Extinguishers, exits, alarms, electrical equipment, housekeeping மற்றும் hot-work controls சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Blocked exits, extinguishers இல்லாமை, unsafe electrical connections மற்றும் poor housekeeping.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Fire equipment-ஐ தொடர்ந்து inspect செய்து ignition sources-ஐ combustibles-இலிருந்து பிரிக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE fire safety requirements மற்றும் company HSE procedures.',
      },
      {
        'letter': 'G',
        'title': 'Green Building Regulations',
        'desc':
            'Sustainable construction, environmental protection and resource conservation requirements.',
        'English_title': 'Green Building Regulations',
        'English_what': 'What are Green Building Regulations?',
        'English_whatText':
            'Green Building Regulations are requirements and practices that promote sustainable construction, energy efficiency, water conservation, responsible material use and environmental protection.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce environmental impact, conserve resources and improve building and workplace environmental performance.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Control waste, dust and pollution, conserve water and energy, use approved materials and follow project environmental procedures.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and procedures. Supervisors monitor implementation. Workers follow environmental controls and report pollution, spills and waste issues.',
        'English_checklist': 'Environmental Checklist',
        'English_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation, approved materials and environmental inspections.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution, unnecessary resource consumption and failure to follow environmental procedures.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan environmental controls before work, segregate waste at source, prevent pollution and maintain good housekeeping.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Applicable UAE environmental requirements, local authority requirements and approved project environmental procedures.',

        'Hindi_title': 'Green Building Regulations',
        'Hindi_what': 'Green Building Regulations क्या हैं?',
        'Hindi_whatText':
            'Green Building Regulations टिकाऊ निर्माण, ऊर्जा दक्षता, जल संरक्षण, उचित सामग्री उपयोग और पर्यावरण संरक्षण से संबंधित आवश्यकताएँ हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'पर्यावरणीय प्रभाव को कम करना, संसाधनों का संरक्षण करना और बेहतर पर्यावरणीय प्रदर्शन सुनिश्चित करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Waste, dust और pollution को नियंत्रित करें, water और energy बचाएँ तथा approved materials और environmental procedures का पालन करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources और procedures प्रदान करे। Supervisors implementation की निगरानी करें। Workers environmental controls का पालन करें।',
        'Hindi_checklist': 'Environmental Checklist',
        'Hindi_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation और environmental inspection की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'गलत waste disposal, uncontrolled dust, pollution, resource wastage और environmental procedures का पालन न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'काम शुरू करने से पहले environmental controls plan करें, waste को source पर segregate करें और pollution रोकें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'लागू UAE environmental requirements, local authority requirements और approved project environmental procedures।',

        'Malayalam_title': 'Green Building Regulations',
        'Malayalam_what': 'Green Building Regulations എന്താണ്?',
        'Malayalam_whatText':
            'Sustainable construction, energy efficiency, water conservation, responsible material use, environmental protection എന്നിവ ഉറപ്പാക്കുന്നതിനുള്ള requirements and practices ആണ് Green Building Regulations.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Environmental impact കുറയ്ക്കുക, resources സംരക്ഷിക്കുക, building-ന്റെ environmental performance മെച്ചപ്പെടുത്തുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Waste, dust, pollution എന്നിവ നിയന്ത്രിക്കുക, water/energy conserve ചെയ്യുക, approved materials ഉപയോഗിക്കുക, environmental procedures പാലിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Supervisors implementation monitor ചെയ്യണം. Workers environmental controls പാലിക്കുകയും pollution, spills, waste issues report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Environmental Checklist',
        'Malayalam_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation, approved materials, environmental inspection എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Improper waste disposal, uncontrolled dust, pollution, unnecessary resource consumption, environmental procedures പാലിക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Work തുടങ്ങുന്നതിന് മുമ്പ് environmental controls plan ചെയ്യുക, waste source-ൽ തന്നെ segregate ചെയ്യുക, pollution prevent ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'ബാധകമായ UAE environmental requirements, local authority requirements, approved project environmental procedures.',

        'Tamil_title': 'Green Building Regulations',
        'Tamil_what': 'Green Building Regulations என்றால் என்ன?',
        'Tamil_whatText':
            'நிலையான கட்டுமானம், ஆற்றல் திறன், நீர் பாதுகாப்பு, பொறுப்பான பொருள் பயன்பாடு மற்றும் சுற்றுச்சூழல் பாதுகாப்பை ஊக்குவிக்கும் விதிமுறைகள் Green Building Regulations ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'சுற்றுச்சூழல் பாதிப்பைக் குறைத்தல், வளங்களைப் பாதுகாத்தல் மற்றும் கட்டிடத்தின் சுற்றுச்சூழல் செயல்திறனை மேம்படுத்துதல்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Waste, dust மற்றும் pollution-ஐ கட்டுப்படுத்துதல், water மற்றும் energy-ஐ சேமித்தல், approved materials மற்றும் environmental procedures-ஐ பின்பற்றுதல்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources மற்றும் procedures வழங்க வேண்டும். Supervisors implementation-ஐ கண்காணிக்க வேண்டும். Workers environmental controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Environmental Checklist',
        'Tamil_checklistText':
            'Waste segregation, dust control, spill prevention, water conservation, energy conservation மற்றும் environmental inspection ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'தவறான waste disposal, uncontrolled dust, pollution, resource wastage மற்றும் environmental procedures பின்பற்றாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'வேலை தொடங்குவதற்கு முன் environmental controls திட்டமிட்டு, waste-ஐ source-ல் segregate செய்து pollution-ஐத் தடுக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'பொருந்தும் UAE environmental requirements, local authority requirements மற்றும் approved project environmental procedures.',
      },
      {
        'letter': 'H',
        'title': 'Hazard Identification & Risk Assessment',
        'desc':
            'Identification of hazards, assessment of risks and implementation of effective controls.',
        'English_title': 'Hazard Identification & Risk Assessment',
        'English_what': 'What is Hazard Identification & Risk Assessment?',
        'English_whatText':
            'It is the systematic process of identifying workplace hazards, assessing the associated risks and determining suitable control measures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent injuries, illness, property damage and environmental harm by controlling hazards before incidents occur.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, assess likelihood and severity, determine risk level, implement controls, communicate findings and review assessments when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources. Competent persons conduct assessments. Supervisors implement controls. Workers follow controls and report new hazards.',
        'English_checklist': 'Risk Assessment Checklist',
        'English_checklistText':
            'Hazards identified, affected persons identified, risk evaluated, controls selected, hierarchy of controls applied, workers briefed and assessment reviewed.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Generic or outdated risk assessments, missing hazards, ineffective controls, poor worker communication and failure to review assessments after changes.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use task-specific assessments, involve workers, apply the hierarchy of controls and review risks whenever work conditions change.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company risk-management procedures, applicable ADOSH-SF requirements and relevant UAE legislation.',

        'Hindi_title': 'Hazard Identification & Risk Assessment',
        'Hindi_what': 'Hazard Identification & Risk Assessment क्या है?',
        'Hindi_whatText':
            'कार्यस्थल के खतरों की पहचान, जोखिम का मूल्यांकन और उचित नियंत्रण उपाय निर्धारित करने की व्यवस्थित प्रक्रिया।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'घटनाओं से पहले hazards को नियंत्रित करके चोट, बीमारी और property damage को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazards की पहचान करें, likelihood और severity का मूल्यांकन करें, controls लागू करें और conditions बदलने पर assessment review करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources दे। Competent person assessment करे। Supervisors controls लागू करें। Workers controls का पालन करें।',
        'Hindi_checklist': 'Risk Assessment Checklist',
        'Hindi_checklistText':
            'Hazards, affected persons, risk level, controls, hierarchy of controls, worker briefing और review की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Outdated assessment, missing hazards, ineffective controls और workers को जानकारी न देना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Task-specific assessment करें, workers को शामिल करें और conditions बदलने पर risk assessment review करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company risk-management procedures, applicable ADOSH-SF requirements और relevant UAE legislation।',

        'Malayalam_title': 'Hazard Identification & Risk Assessment',
        'Malayalam_what': 'Hazard Identification & Risk Assessment എന്താണ്?',
        'Malayalam_whatText':
            'ജോലിസ്ഥലത്തെ hazards തിരിച്ചറിയുകയും അവയുടെ risks വിലയിരുത്തുകയും ആവശ്യമായ control measures നിശ്ചയിക്കുകയും ചെയ്യുന്ന systematic process ആണ് ഇത്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Incident ഉണ്ടാകുന്നതിന് മുമ്പ് hazards control ചെയ്ത് injuries, illness, property damage, environmental harm എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazards തിരിച്ചറിയുക, likelihood/severity assess ചെയ്യുക, risk level determine ചെയ്യുക, controls implement ചെയ്യുക, findings communicate ചെയ്യുക, conditions മാറുമ്പോൾ review ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Competent person assessment നടത്തണം. Supervisors controls implement ചെയ്യണം. Workers controls പാലിക്കുകയും പുതിയ hazards report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Risk Assessment Checklist',
        'Malayalam_checklistText':
            'Hazards, affected persons, risk level, controls, hierarchy of controls, worker briefing, review എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Generic/outdated Risk Assessment, hazards miss ചെയ്യൽ, ineffective controls, worker communication കുറവ്, changes വന്നിട്ടും assessment review ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Task-specific Risk Assessment ഉപയോഗിക്കുക, workers-നെ involve ചെയ്യുക, hierarchy of controls apply ചെയ്യുക, conditions മാറുമ്പോൾ review ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company Risk Management Procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation.',

        'Tamil_title': 'Hazard Identification & Risk Assessment',
        'Tamil_what': 'Hazard Identification & Risk Assessment என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட அபாயங்களை அடையாளம் கண்டு, அவற்றின் risk-ஐ மதிப்பீடு செய்து, பொருத்தமான control measures-ஐ நிர்ணயிக்கும் முறையான செயல்முறை.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'சம்பவங்கள் ஏற்படும் முன் hazards-ஐ கட்டுப்படுத்தி காயங்கள், நோய்கள் மற்றும் property damage-ஐத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazards-ஐ அடையாளம் கண்டு, likelihood மற்றும் severity-ஐ மதிப்பீடு செய்து, controls செயல்படுத்தி, conditions மாறும்போது assessment-ஐ review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources வழங்க வேண்டும். Competent person assessment நடத்த வேண்டும். Supervisors controls செயல்படுத்த வேண்டும். Workers controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'Risk Assessment Checklist',
        'Tamil_checklistText':
            'Hazards, affected persons, risk level, controls, hierarchy of controls மற்றும் worker briefing ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Outdated risk assessment, hazards தவறவிடுதல், ineffective controls மற்றும் worker communication இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Task-specific assessment பயன்படுத்தி, workers-ஐ ஈடுபடுத்தி, conditions மாறும்போது risk assessment-ஐ review செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company Risk Management Procedures, applicable ADOSH-SF requirements மற்றும் relevant UAE legislation.',
      },
      {
        'letter': 'I',
        'title': 'Incident Investigation',
        'desc':
            'Systematic investigation of incidents to identify causes and prevent recurrence.',
        'English_title': 'Incident Investigation',
        'English_what': 'What is Incident Investigation?',
        'English_whatText':
            'Incident investigation is a structured process used to determine what happened, why it happened and what corrective actions are required to prevent recurrence.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify immediate, underlying and root causes and prevent similar incidents from happening again.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Report the incident promptly, preserve relevant evidence, interview witnesses, identify causes, determine corrective actions and document the investigation.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management ensures proper investigation resources. Investigators collect facts objectively. Supervisors support corrective actions. Workers cooperate and provide accurate information.',
        'English_checklist': 'Investigation Checklist',
        'English_checklistText':
            'Incident reported, area secured, evidence preserved, witnesses interviewed, causes identified, corrective actions assigned and lessons communicated.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Delayed reporting, blaming individuals without root-cause analysis, poor evidence collection, incomplete investigation and overdue corrective actions.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Focus on system and root causes rather than blame. Track corrective actions to closure and share lessons learned with workers.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company incident reporting and investigation procedures, applicable ADOSH-SF requirements and UAE requirements.',

        'Hindi_title': 'Incident Investigation',
        'Hindi_what': 'Incident Investigation क्या है?',
        'Hindi_whatText':
            'किसी incident में क्या हुआ, क्यों हुआ और दोबारा होने से रोकने के लिए क्या corrective actions आवश्यक हैं, यह निर्धारित करने की व्यवस्थित प्रक्रिया।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Immediate, underlying और root causes की पहचान करना तथा recurrence को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Incident को तुरंत report करें, evidence सुरक्षित रखें, witnesses से जानकारी लें, causes identify करें और corrective actions document करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources प्रदान करे। Investigators facts collect करें। Supervisors corrective actions support करें। Workers सही जानकारी दें।',
        'Hindi_checklist': 'Investigation Checklist',
        'Hindi_checklistText':
            'Incident report, area secured, evidence, witness interviews, causes, corrective actions और lessons learned की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Late reporting, केवल व्यक्ति को blame करना, poor evidence collection और incomplete investigation।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Blame के बजाय root causes पर ध्यान दें और corrective actions को closure तक track करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company incident reporting procedures, applicable ADOSH-SF requirements और UAE requirements।',

        'Malayalam_title': 'Incident Investigation',
        'Malayalam_what': 'Incident Investigation എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു incident എന്താണ് സംഭവിച്ചത്, എന്തുകൊണ്ട് സംഭവിച്ചു, വീണ്ടും സംഭവിക്കാതിരിക്കാൻ എന്ത് corrective actions വേണം എന്നിവ കണ്ടെത്തുന്ന structured process ആണ് Incident Investigation.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Immediate, underlying, root causes കണ്ടെത്തുകയും similar incidents വീണ്ടും സംഭവിക്കുന്നത് തടയുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Incident ഉടൻ report ചെയ്യുക, evidence preserve ചെയ്യുക, witnesses interview ചെയ്യുക, causes identify ചെയ്യുക, corrective actions assign ചെയ്യുക, investigation document ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management investigation resources നൽകണം. Investigators facts objectively collect ചെയ്യണം. Supervisors corrective actions support ചെയ്യണം. Workers accurate information നൽകണം.',
        'Malayalam_checklist': 'Investigation Checklist',
        'Malayalam_checklistText':
            'Incident reported, area secured, evidence preserved, witnesses interviewed, causes identified, corrective actions assigned, lessons communicated എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Late reporting, വ്യക്തിയെ മാത്രം blame ചെയ്യൽ, evidence collection കുറവ്, incomplete investigation, overdue corrective actions.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Blame ചെയ്യുന്നതിന് പകരം system/root causes കണ്ടെത്തുക. Corrective actions closure വരെ track ചെയ്യുകയും lessons learned workers-ുമായി share ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company Incident Reporting and Investigation Procedures, ബാധകമായ ADOSH-SF requirements, UAE requirements.',

        'Tamil_title': 'Incident Investigation',
        'Tamil_what': 'Incident Investigation என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு incident என்ன நடந்தது, ஏன் நடந்தது மற்றும் மீண்டும் நடக்காமல் இருக்க என்ன corrective actions தேவை என்பதை கண்டறியும் முறையான செயல்முறை.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Immediate, underlying மற்றும் root causes-ஐ கண்டறிந்து மீண்டும் சம்பவம் நடைபெறாமல் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Incident-ஐ உடனடியாக report செய்து, evidence-ஐ பாதுகாத்து, witnesses-ஐ interview செய்து, causes மற்றும் corrective actions-ஐ document செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources வழங்க வேண்டும். Investigators facts-ஐ objective-ஆக சேகரிக்க வேண்டும். Supervisors corrective actions-ஐ support செய்ய வேண்டும்.',
        'Tamil_checklist': 'Investigation Checklist',
        'Tamil_checklistText':
            'Incident report, area secured, evidence, witness interviews, causes, corrective actions மற்றும் lessons learned ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Late reporting, individual-ஐ மட்டும் blame செய்தல், evidence collection குறைபாடு மற்றும் incomplete investigation.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Blame செய்வதற்கு பதிலாக system மற்றும் root causes-ல் கவனம் செலுத்தி corrective actions-ஐ closure வரை track செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company Incident Reporting and Investigation Procedures, applicable ADOSH-SF requirements மற்றும் UAE requirements.',
      },
      {
        'letter': 'J',
        'title': 'Job Safety Analysis',
        'desc':
            'Systematic identification of job hazards and implementation of suitable control measures before work starts.',
        'English_title': 'Job Safety Analysis',
        'English_what': 'What is Job Safety Analysis?',
        'English_whatText':
            'Job Safety Analysis (JSA) is a systematic process of breaking a job into steps, identifying hazards associated with each step and determining appropriate control measures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify and control hazards before work begins and reduce the likelihood of injuries, incidents and property damage.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Select the task, break it into logical steps, identify hazards for each step, assess the risks, establish controls, communicate the JSA and review it when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and ensures suitable procedures. Supervisors prepare and implement the JSA. Workers participate, understand the hazards and follow the identified controls.',
        'English_checklist': 'JSA Checklist',
        'English_checklistText':
            'Job steps identified, hazards identified, risks assessed, controls established, hierarchy of controls considered, workers briefed, PPE identified and JSA reviewed when conditions change.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Generic JSA, missing job steps, unidentified hazards, ineffective controls, failure to brief workers and using an outdated JSA after work conditions change.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Involve experienced workers in the JSA, identify hazards for every job step, apply the hierarchy of controls and conduct a toolbox talk before starting the task.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company JSA/JHA procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Job Safety Analysis',
        'Hindi_what': 'Job Safety Analysis क्या है?',
        'Hindi_whatText':
            'Job Safety Analysis (JSA) एक व्यवस्थित प्रक्रिया है जिसमें काम को अलग-अलग steps में बाँटकर प्रत्येक step से जुड़े hazards की पहचान की जाती है और उचित control measures निर्धारित किए जाते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'काम शुरू होने से पहले hazards की पहचान और नियंत्रण करके injuries, incidents और property damage की संभावना को कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Task को logical steps में बाँटें, प्रत्येक step के hazards identify करें, risks assess करें, controls establish करें, JSA workers को समझाएँ और conditions बदलने पर review करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources और procedures प्रदान करे। Supervisors JSA तैयार और लागू करें। Workers hazards को समझें, participate करें और controls का पालन करें।',
        'Hindi_checklist': 'JSA Checklist',
        'Hindi_checklistText':
            'Job steps, hazards, risk assessment, controls, hierarchy of controls, worker briefing, PPE और JSA review की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Generic JSA, job steps missing होना, hazards identify न करना, ineffective controls, workers को briefing न देना और conditions बदलने के बाद outdated JSA का उपयोग करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Experienced workers को JSA में शामिल करें, प्रत्येक job step के hazards identify करें, hierarchy of controls लागू करें और काम शुरू करने से पहले toolbox talk करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company JSA/JHA procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Job Safety Analysis',
        'Malayalam_what': 'Job Safety Analysis എന്താണ്?',
        'Malayalam_whatText':
            'Job Safety Analysis (JSA) എന്നത് ഒരു ജോലി ഓരോ ഘട്ടങ്ങളായി വിഭജിച്ച് ഓരോ ഘട്ടത്തിലുമുള്ള hazards തിരിച്ചറിയുകയും ആവശ്യമായ control measures നിശ്ചയിക്കുകയും ചെയ്യുന്ന systematic process ആണ്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Work ആരംഭിക്കുന്നതിന് മുമ്പ് hazards തിരിച്ചറിയുകയും control ചെയ്യുകയും ചെയ്ത് injuries, incidents, property damage എന്നിവയുടെ സാധ്യത കുറയ്ക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Task logical steps ആയി വിഭജിക്കുക, ഓരോ step-ലുമുള്ള hazards തിരിച്ചറിയുക, risks assess ചെയ്യുക, controls establish ചെയ്യുക, JSA workers-നെ brief ചെയ്യുക, conditions മാറുമ്പോൾ review ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources and procedures നൽകണം. Supervisors JSA prepare ചെയ്ത് implement ചെയ്യണം. Workers JSA-യിൽ participate ചെയ്യുകയും hazards മനസ്സിലാക്കി controls പാലിക്കുകയും വേണം.',
        'Malayalam_checklist': 'JSA Checklist',
        'Malayalam_checklistText':
            'Job steps, hazards, risk assessment, controls, hierarchy of controls, worker briefing, PPE, conditions change വന്നാൽ JSA review എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Generic JSA, job steps missing ആകുന്നത്, hazards identify ചെയ്യാത്തത്, ineffective controls, workers-ന് briefing നൽകാത്തത്, conditions മാറിയിട്ടും outdated JSA ഉപയോഗിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Experienced workers-നെ JSA-യിൽ involve ചെയ്യുക, ഓരോ job step-ലുമുള്ള hazards തിരിച്ചറിയുക, hierarchy of controls apply ചെയ്യുക, work തുടങ്ങുന്നതിന് മുമ്പ് toolbox talk നടത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company JSA/JHA Procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Job Safety Analysis',
        'Tamil_what': 'Job Safety Analysis என்றால் என்ன?',
        'Tamil_whatText':
            'Job Safety Analysis (JSA) என்பது ஒரு வேலையை ஒவ்வொரு படியாகப் பிரித்து, ஒவ்வொரு படியிலும் உள்ள hazards-ஐ அடையாளம் கண்டு, பொருத்தமான control measures-ஐ நிர்ணயிக்கும் முறையான செயல்முறை.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'வேலை தொடங்குவதற்கு முன் hazards-ஐ அடையாளம் கண்டு கட்டுப்படுத்தி, injuries, incidents மற்றும் property damage ஏற்படும் வாய்ப்பைக் குறைப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Task-ஐ logical steps-ஆகப் பிரித்து, ஒவ்வொரு step-ன் hazards-ஐ identify செய்து, risks-ஐ assess செய்து, controls-ஐ establish செய்து, JSA-ஐ workers-க்கு explain செய்து, conditions மாறும்போது review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources மற்றும் procedures வழங்க வேண்டும். Supervisors JSA-ஐ prepare செய்து implement செய்ய வேண்டும். Workers JSA-வில் participate செய்து hazards-ஐ புரிந்து controls-ஐ பின்பற்ற வேண்டும்.',
        'Tamil_checklist': 'JSA Checklist',
        'Tamil_checklistText':
            'Job steps, hazards, risk assessment, controls, hierarchy of controls, worker briefing, PPE மற்றும் conditions மாறும்போது JSA review ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Generic JSA, job steps missing, hazards identify செய்யாதது, ineffective controls, workers-க்கு briefing வழங்காதது மற்றும் conditions மாறிய பிறகும் outdated JSA பயன்படுத்துவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Experienced workers-ஐ JSA-வில் ஈடுபடுத்தி, ஒவ்வொரு job step-ன் hazards-ஐ identify செய்து, hierarchy of controls-ஐ apply செய்து, வேலை தொடங்குவதற்கு முன் toolbox talk நடத்தவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company JSA/JHA Procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'K',
        'title': 'Key Safety Indicators',
        'desc':
            'Safety performance measures used to monitor, evaluate and improve workplace health and safety performance.',
        'English_title': 'Key Safety Indicators',
        'English_what': 'What are Key Safety Indicators?',
        'English_whatText':
            'Key Safety Indicators are measurable safety performance measures used to monitor workplace safety activities, identify trends and evaluate the effectiveness of safety controls.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To monitor safety performance, identify weaknesses, measure improvement and support effective decision-making before incidents occur.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Define relevant safety indicators, collect accurate data, monitor trends, communicate results, investigate negative trends and implement corrective actions where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management establishes safety objectives and provides resources. HSE teams collect and analyse safety data. Supervisors monitor site performance and workers participate in safety activities and reporting.',
        'English_checklist': 'Safety Indicators Checklist',
        'English_checklistText':
            'Safety objectives defined, leading indicators monitored, lagging indicators reviewed, inspections completed, toolbox talks recorded, training monitored, incidents analysed and corrective actions tracked.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Incorrect or incomplete safety data, failure to monitor indicators, focusing only on incident rates, ignoring leading indicators, poor reporting and failure to take corrective action.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a balanced combination of leading and lagging indicators, review trends regularly, involve supervisors and workers and use the results to prevent incidents and improve safety performance.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE management procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Key Safety Indicators',
        'Hindi_what': 'Key Safety Indicators क्या हैं?',
        'Hindi_whatText':
            'Key Safety Indicators ऐसे measurable safety performance measures हैं जिनका उपयोग workplace safety activities को monitor करने, trends पहचानने और safety controls की effectiveness का मूल्यांकन करने के लिए किया जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Safety performance को monitor करना, weaknesses की पहचान करना, improvement को measure करना और incidents से पहले effective decisions लेने में सहायता करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Relevant safety indicators निर्धारित करें, accurate data collect करें, trends monitor करें, results communicate करें और negative trends होने पर corrective actions लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management safety objectives और resources प्रदान करे। HSE team safety data collect और analyse करे। Supervisors site performance monitor करें और workers safety activities तथा reporting में participate करें।',
        'Hindi_checklist': 'Safety Indicators Checklist',
        'Hindi_checklistText':
            'Safety objectives, leading indicators, lagging indicators, inspections, toolbox talks, training, incident analysis और corrective actions की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Incorrect safety data, indicators monitor न करना, केवल incident rates पर ध्यान देना, leading indicators को ignore करना, poor reporting और corrective action न लेना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Leading और lagging indicators का balanced combination उपयोग करें, trends की नियमित समीक्षा करें और results का उपयोग incidents रोकने तथा safety performance सुधारने के लिए करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE management procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Key Safety Indicators',
        'Malayalam_what': 'Key Safety Indicators എന്താണ്?',
        'Malayalam_whatText':
            'Workplace safety activities monitor ചെയ്യാനും safety performance വിലയിരുത്താനും trends തിരിച്ചറിയാനും safety controls എത്രത്തോളം effective ആണെന്ന് പരിശോധിക്കാനും ഉപയോഗിക്കുന്ന measurable safety performance measures ആണ് Key Safety Indicators.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Safety performance monitor ചെയ്യുക, weaknesses തിരിച്ചറിയുക, improvement measure ചെയ്യുക, incidents ഉണ്ടാകുന്നതിന് മുമ്പ് ആവശ്യമായ തീരുമാനങ്ങൾ എടുക്കാൻ സഹായിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Relevant safety indicators നിർണ്ണയിക്കുക, accurate data collect ചെയ്യുക, trends monitor ചെയ്യുക, results communicate ചെയ്യുക, negative trends കണ്ടെത്തുമ്പോൾ corrective actions നടപ്പാക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management safety objectives നിശ്ചയിക്കുകയും resources നൽകുകയും വേണം. HSE team safety data collect ചെയ്ത് analyse ചെയ്യണം. Supervisors site performance monitor ചെയ്യുകയും workers safety activities-ലും reporting-ലും participate ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Safety Indicators Checklist',
        'Malayalam_checklistText':
            'Safety objectives, leading indicators, lagging indicators, inspections, toolbox talks, training, incident analysis, corrective actions എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Incorrect safety data, indicators monitor ചെയ്യാത്തത്, incident rates മാത്രം പരിഗണിക്കുന്നത്, leading indicators ignore ചെയ്യുന്നത്, poor reporting, corrective action എടുക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Leading indicators-ഉം lagging indicators-ഉം balanced ആയി ഉപയോഗിക്കുക, safety trends regularly review ചെയ്യുക, supervisors-നെയും workers-നെയും ഉൾപ്പെടുത്തുക, results ഉപയോഗിച്ച് incidents prevent ചെയ്യുകയും safety performance improve ചെയ്യുകയും ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE management procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Key Safety Indicators',
        'Tamil_what': 'Key Safety Indicators என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட பாதுகாப்பு செயல்பாடுகளை கண்காணிக்கவும், safety performance-ஐ மதிப்பிடவும், trends-ஐ கண்டறியவும், safety controls-ன் effectiveness-ஐ மதிப்பிடவும் பயன்படுத்தப்படும் அளவிடக்கூடிய safety performance measures ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Safety performance-ஐ monitor செய்து, weaknesses-ஐ கண்டறிந்து, improvement-ஐ measure செய்து, incidents ஏற்படும் முன் சரியான முடிவுகளை எடுக்க உதவுவது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Relevant safety indicators-ஐ நிர்ணயித்து, accurate data-ஐ collect செய்து, trends-ஐ monitor செய்து, results-ஐ communicate செய்து, negative trends ஏற்பட்டால் corrective actions-ஐ implement செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management safety objectives மற்றும் resources வழங்க வேண்டும். HSE team safety data-ஐ collect செய்து analyse செய்ய வேண்டும். Supervisors site performance-ஐ monitor செய்ய வேண்டும். Workers safety activities மற்றும் reporting-ல் participate செய்ய வேண்டும்.',
        'Tamil_checklist': 'Safety Indicators Checklist',
        'Tamil_checklistText':
            'Safety objectives, leading indicators, lagging indicators, inspections, toolbox talks, training, incident analysis மற்றும் corrective actions ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Incorrect safety data, indicators monitor செய்யாதது, incident rates-ல் மட்டும் கவனம் செலுத்துவது, leading indicators-ஐ ignore செய்வது, poor reporting மற்றும் corrective action எடுக்காதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Leading மற்றும் lagging indicators-ஐ balanced முறையில் பயன்படுத்தி, safety trends-ஐ regularly review செய்து, supervisors மற்றும் workers-ஐ involve செய்து, incidents-ஐ prevent செய்து safety performance-ஐ improve செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE management procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'L',
        'title': 'Lockout / Tagout (LOTO)',
        'desc':
            'A safety procedure used to isolate hazardous energy and prevent unexpected equipment startup during maintenance or servicing.',
        'English_title': 'Lockout / Tagout (LOTO)',
        'English_what': 'What is Lockout / Tagout?',
        'English_whatText':
            'Lockout / Tagout (LOTO) is a safety procedure used to isolate hazardous energy sources and prevent the unexpected startup or release of stored energy while equipment is being serviced or maintained.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect workers from injury caused by unexpected energization, startup or release of hazardous stored energy during maintenance, repair, cleaning or inspection.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify all energy sources, shut down the equipment, isolate the energy, apply personal locks and tags, release or restrain stored energy, verify zero energy state and only then begin the work.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides an effective LOTO procedure and resources. Authorized workers perform energy isolation. Affected workers understand the lockout requirements and do not interfere with locks or tags.',
        'English_checklist': 'LOTO Checklist',
        'English_checklistText':
            'Energy sources identified, equipment shutdown, isolation points identified, locks and tags applied, stored energy released, zero-energy verification completed, work performed safely and locks removed according to procedure.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to isolate all energy sources, missing personal locks or tags, starting work without zero-energy verification, bypassing isolation devices, removing another worker’s lock without authorization and inadequate LOTO training.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a written LOTO procedure for each applicable equipment, clearly identify isolation points, verify zero energy before work starts and ensure every authorized worker applies their own personal lock.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company LOTO procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions and approved project safety procedures.',

        'Hindi_title': 'Lockout / Tagout (LOTO)',
        'Hindi_what': 'Lockout / Tagout क्या है?',
        'Hindi_whatText':
            'Lockout / Tagout (LOTO) एक safety procedure है जिसका उपयोग hazardous energy sources को isolate करने और maintenance या servicing के दौरान equipment के unexpected startup या stored energy release को रोकने के लिए किया जाता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Maintenance, repair, cleaning या inspection के दौरान unexpected energization, startup या stored hazardous energy के release से होने वाली injuries को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'सभी energy sources की पहचान करें, equipment shutdown करें, energy isolate करें, personal locks और tags लगाएँ, stored energy release या restrain करें, zero-energy state verify करें और उसके बाद ही काम शुरू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management effective LOTO procedure और resources प्रदान करे। Authorized workers energy isolation करें। Affected workers LOTO requirements समझें और locks या tags के साथ छेड़छाड़ न करें।',
        'Hindi_checklist': 'LOTO Checklist',
        'Hindi_checklistText':
            'Energy sources identified, equipment shutdown, isolation points identified, locks और tags applied, stored energy released, zero-energy verification और safe work completion की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'सभी energy sources isolate न करना, personal locks या tags का उपयोग न करना, zero-energy verification के बिना काम शुरू करना, isolation devices को bypass करना और unauthorized तरीके से दूसरे worker का lock हटाना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'प्रत्येक applicable equipment के लिए written LOTO procedure रखें, isolation points को clearly identify करें, काम शुरू करने से पहले zero energy verify करें और प्रत्येक authorized worker को अपना personal lock लगाने दें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company LOTO procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions और approved project safety procedures।',

        'Malayalam_title': 'Lockout / Tagout (LOTO)',
        'Malayalam_what': 'Lockout / Tagout എന്താണ്?',
        'Malayalam_whatText':
            'Maintenance അല്ലെങ്കിൽ servicing സമയത്ത് hazardous energy sources isolate ചെയ്യാനും equipment unexpected ആയി start ചെയ്യുന്നതും stored energy release ആകുന്നത് തടയാനും ഉപയോഗിക്കുന്ന safety procedure ആണ് Lockout / Tagout (LOTO).',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Maintenance, repair, cleaning അല്ലെങ്കിൽ inspection സമയത്ത് unexpected energization, startup അല്ലെങ്കിൽ stored hazardous energy release മൂലമുള്ള injuries തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'എല്ലാ energy sources തിരിച്ചറിയുക, equipment shutdown ചെയ്യുക, energy isolate ചെയ്യുക, personal locks and tags സ്ഥാപിക്കുക, stored energy release അല്ലെങ്കിൽ restrain ചെയ്യുക, zero-energy state verify ചെയ്യുക, അതിന് ശേഷം മാത്രം work ആരംഭിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management effective LOTO procedure-ഉം resources-ഉം നൽകണം. Authorized workers energy isolation നടത്തണം. Affected workers LOTO requirements മനസ്സിലാക്കി locks അല്ലെങ്കിൽ tags-ൽ ഇടപെടരുത്.',
        'Malayalam_checklist': 'LOTO Checklist',
        'Malayalam_checklistText':
            'Energy sources identified, equipment shutdown, isolation points identified, locks and tags applied, stored energy released, zero-energy verification completed, work safely performed, procedure അനുസരിച്ച് locks removed എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'എല്ലാ energy sources isolate ചെയ്യാത്തത്, personal locks/tags ഉപയോഗിക്കാത്തത്, zero-energy verification ഇല്ലാതെ work തുടങ്ങുന്നത്, isolation devices bypass ചെയ്യുന്നത്, authorization ഇല്ലാതെ മറ്റൊരു worker-ന്റെ lock നീക്കം ചെയ്യുന്നത്, LOTO training ഇല്ലാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Applicable equipment-ുകൾക്ക് written LOTO procedure ഉപയോഗിക്കുക, isolation points വ്യക്തമായി identify ചെയ്യുക, work തുടങ്ങുന്നതിന് മുമ്പ് zero energy verify ചെയ്യുക, ഓരോ authorized worker-ഉം സ്വന്തം personal lock സ്ഥാപിക്കുന്നുവെന്ന് ഉറപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company LOTO procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions, approved project safety procedures.',

        'Tamil_title': 'Lockout / Tagout (LOTO)',
        'Tamil_what': 'Lockout / Tagout என்றால் என்ன?',
        'Tamil_whatText':
            'Maintenance அல்லது servicing செய்யும் போது hazardous energy sources-ஐ isolate செய்து, equipment எதிர்பாராதவிதமாக start ஆகுவதையும் stored energy release ஆகுவதையும் தடுக்கும் safety procedure ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Maintenance, repair, cleaning அல்லது inspection செய்யும் போது unexpected energization, startup அல்லது stored hazardous energy release காரணமாக ஏற்படும் injuries-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'அனைத்து energy sources-ஐ identify செய்து, equipment-ஐ shutdown செய்து, energy-ஐ isolate செய்து, personal locks மற்றும் tags apply செய்து, stored energy-ஐ release அல்லது restrain செய்து, zero-energy state-ஐ verify செய்த பிறகே வேலை தொடங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management effective LOTO procedure மற்றும் resources வழங்க வேண்டும். Authorized workers energy isolation செய்ய வேண்டும். Affected workers LOTO requirements-ஐ புரிந்து locks மற்றும் tags-ல் தலையிடக்கூடாது.',
        'Tamil_checklist': 'LOTO Checklist',
        'Tamil_checklistText':
            'Energy sources identified, equipment shutdown, isolation points identified, locks and tags applied, stored energy released, zero-energy verification மற்றும் safe work completion ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'அனைத்து energy sources-ஐ isolate செய்யாதது, personal locks அல்லது tags பயன்படுத்தாதது, zero-energy verification இல்லாமல் வேலை தொடங்குவது, isolation devices-ஐ bypass செய்வது மற்றும் authorization இல்லாமல் மற்றொரு worker-ன் lock-ஐ அகற்றுவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Applicable equipment-களுக்கு written LOTO procedure பயன்படுத்தி, isolation points-ஐ தெளிவாக identify செய்து, வேலை தொடங்குவதற்கு முன் zero energy verify செய்து, ஒவ்வொரு authorized worker-ம் தனது personal lock-ஐ apply செய்வதை உறுதி செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company LOTO procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'M',
        'title': 'Manual Handling',
        'desc':
            'Safe movement, lifting, carrying, pushing and pulling of loads to prevent musculoskeletal injuries.',
        'English_title': 'Manual Handling',
        'English_what': 'What is Manual Handling?',
        'English_whatText':
            'Manual Handling involves lifting, lowering, carrying, pushing, pulling, moving or supporting objects using physical effort.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent strains, sprains, back injuries and other musculoskeletal disorders caused by unsafe handling of loads.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Assess the load, use mechanical aids where practicable, plan the route, use correct lifting techniques, avoid excessive loads and obtain assistance when required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides suitable equipment and training. Supervisors assess manual handling activities. Workers use safe techniques and report unsafe conditions.',
        'English_checklist': 'Manual Handling Checklist',
        'English_checklistText':
            'Load assessed, weight known, route clear, mechanical aid considered, correct posture used, assistance obtained where required and suitable PPE provided.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Lifting excessive loads, poor posture, twisting while lifting, blocked routes, carrying loads that obstruct vision and failure to use available lifting aids.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Eliminate unnecessary manual handling where possible, use mechanical aids, keep the load close to the body, lift with controlled movement and team-lift when appropriate.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company manual handling procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Manual Handling',
        'Hindi_what': 'Manual Handling क्या है?',
        'Hindi_whatText':
            'Manual Handling में physical effort का उपयोग करके objects को उठाना, नीचे रखना, carry करना, push करना, pull करना या move करना शामिल है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Unsafe handling के कारण होने वाले strains, sprains, back injuries और musculoskeletal disorders को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Load का assessment करें, mechanical aids का उपयोग करें, route plan करें, सही lifting technique अपनाएँ और आवश्यकता होने पर assistance लें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable equipment और training प्रदान करे। Supervisors manual handling activities assess करें। Workers safe techniques का पालन करें और unsafe conditions report करें।',
        'Hindi_checklist': 'Manual Handling Checklist',
        'Hindi_checklistText':
            'Load assessed, weight known, route clear, mechanical aid considered, correct posture, assistance और suitable PPE की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Excessive load उठाना, गलत posture, lifting के दौरान twisting, blocked routes, vision obstruct करने वाले loads और lifting aids का उपयोग न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Unnecessary manual handling को eliminate करें, mechanical aids का उपयोग करें, load को body के करीब रखें और आवश्यकता होने पर team lifting करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company manual handling procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Manual Handling',
        'Malayalam_what': 'Manual Handling എന്താണ്?',
        'Malayalam_whatText':
            'Physical effort ഉപയോഗിച്ച് objects ഉയർത്തുക, താഴെ വയ്ക്കുക, carry ചെയ്യുക, push ചെയ്യുക, pull ചെയ്യുക അല്ലെങ്കിൽ move ചെയ്യുക എന്നിവയാണ് Manual Handling.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Unsafe handling മൂലം ഉണ്ടാകുന്ന strains, sprains, back injuries, musculoskeletal disorders എന്നിവ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Load assess ചെയ്യുക, mechanical aids ഉപയോഗിക്കുക, route plan ചെയ്യുക, ശരിയായ lifting technique ഉപയോഗിക്കുക, excessive load ഒഴിവാക്കുക, ആവശ്യമായപ്പോൾ assistance നേടുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable equipment-ഉം training-ഉം നൽകണം. Supervisors manual handling activities assess ചെയ്യണം. Workers safe techniques പാലിക്കുകയും unsafe conditions report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Manual Handling Checklist',
        'Malayalam_checklistText':
            'Load assessed, weight known, route clear, mechanical aid considered, correct posture, assistance, suitable PPE എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Excessive load ഉയർത്തുന്നത്, incorrect posture, lifting സമയത്ത് twisting, blocked routes, vision obstruct ചെയ്യുന്ന load carry ചെയ്യുന്നത്, lifting aids ഉപയോഗിക്കാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Unnecessary manual handling ഒഴിവാക്കുക, mechanical aids ഉപയോഗിക്കുക, load body-ക്ക് അടുത്ത് പിടിക്കുക, controlled movement ഉപയോഗിക്കുക, ആവശ്യമായപ്പോൾ team lifting നടത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company manual handling procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Manual Handling',
        'Tamil_what': 'Manual Handling என்றால் என்ன?',
        'Tamil_whatText':
            'Physical effort பயன்படுத்தி பொருட்களை தூக்குதல், கீழே வைப்பது, carry செய்தல், push செய்தல், pull செய்தல் அல்லது move செய்தல் Manual Handling ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Unsafe handling காரணமாக ஏற்படும் strains, sprains, back injuries மற்றும் musculoskeletal disorders-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Load-ஐ assess செய்து, mechanical aids பயன்படுத்தி, route-ஐ plan செய்து, correct lifting technique பயன்படுத்தி, தேவையான போது assistance பெற வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management suitable equipment மற்றும் training வழங்க வேண்டும். Supervisors manual handling activities-ஐ assess செய்ய வேண்டும். Workers safe techniques-ஐ follow செய்து unsafe conditions-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Manual Handling Checklist',
        'Tamil_checklistText':
            'Load, weight, route, mechanical aid, correct posture, assistance மற்றும் suitable PPE ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Excessive load தூக்குதல், incorrect posture, lifting போது twisting, blocked routes மற்றும் lifting aids பயன்படுத்தாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Unnecessary manual handling-ஐ தவிர்த்து, mechanical aids பயன்படுத்தி, load-ஐ body-க்கு அருகில் வைத்து, தேவையான போது team lifting செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company manual handling procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'N',
        'title': 'Noise and Hearing Conservation',
        'desc':
            'Control of workplace noise exposure and protection of workers from noise-induced hearing loss.',
        'English_title': 'Noise and Hearing Conservation',
        'English_what': 'What is Noise and Hearing Conservation?',
        'English_whatText':
            'Noise and Hearing Conservation is the systematic management of workplace noise exposure to prevent hearing damage and other effects of excessive noise.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To reduce harmful noise exposure and prevent noise-induced hearing loss and related health effects.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify noisy activities, assess noise exposure, apply engineering and administrative controls, provide suitable hearing protection and conduct monitoring where required.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides noise controls and resources. HSE teams monitor exposure. Supervisors enforce controls and workers use hearing protection correctly.',
        'English_checklist': 'Noise Checklist',
        'English_checklistText':
            'Noise sources identified, exposure assessed, controls implemented, hearing protection provided, warning signs displayed, workers trained and monitoring completed where required.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Excessive noise exposure, failure to use hearing protection, missing warning signs, defective hearing protection and failure to assess noise exposure.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Control noise at source, maintain equipment properly, reduce exposure time, use suitable hearing protection and monitor noise levels regularly.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company noise control procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Noise and Hearing Conservation',
        'Hindi_what': 'Noise and Hearing Conservation क्या है?',
        'Hindi_whatText':
            'यह workplace noise exposure को manage करने और excessive noise से hearing damage को रोकने की systematic process है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Harmful noise exposure को कम करना और noise-induced hearing loss को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Noise sources identify करें, exposure assess करें, engineering और administrative controls लागू करें तथा suitable hearing protection प्रदान करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management noise controls प्रदान करे। HSE team exposure monitor करे। Supervisors controls लागू करें और workers hearing protection सही तरीके से उपयोग करें।',
        'Hindi_checklist': 'Noise Checklist',
        'Hindi_checklistText':
            'Noise sources, exposure assessment, controls, hearing protection, warning signs, worker training और monitoring की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Excessive noise exposure, hearing protection का उपयोग न करना, warning signs missing होना और noise assessment न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Noise को source पर control करें, equipment maintain करें, exposure time कम करें और suitable hearing protection का उपयोग करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company noise control procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Noise and Hearing Conservation',
        'Malayalam_what': 'Noise and Hearing Conservation എന്താണ്?',
        'Malayalam_whatText':
            'Workplace noise exposure നിയന്ത്രിക്കുകയും excessive noise മൂലമുള്ള hearing damage തടയുകയും ചെയ്യുന്ന systematic safety process ആണ് Noise and Hearing Conservation.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Harmful noise exposure കുറയ്ക്കുകയും noise-induced hearing loss തടയുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Noise sources identify ചെയ്യുക, exposure assess ചെയ്യുക, engineering and administrative controls apply ചെയ്യുക, suitable hearing protection നൽകുക, ആവശ്യമായ monitoring നടത്തുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management noise controls നൽകണം. HSE team exposure monitor ചെയ്യണം. Supervisors controls enforce ചെയ്യണം. Workers hearing protection ശരിയായി ഉപയോഗിക്കണം.',
        'Malayalam_checklist': 'Noise Checklist',
        'Malayalam_checklistText':
            'Noise sources, exposure assessment, controls, hearing protection, warning signs, worker training, monitoring എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Excessive noise exposure, hearing protection ഉപയോഗിക്കാത്തത്, warning signs ഇല്ലാത്തത്, defective hearing protection, noise exposure assess ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Noise source-ൽ തന്നെ control ചെയ്യുക, equipment properly maintain ചെയ്യുക, exposure time കുറയ്ക്കുക, suitable hearing protection ഉപയോഗിക്കുക, noise levels regularly monitor ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company noise control procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Noise and Hearing Conservation',
        'Tamil_what': 'Noise and Hearing Conservation என்றால் என்ன?',
        'Tamil_whatText':
            'Workplace noise exposure-ஐ manage செய்து excessive noise காரணமாக ஏற்படும் hearing damage-ஐ தடுக்கும் systematic safety process ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Harmful noise exposure-ஐ குறைத்து noise-induced hearing loss-ஐ தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Noise sources identify செய்து, exposure assess செய்து, engineering மற்றும் administrative controls apply செய்து, suitable hearing protection வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management noise controls வழங்க வேண்டும். HSE team exposure monitor செய்ய வேண்டும். Supervisors controls enforce செய்ய வேண்டும். Workers hearing protection சரியாக பயன்படுத்த வேண்டும்.',
        'Tamil_checklist': 'Noise Checklist',
        'Tamil_checklistText':
            'Noise sources, exposure assessment, controls, hearing protection, warning signs, worker training மற்றும் monitoring ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Excessive noise exposure, hearing protection பயன்படுத்தாதது, warning signs இல்லாதது மற்றும் noise exposure assess செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Noise source-ல் control செய்து, equipment maintain செய்து, exposure time குறைத்து, suitable hearing protection பயன்படுத்தி, noise levels-ஐ regularly monitor செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company noise control procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'O',
        'title': 'Occupational Health',
        'desc':
            'Protection and promotion of workers health by identifying and controlling workplace health hazards.',
        'English_title': 'Occupational Health',
        'English_what': 'What is Occupational Health?',
        'English_whatText':
            'Occupational Health focuses on protecting workers from health hazards arising from workplace activities, conditions and exposures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent work-related illness, protect worker health and promote a safe and healthy working environment.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify health hazards, assess exposure, implement suitable controls, provide occupational health monitoring where required and educate workers about health risks.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and health protection measures. HSE and occupational health professionals assess risks. Workers follow health controls and report symptoms or unsafe exposure.',
        'English_checklist': 'Occupational Health Checklist',
        'English_checklistText':
            'Health hazards identified, exposure assessed, controls implemented, welfare facilities available, drinking water provided, hygiene maintained, health monitoring completed where required and workers trained.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Poor hygiene, inadequate welfare facilities, uncontrolled chemical exposure, excessive heat exposure, lack of health monitoring and failure to communicate occupational health risks.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use the hierarchy of controls, monitor workplace health risks, maintain good welfare facilities, promote hygiene and provide appropriate occupational health training.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company occupational health procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Occupational Health',
        'Hindi_what': 'Occupational Health क्या है?',
        'Hindi_whatText':
            'Occupational Health workplace activities, conditions और exposures से होने वाले health hazards से workers की सुरक्षा पर ध्यान देता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Work-related illness को रोकना, worker health की रक्षा करना और safe तथा healthy workplace को बढ़ावा देना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Health hazards identify करें, exposure assess करें, controls लागू करें, आवश्यक health monitoring करें और workers को health risks के बारे में educate करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources और health protection measures प्रदान करे। HSE professionals risks assess करें। Workers health controls follow करें और unsafe exposure report करें।',
        'Hindi_checklist': 'Occupational Health Checklist',
        'Hindi_checklistText':
            'Health hazards, exposure, controls, welfare facilities, drinking water, hygiene, health monitoring और worker training की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Poor hygiene, inadequate welfare facilities, uncontrolled chemical exposure, excessive heat exposure और health monitoring की कमी।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Hierarchy of controls लागू करें, health risks monitor करें, welfare facilities maintain करें और hygiene तथा occupational health training को promote करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company occupational health procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Occupational Health',
        'Malayalam_what': 'Occupational Health എന്താണ്?',
        'Malayalam_whatText':
            'Workplace activities, conditions, exposures എന്നിവ മൂലം ഉണ്ടാകുന്ന health hazards-ൽ നിന്ന് workers-നെ സംരക്ഷിക്കുന്ന മേഖലയാണ് Occupational Health.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Work-related illness തടയുക, worker health സംരക്ഷിക്കുക, safe and healthy workplace ഉറപ്പാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Health hazards identify ചെയ്യുക, exposure assess ചെയ്യുക, suitable controls apply ചെയ്യുക, ആവശ്യമായ health monitoring നടത്തുക, workers-നെ health risks സംബന്ധിച്ച് educate ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources and health protection measures നൽകണം. HSE professionals risks assess ചെയ്യണം. Workers health controls പാലിക്കുകയും unsafe exposure report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Occupational Health Checklist',
        'Malayalam_checklistText':
            'Health hazards, exposure, controls, welfare facilities, drinking water, hygiene, health monitoring, worker training എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Poor hygiene, inadequate welfare facilities, uncontrolled chemical exposure, excessive heat exposure, health monitoring ഇല്ലാത്തത്, occupational health risks communicate ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Hierarchy of controls apply ചെയ്യുക, workplace health risks monitor ചെയ്യുക, welfare facilities maintain ചെയ്യുക, hygiene promote ചെയ്യുക, occupational health training നൽകുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company occupational health procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Occupational Health',
        'Tamil_what': 'Occupational Health என்றால் என்ன?',
        'Tamil_whatText':
            'Workplace activities, conditions மற்றும் exposures காரணமாக ஏற்படும் health hazards-ல் இருந்து workers-ஐ பாதுகாப்பதில் கவனம் செலுத்தும் துறையாகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Work-related illness-ஐ தடுப்பது, worker health-ஐ பாதுகாப்பது மற்றும் safe மற்றும் healthy workplace-ஐ உருவாக்குவது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Health hazards identify செய்து, exposure assess செய்து, suitable controls apply செய்து, தேவையான health monitoring செய்து, workers-க்கு health risks பற்றி training வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources மற்றும் health protection measures வழங்க வேண்டும். HSE professionals risks assess செய்ய வேண்டும். Workers health controls-ஐ follow செய்து unsafe exposure-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Occupational Health Checklist',
        'Tamil_checklistText':
            'Health hazards, exposure, controls, welfare facilities, drinking water, hygiene, health monitoring மற்றும் worker training ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Poor hygiene, inadequate welfare facilities, uncontrolled chemical exposure, excessive heat exposure மற்றும் health monitoring இல்லாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Hierarchy of controls-ஐ apply செய்து, workplace health risks-ஐ monitor செய்து, welfare facilities-ஐ maintain செய்து, hygiene மற்றும் occupational health training-ஐ promote செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company occupational health procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'P',
        'title': 'Personal Protective Equipment',
        'desc':
            'Protective equipment and clothing used to reduce worker exposure to workplace hazards.',
        'English_title': 'Personal Protective Equipment',
        'English_what': 'What is Personal Protective Equipment?',
        'English_whatText':
            'Personal Protective Equipment (PPE) is equipment or clothing worn by workers to reduce exposure to specific workplace hazards.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide protection against hazards that cannot be adequately eliminated or controlled through other measures.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Conduct hazard assessment, select suitable PPE, ensure correct fit, inspect PPE before use, maintain it properly and train workers in its correct use and limitations.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides appropriate PPE and training. Supervisors ensure PPE is used correctly. Workers wear, inspect and maintain PPE and report damaged equipment.',
        'English_checklist': 'PPE Checklist',
        'English_checklistText':
            'Hazard assessment completed, correct PPE selected, PPE available, correct fit confirmed, PPE inspected, workers trained and damaged PPE replaced.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Failure to wear PPE, incorrect PPE selection, damaged PPE, poor fit, expired equipment, failure to inspect PPE and using PPE as a substitute for higher-level controls.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Apply the hierarchy of controls first, select task-specific PPE, ensure proper fit and compatibility, inspect PPE before use and replace damaged equipment immediately.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company PPE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions and approved project safety procedures.',

        'Hindi_title': 'Personal Protective Equipment',
        'Hindi_what': 'Personal Protective Equipment क्या है?',
        'Hindi_whatText':
            'Personal Protective Equipment (PPE) वह equipment या clothing है जिसे workers workplace hazards के exposure को कम करने के लिए पहनते हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'उन hazards से protection देना जिन्हें अन्य control measures द्वारा पर्याप्त रूप से eliminate या control नहीं किया जा सकता।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazard assessment करें, suitable PPE select करें, correct fit सुनिश्चित करें, use से पहले inspect करें, maintain करें और workers को proper use की training दें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management appropriate PPE और training प्रदान करे। Supervisors PPE use सुनिश्चित करें। Workers PPE पहनें, inspect करें, maintain करें और damaged PPE report करें।',
        'Hindi_checklist': 'PPE Checklist',
        'Hindi_checklistText':
            'Hazard assessment, correct PPE, availability, fit, inspection, training और replacement की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'PPE न पहनना, incorrect PPE, damaged PPE, poor fit, expired equipment, inspection न करना और PPE को higher-level controls के substitute के रूप में उपयोग करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'पहले hierarchy of controls लागू करें, task-specific PPE चुनें, proper fit सुनिश्चित करें, use से पहले inspect करें और damaged PPE तुरंत replace करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company PPE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions और approved project safety procedures।',

        'Malayalam_title': 'Personal Protective Equipment',
        'Malayalam_what': 'Personal Protective Equipment എന്താണ്?',
        'Malayalam_whatText':
            'Workplace hazards-ലേക്കുള്ള exposure കുറയ്ക്കാൻ workers ധരിക്കുന്ന protective equipment അല്ലെങ്കിൽ clothing ആണ് Personal Protective Equipment (PPE).',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'മറ്റ് control measures ഉപയോഗിച്ച് eliminate അല്ലെങ്കിൽ adequately control ചെയ്യാൻ കഴിയാത്ത hazards-ൽ നിന്ന് workers-നെ സംരക്ഷിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazard assessment നടത്തുക, suitable PPE select ചെയ്യുക, correct fit ഉറപ്പാക്കുക, ഉപയോഗിക്കുന്നതിന് മുമ്പ് inspect ചെയ്യുക, properly maintain ചെയ്യുക, workers-ന് correct use സംബന്ധിച്ച training നൽകുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management appropriate PPE and training നൽകണം. Supervisors PPE ശരിയായി ഉപയോഗിക്കുന്നുവെന്ന് ഉറപ്പാക്കണം. Workers PPE ധരിക്കുകയും inspect ചെയ്യുകയും maintain ചെയ്യുകയും damaged PPE report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'PPE Checklist',
        'Malayalam_checklistText':
            'Hazard assessment, correct PPE selection, availability, correct fit, inspection, worker training, damaged PPE replacement എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'PPE ധരിക്കാത്തത്, incorrect PPE തിരഞ്ഞെടുക്കുന്നത്, damaged PPE ഉപയോഗിക്കുന്നത്, poor fit, expired equipment, PPE inspect ചെയ്യാത്തത്, higher-level controls-ന് പകരം PPE മാത്രം ഉപയോഗിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'ആദ്യം hierarchy of controls apply ചെയ്യുക, task-specific PPE select ചെയ്യുക, proper fit and compatibility ഉറപ്പാക്കുക, ഉപയോഗിക്കുന്നതിന് മുമ്പ് PPE inspect ചെയ്യുക, damaged equipment ഉടൻ replace ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company PPE procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions, approved project safety procedures.',

        'Tamil_title': 'Personal Protective Equipment',
        'Tamil_what': 'Personal Protective Equipment என்றால் என்ன?',
        'Tamil_whatText':
            'Workplace hazards exposure-ஐ குறைக்க workers அணியும் protective equipment அல்லது clothing Personal Protective Equipment (PPE) ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'மற்ற control measures மூலம் போதுமான அளவு eliminate அல்லது control செய்ய முடியாத hazards-லிருந்து workers-ஐ பாதுகாப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazard assessment செய்து, suitable PPE select செய்து, correct fit உறுதி செய்து, பயன்படுத்துவதற்கு முன் inspect செய்து, maintain செய்து, workers-க்கு proper use training வழங்க வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management appropriate PPE மற்றும் training வழங்க வேண்டும். Supervisors PPE சரியாக பயன்படுத்தப்படுவதை உறுதி செய்ய வேண்டும். Workers PPE அணிந்து, inspect செய்து, maintain செய்து damaged PPE-ஐ report செய்ய வேண்டும்.',
        'Tamil_checklist': 'PPE Checklist',
        'Tamil_checklistText':
            'Hazard assessment, correct PPE, availability, fit, inspection, training மற்றும் damaged PPE replacement ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'PPE அணியாதது, incorrect PPE, damaged PPE, poor fit, expired equipment, PPE inspection செய்யாதது மற்றும் higher-level controls-க்கு பதிலாக PPE மட்டும் பயன்படுத்துவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'முதலில் hierarchy of controls apply செய்து, task-specific PPE தேர்வு செய்து, proper fit மற்றும் compatibility உறுதி செய்து, பயன்படுத்துவதற்கு முன் inspect செய்து, damaged PPE-ஐ உடனடியாக replace செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company PPE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, manufacturer instructions மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'Q',
        'title': 'Quality and Safety Management',
        'desc':
            'Integrated management of quality and safety requirements to ensure work is completed safely and to the required standard.',
        'English_title': 'Quality and Safety Management',
        'English_what': 'What is Quality and Safety Management?',
        'English_whatText':
            'Quality and Safety Management is an integrated approach that ensures work activities meet required quality standards while protecting workers, the public, property and the environment.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent defects, incidents and unsafe conditions while achieving required project quality and safety standards.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Establish clear procedures, identify quality and safety risks, define responsibilities, conduct inspections, control nonconformities, implement corrective actions and maintain required records.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management establishes the integrated management system. Quality and HSE teams monitor compliance. Supervisors implement procedures and workers follow approved methods and report problems.',
        'English_checklist': 'Quality and Safety Checklist',
        'English_checklistText':
            'Procedures available, responsibilities defined, risk assessments completed, inspections conducted, materials and equipment checked, nonconformities recorded, corrective actions tracked and records maintained.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without approved procedures, poor inspection, uncontrolled changes, repeated nonconformities, incomplete records and failure to implement corrective actions.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Integrate quality and safety into planning, inspect work at each critical stage, encourage reporting, investigate failures and continuously improve procedures and controls.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company QHSE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, ISO management system principles and approved project procedures.',

        'Hindi_title': 'Quality and Safety Management',
        'Hindi_what': 'Quality and Safety Management क्या है?',
        'Hindi_whatText':
            'Quality and Safety Management एक integrated approach है जो यह सुनिश्चित करता है कि काम required quality standards के अनुसार और workers, public, property तथा environment की सुरक्षा के साथ पूरा हो।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Defects, incidents और unsafe conditions को रोकना तथा required project quality और safety standards प्राप्त करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Clear procedures बनाएं, quality और safety risks identify करें, responsibilities define करें, inspections करें, nonconformities control करें और corrective actions implement करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management integrated management system स्थापित करे। Quality और HSE teams compliance monitor करें। Supervisors procedures लागू करें और workers approved methods follow करें।',
        'Hindi_checklist': 'Quality and Safety Checklist',
        'Hindi_checklistText':
            'Procedures, responsibilities, risk assessments, inspections, materials, equipment, nonconformities, corrective actions और records की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Approved procedures के बिना काम करना, poor inspection, uncontrolled changes, repeated nonconformities, incomplete records और corrective actions implement न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Planning में quality और safety को integrate करें, critical stages पर inspection करें, reporting को encourage करें और failures से सीखकर continuous improvement करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company QHSE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, ISO management system principles और approved project procedures।',

        'Malayalam_title': 'Quality and Safety Management',
        'Malayalam_what': 'Quality and Safety Management എന്താണ്?',
        'Malayalam_whatText':
            'Required quality standards പാലിച്ചുകൊണ്ട് work safely complete ചെയ്യാനും workers, public, property, environment എന്നിവ സംരക്ഷിക്കാനും സഹായിക്കുന്ന integrated management approach ആണ് Quality and Safety Management.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Defects, incidents, unsafe conditions എന്നിവ തടയുകയും project quality and safety standards ഉറപ്പാക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Clear procedures establish ചെയ്യുക, quality and safety risks identify ചെയ്യുക, responsibilities define ചെയ്യുക, inspections നടത്തുക, nonconformities control ചെയ്യുക, corrective actions implement ചെയ്യുക, records maintain ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management integrated management system establish ചെയ്യണം. Quality and HSE teams compliance monitor ചെയ്യണം. Supervisors procedures implement ചെയ്യണം. Workers approved methods follow ചെയ്യുകയും problems report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Quality and Safety Checklist',
        'Malayalam_checklistText':
            'Procedures available ആണോ, responsibilities defined ആണോ, risk assessments completed ആണോ, inspections നടത്തിയോ, materials and equipment checked ആണോ, nonconformities recorded ആണോ, corrective actions tracked ആണോ, records maintained ആണോ എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Approved procedures ഇല്ലാതെ work ചെയ്യുന്നത്, poor inspection, uncontrolled changes, repeated nonconformities, incomplete records, corrective actions implement ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Planning ഘട്ടത്തിൽ തന്നെ quality and safety integrate ചെയ്യുക, critical stages-ൽ inspections നടത്തുക, reporting encourage ചെയ്യുക, failures investigate ചെയ്യുക, procedures and controls continuously improve ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company QHSE procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, ISO management system principles, approved project procedures.',

        'Tamil_title': 'Quality and Safety Management',
        'Tamil_what': 'Quality and Safety Management என்றால் என்ன?',
        'Tamil_whatText':
            'Required quality standards-க்கு ஏற்ப வேலை பாதுகாப்பாக முடிக்கப்படுவதையும் workers, public, property மற்றும் environment பாதுகாக்கப்படுவதையும் உறுதி செய்யும் integrated management approach ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Defects, incidents மற்றும் unsafe conditions-ஐ தடுத்து project quality மற்றும் safety standards-ஐ உறுதி செய்வது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Clear procedures establish செய்து, quality மற்றும் safety risks identify செய்து, responsibilities define செய்து, inspections நடத்தி, nonconformities control செய்து, corrective actions implement செய்து records maintain செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management integrated management system establish செய்ய வேண்டும். Quality மற்றும் HSE teams compliance monitor செய்ய வேண்டும். Supervisors procedures implement செய்ய வேண்டும். Workers approved methods follow செய்து problems report செய்ய வேண்டும்.',
        'Tamil_checklist': 'Quality and Safety Checklist',
        'Tamil_checklistText':
            'Procedures, responsibilities, risk assessments, inspections, materials, equipment, nonconformities, corrective actions மற்றும் records ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Approved procedures இல்லாமல் வேலை செய்வது, poor inspection, uncontrolled changes, repeated nonconformities, incomplete records மற்றும் corrective actions implement செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Planning-ல் quality மற்றும் safety-ஐ integrate செய்து, critical stages-ல் inspections நடத்தி, reporting-ஐ encourage செய்து, failures-ஐ investigate செய்து continuous improvement செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company QHSE procedures, applicable ADOSH-SF requirements, relevant UAE legislation, ISO management system principles மற்றும் approved project procedures.',
      },
      {
        'letter': 'R',
        'title': 'Risk Assessment',
        'desc':
            'Systematic identification of hazards, evaluation of risks and implementation of suitable control measures.',
        'English_title': 'Risk Assessment',
        'English_what': 'What is Risk Assessment?',
        'English_whatText':
            'Risk Assessment is a systematic process of identifying hazards, evaluating the likelihood and severity of harm and determining appropriate control measures.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify hazards before they cause harm and reduce risks to an acceptable level through effective controls.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Identify hazards, determine who may be harmed, assess likelihood and severity, establish controls, record findings, communicate the assessment and review it when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides resources and ensures risk assessment arrangements. HSE professionals and competent persons conduct assessments. Supervisors implement controls and workers follow them.',
        'English_checklist': 'Risk Assessment Checklist',
        'English_checklistText':
            'Hazards identified, affected persons identified, risks assessed, hierarchy of controls applied, controls implemented, workers briefed, records maintained and assessment reviewed.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Generic risk assessment, missed hazards, incorrect risk ratings, inadequate controls, failure to communicate risks and using an outdated assessment.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use competent assessors, involve workers, consider routine and non-routine activities, apply the hierarchy of controls and review assessments whenever significant changes occur.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company risk assessment procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Risk Assessment',
        'Hindi_what': 'Risk Assessment क्या है?',
        'Hindi_whatText':
            'Risk Assessment hazards की पहचान करने, harm की likelihood और severity का मूल्यांकन करने तथा उचित control measures निर्धारित करने की systematic process है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Harm होने से पहले hazards की पहचान करना और effective controls के माध्यम से risks को acceptable level तक कम करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Hazards identify करें, affected persons identify करें, likelihood और severity assess करें, controls establish करें, findings record करें और conditions बदलने पर review करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management resources और arrangements प्रदान करे। Competent persons assessment करें। Supervisors controls लागू करें और workers उनका पालन करें।',
        'Hindi_checklist': 'Risk Assessment Checklist',
        'Hindi_checklistText':
            'Hazards, affected persons, risk assessment, hierarchy of controls, controls, worker briefing, records और review की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Generic risk assessment, missed hazards, incorrect risk rating, inadequate controls, risks communicate न करना और outdated assessment का उपयोग करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Competent assessors का उपयोग करें, workers को involve करें, routine और non-routine activities consider करें तथा significant changes पर assessment review करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company risk assessment procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Risk Assessment',
        'Malayalam_what': 'Risk Assessment എന്താണ്?',
        'Malayalam_whatText':
            'Hazards തിരിച്ചറിയുകയും, harm സംഭവിക്കാനുള്ള likelihood-ഉം severity-ഉം വിലയിരുത്തുകയും, ആവശ്യമായ control measures നിശ്ചയിക്കുകയും ചെയ്യുന്ന systematic process ആണ് Risk Assessment.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Harm ഉണ്ടാകുന്നതിന് മുമ്പ് hazards തിരിച്ചറിയുകയും effective controls ഉപയോഗിച്ച് risks acceptable level-ലേക്ക് കുറയ്ക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Hazards identify ചെയ്യുക, affected persons കണ്ടെത്തുക, likelihood and severity assess ചെയ്യുക, controls establish ചെയ്യുക, findings record ചെയ്യുക, assessment communicate ചെയ്യുക, conditions മാറുമ്പോൾ review ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management resources നൽകണം. Competent persons risk assessment നടത്തണം. Supervisors controls implement ചെയ്യണം. Workers controls പാലിക്കണം.',
        'Malayalam_checklist': 'Risk Assessment Checklist',
        'Malayalam_checklistText':
            'Hazards identified, affected persons, risk assessment, hierarchy of controls, controls implemented, worker briefing, records and review എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Generic risk assessment, hazards miss ചെയ്യുന്നത്, incorrect risk rating, inadequate controls, risks communicate ചെയ്യാത്തത്, outdated assessment ഉപയോഗിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Competent assessors ഉപയോഗിക്കുക, workers-നെ involve ചെയ്യുക, routine/non-routine activities consider ചെയ്യുക, hierarchy of controls apply ചെയ്യുക, significant changes വന്നാൽ assessment review ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company risk assessment procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Risk Assessment',
        'Tamil_what': 'Risk Assessment என்றால் என்ன?',
        'Tamil_whatText':
            'Hazards-ஐ identify செய்து, harm ஏற்படும் likelihood மற்றும் severity-ஐ assess செய்து, suitable control measures நிர்ணயிக்கும் systematic process ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Harm ஏற்படும் முன் hazards-ஐ identify செய்து effective controls மூலம் risks-ஐ acceptable level-க்கு குறைப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Hazards identify செய்து, affected persons-ஐ identify செய்து, likelihood மற்றும் severity assess செய்து, controls establish செய்து, findings record செய்து, conditions மாறும்போது review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management resources வழங்க வேண்டும். Competent persons risk assessment செய்ய வேண்டும். Supervisors controls implement செய்ய வேண்டும். Workers controls-ஐ follow செய்ய வேண்டும்.',
        'Tamil_checklist': 'Risk Assessment Checklist',
        'Tamil_checklistText':
            'Hazards, affected persons, risk assessment, hierarchy of controls, controls, worker briefing, records மற்றும் review ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Generic risk assessment, hazards miss செய்வது, incorrect risk rating, inadequate controls, risks communicate செய்யாதது மற்றும் outdated assessment பயன்படுத்துவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Competent assessors-ஐ பயன்படுத்தி, workers-ஐ involve செய்து, routine மற்றும் non-routine activities-ஐ consider செய்து, significant changes ஏற்பட்டால் assessment review செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company risk assessment procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'S',
        'title': 'Safe Work Method Statement',
        'desc':
            'A documented method describing how a task will be performed safely and with appropriate controls.',
        'English_title': 'Safe Work Method Statement',
        'English_what': 'What is a Safe Work Method Statement?',
        'English_whatText':
            'A Safe Work Method Statement (SWMS) describes the steps, hazards, risks and control measures for carrying out a specific task safely.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To provide workers with a clear and safe method for performing high-risk or significant work activities.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Define the task, identify hazards, assess risks, specify controls, assign responsibilities, communicate the method and review it when work conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management approves suitable procedures. HSE and supervisors verify implementation. Workers understand and follow the approved safe work method.',
        'English_checklist': 'SWMS Checklist',
        'English_checklistText':
            'Task defined, hazards identified, risks assessed, controls established, responsibilities assigned, workers briefed, required PPE identified and SWMS reviewed when conditions change.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without an approved method statement, generic documents, missing hazards, inadequate controls, failure to brief workers and using an outdated SWMS.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Make the SWMS task-specific, involve competent workers, link it with the risk assessment and JSA, brief the workforce before starting and review it after significant changes.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company SWMS/method statement procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Safe Work Method Statement',
        'Hindi_what': 'Safe Work Method Statement क्या है?',
        'Hindi_whatText':
            'SWMS एक documented method है जो किसी specific task को safely करने के steps, hazards, risks और control measures बताता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers को high-risk या significant activities को safely perform करने के लिए clear method प्रदान करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Task define करें, hazards identify करें, risks assess करें, controls specify करें, responsibilities assign करें और workers को method communicate करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management suitable procedures approve करे। HSE और supervisors implementation verify करें। Workers approved safe work method follow करें।',
        'Hindi_checklist': 'SWMS Checklist',
        'Hindi_checklistText':
            'Task, hazards, risks, controls, responsibilities, worker briefing, PPE और SWMS review की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Approved method statement के बिना काम करना, generic document, missing hazards, inadequate controls, worker briefing न करना और outdated SWMS का उपयोग करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'SWMS को task-specific रखें, competent workers को involve करें, risk assessment और JSA से link करें तथा significant changes पर review करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company SWMS/method statement procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Safe Work Method Statement',
        'Malayalam_what': 'Safe Work Method Statement എന്താണ്?',
        'Malayalam_whatText':
            'ഒരു specific task സുരക്ഷിതമായി ചെയ്യുന്നതിനുള്ള steps, hazards, risks, control measures എന്നിവ രേഖപ്പെടുത്തുന്ന documented method ആണ് SWMS.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'High-risk അല്ലെങ്കിൽ significant work activities സുരക്ഷിതമായി ചെയ്യാൻ workers-ന് clear method നൽകുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Task define ചെയ്യുക, hazards identify ചെയ്യുക, risks assess ചെയ്യുക, controls specify ചെയ്യുക, responsibilities assign ചെയ്യുക, method workers-നെ communicate ചെയ്യുക, conditions മാറുമ്പോൾ review ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management suitable procedures approve ചെയ്യണം. HSE and supervisors implementation verify ചെയ്യണം. Workers approved safe work method follow ചെയ്യണം.',
        'Malayalam_checklist': 'SWMS Checklist',
        'Malayalam_checklistText':
            'Task, hazards, risks, controls, responsibilities, worker briefing, PPE, conditions change വന്നാൽ SWMS review എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Approved method statement ഇല്ലാതെ work ചെയ്യുന്നത്, generic document ഉപയോഗിക്കുന്നത്, hazards missing, inadequate controls, workers-ന് briefing നൽകാത്തത്, outdated SWMS ഉപയോഗിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'SWMS task-specific ആക്കുക, competent workers-നെ involve ചെയ്യുക, risk assessment/JSA-യുമായി link ചെയ്യുക, work തുടങ്ങുന്നതിന് മുമ്പ് workforce brief ചെയ്യുക, significant changes വന്നാൽ review ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company SWMS/method statement procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Safe Work Method Statement',
        'Tamil_what': 'Safe Work Method Statement என்றால் என்ன?',
        'Tamil_whatText':
            'ஒரு specific task-ஐ பாதுகாப்பாக செய்ய வேண்டிய steps, hazards, risks மற்றும் control measures ஆகியவற்றை விளக்கும் documented method ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'High-risk அல்லது significant work activities-ஐ பாதுகாப்பாக செய்ய workers-க்கு clear method வழங்குவது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Task-ஐ define செய்து, hazards identify செய்து, risks assess செய்து, controls specify செய்து, responsibilities assign செய்து, method-ஐ workers-க்கு communicate செய்து, conditions மாறும்போது review செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management suitable procedures approve செய்ய வேண்டும். HSE மற்றும் supervisors implementation verify செய்ய வேண்டும். Workers approved safe work method-ஐ follow செய்ய வேண்டும்.',
        'Tamil_checklist': 'SWMS Checklist',
        'Tamil_checklistText':
            'Task, hazards, risks, controls, responsibilities, worker briefing, PPE மற்றும் SWMS review ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Approved method statement இல்லாமல் வேலை செய்வது, generic document, missing hazards, inadequate controls, worker briefing இல்லாதது மற்றும் outdated SWMS பயன்படுத்துவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'SWMS-ஐ task-specific ஆக வைத்து, competent workers-ஐ involve செய்து, risk assessment மற்றும் JSA-வுடன் link செய்து, significant changes ஏற்பட்டால் review செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company SWMS/method statement procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'T',
        'title': 'Toolbox Talk',
        'desc':
            'A short safety briefing conducted before work to communicate task hazards, controls and safe working practices.',
        'English_title': 'Toolbox Talk',
        'English_what': 'What is a Toolbox Talk?',
        'English_whatText':
            'A Toolbox Talk is a short, focused safety meeting held before or during work to discuss specific hazards, controls and safe work practices.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To ensure workers understand the hazards and controls associated with the task and are prepared to work safely.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Select the topic, discuss task-specific hazards and controls, allow worker questions, record attendance and repeat or update the briefing when conditions change.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Supervisors or competent persons conduct toolbox talks. HSE supports the process. Workers attend, participate, ask questions and follow the communicated controls.',
        'English_checklist': 'Toolbox Talk Checklist',
        'English_checklistText':
            'Topic relevant, hazards discussed, controls explained, PPE discussed, emergency arrangements communicated, attendance recorded and worker understanding confirmed.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Toolbox talks not conducted, irrelevant topics, attendance recorded without actual briefing, poor communication and failure to update the briefing after changes.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Keep toolbox talks short and task-specific, use real site examples, encourage worker participation and verify understanding before work begins.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company toolbox talk procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Toolbox Talk',
        'Hindi_what': 'Toolbox Talk क्या है?',
        'Hindi_whatText':
            'Toolbox Talk एक short और focused safety meeting है जिसमें specific hazards, controls और safe work practices पर चर्चा की जाती है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Workers को task के hazards और controls समझाना तथा सुरक्षित काम के लिए तैयार करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Relevant topic चुनें, task-specific hazards और controls discuss करें, worker questions लें, attendance record करें और conditions बदलने पर briefing update करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Supervisors या competent persons toolbox talks conduct करें। HSE support करे। Workers attend और participate करें तथा controls follow करें।',
        'Hindi_checklist': 'Toolbox Talk Checklist',
        'Hindi_checklistText':
            'Topic, hazards, controls, PPE, emergency arrangements, attendance और worker understanding की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Toolbox talk न करना, irrelevant topic, बिना briefing attendance record करना, poor communication और changes के बाद briefing update न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Toolbox talk को short और task-specific रखें, real site examples उपयोग करें और work शुरू होने से पहले worker understanding verify करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company toolbox talk procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Toolbox Talk',
        'Malayalam_what': 'Toolbox Talk എന്താണ്?',
        'Malayalam_whatText':
            'Work തുടങ്ങുന്നതിന് മുമ്പ് അല്ലെങ്കിൽ work സമയത്ത് specific hazards, controls, safe work practices എന്നിവ ചർച്ച ചെയ്യുന്നതിനുള്ള short safety briefing ആണ് Toolbox Talk.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Task-നുമായി ബന്ധപ്പെട്ട hazards and controls workers മനസ്സിലാക്കിയിട്ടുണ്ടെന്ന് ഉറപ്പാക്കുകയും safe work-ന് തയ്യാറാക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Relevant topic തിരഞ്ഞെടുക്കുക, task-specific hazards and controls discuss ചെയ്യുക, workers-ന്റെ questions സ്വീകരിക്കുക, attendance record ചെയ്യുക, conditions മാറുമ്പോൾ briefing update ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Supervisors അല്ലെങ്കിൽ competent persons toolbox talk conduct ചെയ്യണം. HSE support നൽകണം. Workers attend ചെയ്യുകയും participate ചെയ്യുകയും controls പാലിക്കുകയും വേണം.',
        'Malayalam_checklist': 'Toolbox Talk Checklist',
        'Malayalam_checklistText':
            'Topic relevant ആണോ, hazards discuss ചെയ്തോ, controls explain ചെയ്തോ, PPE discuss ചെയ്തോ, emergency arrangements communicate ചെയ്തോ, attendance record ചെയ്തോ, worker understanding confirm ചെയ്തോ എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Toolbox talk നടത്താത്തത്, irrelevant topic, briefing ഇല്ലാതെ attendance record ചെയ്യുന്നത്, poor communication, changes വന്നിട്ടും briefing update ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Toolbox talk short and task-specific ആക്കുക, real site examples ഉപയോഗിക്കുക, worker participation encourage ചെയ്യുക, work തുടങ്ങുന്നതിന് മുമ്പ് understanding verify ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company toolbox talk procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Toolbox Talk',
        'Tamil_what': 'Toolbox Talk என்றால் என்ன?',
        'Tamil_whatText':
            'வேலை தொடங்குவதற்கு முன் அல்லது வேலை நேரத்தில் specific hazards, controls மற்றும் safe work practices பற்றி விவாதிக்கும் short safety briefing ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Task-க்கு தொடர்புடைய hazards மற்றும் controls-ஐ workers புரிந்துகொண்டு பாதுகாப்பாக வேலை செய்யத் தயாராக இருப்பதை உறுதி செய்வது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Relevant topic தேர்வு செய்து, task-specific hazards மற்றும் controls discuss செய்து, worker questions-ஐ கேட்டு, attendance record செய்து, conditions மாறும்போது briefing update செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Supervisors அல்லது competent persons toolbox talks conduct செய்ய வேண்டும். HSE support வழங்க வேண்டும். Workers attend செய்து participate செய்து controls-ஐ follow செய்ய வேண்டும்.',
        'Tamil_checklist': 'Toolbox Talk Checklist',
        'Tamil_checklistText':
            'Topic, hazards, controls, PPE, emergency arrangements, attendance மற்றும் worker understanding ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Toolbox talk நடத்தாதது, irrelevant topic, briefing இல்லாமல் attendance record செய்வது, poor communication மற்றும் changes ஏற்பட்ட பிறகு briefing update செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Toolbox talk-ஐ short மற்றும் task-specific ஆக வைத்து, real site examples பயன்படுத்தி, worker participation-ஐ encourage செய்து, வேலை தொடங்குவதற்கு முன் understanding-ஐ verify செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company toolbox talk procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'U',
        'title': 'Unsafe Acts and Conditions',
        'desc':
            'Unsafe worker behaviours and hazardous workplace conditions that can contribute to incidents and injuries.',
        'English_title': 'Unsafe Acts and Conditions',
        'English_what': 'What are Unsafe Acts and Conditions?',
        'English_whatText':
            'Unsafe acts are unsafe behaviours or actions by people, while unsafe conditions are hazardous physical or environmental conditions in the workplace.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To identify and correct unsafe behaviours and workplace conditions before they result in incidents or injuries.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Conduct inspections and observations, identify unsafe acts and conditions, apply immediate controls where possible, report findings and track corrective actions.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides a reporting and corrective action system. Supervisors correct unsafe conditions and behaviours. Workers report hazards and follow safe work practices.',
        'English_checklist': 'Unsafe Acts and Conditions Checklist',
        'English_checklistText':
            'Unsafe behaviour identified, hazardous condition identified, immediate action taken, responsible person assigned, corrective action recorded and closure verified.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Ignoring hazards, bypassing safety procedures, improper PPE use, poor housekeeping, unsafe equipment condition and failure to report unsafe situations.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use positive safety observations, correct unsafe conditions promptly, coach workers respectfully and verify that corrective actions are effectively closed.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company inspection and observation procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Unsafe Acts and Conditions',
        'Hindi_what': 'Unsafe Acts and Conditions क्या हैं?',
        'Hindi_whatText':
            'Unsafe acts workers के unsafe behaviours या actions हैं, जबकि unsafe conditions workplace की hazardous physical या environmental conditions हैं।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Incidents या injuries होने से पहले unsafe behaviours और conditions की पहचान और correction करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Inspections और observations करें, unsafe acts और conditions identify करें, immediate controls लागू करें, findings report करें और corrective actions track करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management reporting और corrective action system प्रदान करे। Supervisors unsafe conditions और behaviours correct करें। Workers hazards report करें और safe practices follow करें।',
        'Hindi_checklist': 'Unsafe Acts and Conditions Checklist',
        'Hindi_checklistText':
            'Unsafe behaviour, hazardous condition, immediate action, responsible person, corrective action और closure verification की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Hazards ignore करना, safety procedures bypass करना, improper PPE, poor housekeeping, unsafe equipment और unsafe situations report न करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Positive safety observations करें, unsafe conditions को तुरंत correct करें, workers को respectfully coach करें और corrective actions की effective closure verify करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company inspection and observation procedures, applicable ADOSH-SF requirements, relevant UAE legislation और approved project safety procedures।',

        'Malayalam_title': 'Unsafe Acts and Conditions',
        'Malayalam_what': 'Unsafe Acts and Conditions എന്താണ്?',
        'Malayalam_whatText':
            'Workers ചെയ്യുന്ന unsafe behaviours അല്ലെങ്കിൽ actions ആണ് Unsafe Acts. Workplace-ലുള്ള hazardous physical അല്ലെങ്കിൽ environmental conditions ആണ് Unsafe Conditions.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Incident അല്ലെങ്കിൽ injury ഉണ്ടാകുന്നതിന് മുമ്പ് unsafe behaviours and conditions തിരിച്ചറിഞ്ഞ് correct ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Inspections and observations നടത്തുക, unsafe acts and conditions identify ചെയ്യുക, കഴിയുന്നിടത്ത് immediate controls apply ചെയ്യുക, findings report ചെയ്യുക, corrective actions track ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management reporting and corrective action system നൽകണം. Supervisors unsafe conditions and behaviours correct ചെയ്യണം. Workers hazards report ചെയ്യുകയും safe work practices പാലിക്കുകയും വേണം.',
        'Malayalam_checklist': 'Unsafe Acts and Conditions Checklist',
        'Malayalam_checklistText':
            'Unsafe behaviour, hazardous condition, immediate action, responsible person, corrective action, closure verification എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Hazards ignore ചെയ്യുന്നത്, safety procedures bypass ചെയ്യുന്നത്, improper PPE use, poor housekeeping, unsafe equipment condition, unsafe situations report ചെയ്യാത്തത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Positive safety observations ഉപയോഗിക്കുക, unsafe conditions ഉടൻ correct ചെയ്യുക, workers-നെ respectful ആയി coach ചെയ്യുക, corrective actions effectively closed ആണെന്ന് verify ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company inspection and observation procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation, approved project safety procedures.',

        'Tamil_title': 'Unsafe Acts and Conditions',
        'Tamil_what': 'Unsafe Acts and Conditions என்றால் என்ன?',
        'Tamil_whatText':
            'Workers செய்யும் unsafe behaviours அல்லது actions Unsafe Acts ஆகும். Workplace-ல் உள்ள hazardous physical அல்லது environmental conditions Unsafe Conditions ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Incident அல்லது injury ஏற்படும் முன் unsafe behaviours மற்றும் conditions-ஐ identify செய்து correct செய்வது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Inspections மற்றும் observations நடத்தி, unsafe acts மற்றும் conditions identify செய்து, immediate controls apply செய்து, findings report செய்து, corrective actions track செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management reporting மற்றும் corrective action system வழங்க வேண்டும். Supervisors unsafe conditions மற்றும் behaviours-ஐ correct செய்ய வேண்டும். Workers hazards report செய்து safe work practices follow செய்ய வேண்டும்.',
        'Tamil_checklist': 'Unsafe Acts and Conditions Checklist',
        'Tamil_checklistText':
            'Unsafe behaviour, hazardous condition, immediate action, responsible person, corrective action மற்றும் closure verification ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Hazards ignore செய்வது, safety procedures bypass செய்வது, improper PPE use, poor housekeeping, unsafe equipment condition மற்றும் unsafe situations report செய்யாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Positive safety observations பயன்படுத்தி, unsafe conditions-ஐ உடனடியாக correct செய்து, workers-ஐ respectfully coach செய்து, corrective actions effective closure verify செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company inspection and observation procedures, applicable ADOSH-SF requirements, relevant UAE legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'V',
        'title': 'Vehicle and Traffic Safety',
        'desc':
            'Controls for safe operation, movement and management of vehicles and mobile equipment in the workplace.',
        'English_title': 'Vehicle and Traffic Safety',
        'English_what': 'What is Vehicle and Traffic Safety?',
        'English_whatText':
            'Vehicle and Traffic Safety involves managing vehicle movement, mobile equipment and pedestrian interaction to prevent collisions, struck-by incidents and other traffic-related injuries.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent vehicle-related incidents and protect drivers, pedestrians, workers, visitors and the public.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Establish traffic management arrangements, inspect vehicles, authorize competent drivers, control speed, segregate pedestrians, maintain clear routes and use appropriate warning and reversing controls.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management establishes traffic controls and provides suitable vehicles. Supervisors enforce site traffic rules. Drivers conduct checks and operate vehicles safely. Pedestrians follow designated routes.',
        'English_checklist': 'Vehicle and Traffic Safety Checklist',
        'English_checklistText':
            'Vehicle inspected, driver authorized, seat belts used, speed limits followed, pedestrian routes separated, reversing controls available, parking controlled and vehicle defects reported.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Speeding, unauthorized driving, seat belt non-use, unsafe reversing, poor vehicle condition, pedestrian and vehicle route mixing and mobile phone use while driving.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Use a clear traffic management plan, segregate pedestrians and vehicles, maintain vehicles properly, use trained drivers and eliminate unnecessary reversing wherever practicable.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company vehicle and traffic management procedures, applicable ADOSH-SF requirements, relevant UAE traffic legislation and approved project safety procedures.',

        'Hindi_title': 'Vehicle and Traffic Safety',
        'Hindi_what': 'Vehicle and Traffic Safety क्या है?',
        'Hindi_whatText':
            'Vehicle movement, mobile equipment और pedestrians के interaction को manage करके collisions, struck-by incidents और traffic-related injuries को रोकने की प्रक्रिया है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'Vehicle-related incidents को रोकना और drivers, pedestrians, workers, visitors तथा public की सुरक्षा करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'Traffic management arrangements बनाएं, vehicles inspect करें, competent drivers authorize करें, speed control करें, pedestrians segregate करें और reversing controls लागू करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management traffic controls और suitable vehicles प्रदान करे। Supervisors site traffic rules enforce करें। Drivers vehicle checks करें और safely operate करें। Pedestrians designated routes follow करें।',
        'Hindi_checklist': 'Vehicle and Traffic Safety Checklist',
        'Hindi_checklistText':
            'Vehicle inspection, authorized driver, seat belt, speed limit, pedestrian segregation, reversing controls, parking और defect reporting की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Speeding, unauthorized driving, seat belt न लगाना, unsafe reversing, poor vehicle condition, pedestrian-vehicle route mixing और driving के दौरान mobile phone use करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'Clear traffic management plan रखें, pedestrians और vehicles को segregate करें, vehicles maintain करें, trained drivers उपयोग करें और unnecessary reversing को eliminate करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company vehicle and traffic management procedures, applicable ADOSH-SF requirements, relevant UAE traffic legislation और approved project safety procedures।',

        'Malayalam_title': 'Vehicle and Traffic Safety',
        'Malayalam_what': 'Vehicle and Traffic Safety എന്താണ്?',
        'Malayalam_whatText':
            'Vehicles, mobile equipment, pedestrians എന്നിവയുടെ movement manage ചെയ്ത് collisions, struck-by incidents, traffic-related injuries എന്നിവ തടയുന്ന safety system ആണ് Vehicle and Traffic Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'Vehicle-related incidents തടയുകയും drivers, pedestrians, workers, visitors, public എന്നിവരെ സംരക്ഷിക്കുകയും ചെയ്യുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Traffic management arrangements establish ചെയ്യുക, vehicles inspect ചെയ്യുക, competent drivers authorize ചെയ്യുക, speed control ചെയ്യുക, pedestrians segregate ചെയ്യുക, clear routes maintain ചെയ്യുക, reversing controls ഉപയോഗിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management traffic controls and suitable vehicles നൽകണം. Supervisors site traffic rules enforce ചെയ്യണം. Drivers vehicle checks നടത്തി safe ആയി operate ചെയ്യണം. Pedestrians designated routes follow ചെയ്യണം.',
        'Malayalam_checklist': 'Vehicle and Traffic Safety Checklist',
        'Malayalam_checklistText':
            'Vehicle inspected, driver authorized, seat belt used, speed limits followed, pedestrian routes separated, reversing controls, parking control, vehicle defects reporting എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Speeding, unauthorized driving, seat belt ഉപയോഗിക്കാത്തത്, unsafe reversing, poor vehicle condition, pedestrian-vehicle route mixing, driving സമയത്ത് mobile phone ഉപയോഗിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Clear traffic management plan ഉപയോഗിക്കുക, pedestrians and vehicles segregate ചെയ്യുക, vehicles properly maintain ചെയ്യുക, trained drivers ഉപയോഗിക്കുക, unnecessary reversing കഴിയുന്നത്ര ഒഴിവാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company vehicle and traffic management procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE traffic legislation, approved project safety procedures.',

        'Tamil_title': 'Vehicle and Traffic Safety',
        'Tamil_what': 'Vehicle and Traffic Safety என்றால் என்ன?',
        'Tamil_whatText':
            'Vehicles, mobile equipment மற்றும் pedestrians movement-ஐ manage செய்து collisions, struck-by incidents மற்றும் traffic-related injuries-ஐ தடுக்கும் safety system ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'Vehicle-related incidents-ஐ தடுப்பதும் drivers, pedestrians, workers, visitors மற்றும் public-ஐ பாதுகாப்பதும் ஆகும்.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Traffic management arrangements establish செய்து, vehicles inspect செய்து, competent drivers authorize செய்து, speed control செய்து, pedestrians segregate செய்து, clear routes maintain செய்து, reversing controls பயன்படுத்த வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management traffic controls மற்றும் suitable vehicles வழங்க வேண்டும். Supervisors site traffic rules enforce செய்ய வேண்டும். Drivers vehicle checks செய்து safely operate செய்ய வேண்டும். Pedestrians designated routes follow செய்ய வேண்டும்.',
        'Tamil_checklist': 'Vehicle and Traffic Safety Checklist',
        'Tamil_checklistText':
            'Vehicle inspection, authorized driver, seat belt, speed limits, pedestrian segregation, reversing controls, parking control மற்றும் defect reporting ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Speeding, unauthorized driving, seat belt பயன்படுத்தாதது, unsafe reversing, poor vehicle condition, pedestrian-vehicle route mixing மற்றும் driving போது mobile phone பயன்படுத்துவது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Clear traffic management plan பயன்படுத்தி, pedestrians மற்றும் vehicles-ஐ segregate செய்து, vehicles-ஐ properly maintain செய்து, trained drivers பயன்படுத்தி, unnecessary reversing-ஐ முடிந்தவரை eliminate செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company vehicle and traffic management procedures, applicable ADOSH-SF requirements, relevant UAE traffic legislation மற்றும் approved project safety procedures.',
      },
      {
        'letter': 'W',
        'title': 'Work at Height',
        'desc':
            'Safety requirements and control measures for preventing falls while working at height.',
        'English_title': 'Work at Height',
        'English_what': 'What is Work at Height?',
        'English_whatText':
            'Work at Height means any work where a person could fall from one level to another and suffer injury.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent falls from height, falling objects and serious injuries during elevated work activities.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Avoid work at height where possible, use existing safe places, use work equipment to prevent falls, mitigate distance and consequences of a fall, provide proper access and inspect equipment regularly.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management provides safe access equipment and training. Supervisors inspect work areas and enforce controls. Workers use harnesses, scaffolds and ladders safely and report defects.',
        'English_checklist': 'Work at Height Checklist',
        'English_checklistText':
            'Risk assessment done, scaffold tagged/inspected, ladders secured, harness/fall arrest inspected, edge protection in place, weather conditions checked and workers competent.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Working without fall protection, uninspected scaffolding, standing on top of ladders, lack of edge protection and working at height during high winds.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Plan all work at height thoroughly, prioritize collective protection over personal protection, ensure 100% tie-off when using harnesses and inspect equipment before every shift.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company work at height procedures, applicable ADOSH-SF requirements, relevant UAE legislation and approved project safety procedures.',

        'Hindi_title': 'Work at Height',
        'Hindi_what': 'Work at Height क्या है?',
        'Hindi_whatText':
            'Work at Height का मतलब ऐसा कोई भी काम है जहाँ व्यक्ति ऊँचाई से गिर सकता है और घायल हो सकता है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'ऊँचाई से गिरने वाली घटनाओं, गिरती हुई वस्तुओं और गंभीर चोटों को रोकना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'संभव हो तो ऊँचाई के काम से बचें, सुरक्षित उपकरण (scaffolds, ladders) का उपयोग करें, edge protection दें और नियमित रूप से उपकरणों की जाँच करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management सुरक्षित उपकरण और प्रशिक्षण दे। Supervisors कार्यक्षेत्र की जाँच करें। Workers harnesses और scaffolds का सही उपयोग करें।',
        'Hindi_checklist': 'Work at Height Checklist',
        'Hindi_checklistText':
            'Risk assessment, scaffold tag, ladder security, harness inspection, edge protection और weather check की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'Fall protection के बिना काम करना, बिना निरीक्षण का मचान (scaffold), सीढ़ी के सबसे ऊपर खड़े होना और खराब मौसम में काम करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'ऊँचाई के काम की पूरी योजना बनाएँ, व्यक्तिगत सुरक्षा से पहले सामूहिक सुरक्षा को प्राथमिकता दें और हर शिफ्ट से पहले उपकरणों की जाँच करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company work at height procedures, applicable ADOSH-SF requirements और relevant UAE legislation।',

        'Malayalam_title': 'Work at Height',
        'Malayalam_what': 'Work at Height എന്താണ്?',
        'Malayalam_whatText':
            'ഉയരത്തിൽ ജോലി ചെയ്യുമ്പോൾ താഴേക്ക് വീണ് പരിക്കുകൾ പറ്റാൻ സാധ്യതയുള്ള ഏത് ജോലിയെയും Work at Height എന്ന് വിളിക്കുന്നു.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഉയരത്തിൽ നിന്നുള്ള വീഴ്ചകൾ തടയുക, വീഴുന്ന വസ്തുക്കളിൽ നിന്നുള്ള പരിക്കുകൾ ഒഴിവാക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'സാധ്യമെങ്കിൽ ഉയരത്തിലുള്ള ജോലി ഒഴിവാക്കുക, സുരക്ഷിതമായ access equipment ഉപയോഗിക്കുക, edge protection നൽകുക, equipment নিয়মিত inspect ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management സുരക്ഷിത ഉപകരണങ്ങളും training-ഉം നൽകണം. Supervisors സുരക്ഷ ഉറപ്പാക്കണം. Workers harnesses ശരിയായി ഉപയോഗിക്കുകയും defects report ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Work at Height Checklist',
        'Malayalam_checklistText':
            'Risk assessment, scaffold inspection, ladder security, harness check, edge protection, weather check എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Fall protection ഇല്ലാതെ ജോലി ചെയ്യൽ, inspect ചെയ്യാത്ത scaffolding ഉപയോഗിക്കൽ, ladder-ന്റെ ഏറ്റവും മുകളിൽ നിൽക്കൽ, edge protection ഇല്ലാതിരിക്കൽ.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Work at height നന്നായി plan ചെയ്യുക, collective protection-ന് മുൻഗണന നൽകുക, harness ഉപയോഗിക്കുമ്പോൾ 100% tie-off ഉറപ്പാക്കുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company work at height procedures, ബാധകമായ ADOSH-SF requirements, relevant UAE legislation.',

        'Tamil_title': 'Work at Height',
        'Tamil_what': 'Work at Height என்றால் என்ன?',
        'Tamil_whatText':
            'உயரத்தில் வேலை செய்யும் போது ஒரு மட்டத்திலிருந்து மற்றொரு மட்டத்திற்கு கீழே விழுந்து காயம் ஏற்படும் எந்தவொரு வேலையும் Work at Height ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'உயரத்திலிருந்து விழுவதைத் தவிர்ப்பது மற்றும் தீவிர காயங்கள் ஏற்படுவதைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'முடிந்தவரை உயரமான வேலையைத் தவிர்ப்பது, பாதுகாப்பான உபகரணங்களைப் பயன்படுத்துவது, edge protection வழங்குவது மற்றும் உபகரணங்களை தொடர்ந்து பரிசோதிப்பது.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management பாதுகாப்பு உபகரணங்கள் மற்றும் training வழங்க வேண்டும். Supervisors பணியிடத்தை கண்காணிக்க வேண்டும். Workers safety harnesses மற்றும் scaffolds-ஐ சரியாகப் பயன்படுத்த வேண்டும்.',
        'Tamil_checklist': 'Work at Height Checklist',
        'Tamil_checklistText':
            'Risk assessment, scaffold inspection, ladder security, harness check மற்றும் edge protection ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Fall protection இல்லாமல் வேலை செய்வது, பரிசோதிக்கப்படாத scaffolding, ஏணியின் உச்சியில் நிற்பது மற்றும் edge protection இல்லாதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'வேலையை முன்கூட்டியே திட்டமிட்டு, collective protection-க்கு முன்னுரிமை அளித்து, ஒவ்வொரு முறையும் உபகரணங்களை பரிசோதிக்கவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company work at height procedures, applicable ADOSH-SF requirements மற்றும் relevant UAE legislation.',
      },
      {
        'letter': 'X',
        'title': 'X-Ray / Radiation Safety',
        'desc':
            'Safety practices for protecting workers from harmful exposure to X-rays and other sources of ionizing radiation.',
        'English_title': 'X-Ray / Radiation Safety',
        'English_what': 'What is X-Ray / Radiation Safety?',
        'English_whatText':
            'X-Ray and Radiation Safety involves controlling exposure to ionizing radiation and protecting workers and others from unnecessary radiation risks.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To prevent harmful radiation exposure and protect personnel working with or near radiation sources.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Obtain required regulatory licenses, appoint a Radiation Protection Officer (RPO), establish controlled areas, use shielding, minimize exposure time and wear personal dosimeters.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management ensures regulatory compliance and certified personnel. RPO manages radiation safety program. Workers follow radiation rules, use dosimeters and report incidents.',
        'English_checklist': 'Radiation Safety Checklist',
        'English_checklistText':
            'Regulatory permits active, RPO appointed, controlled areas barricaded and signed, radiation sources secured, dosimeters worn and emergency procedures ready.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Unauthorized radiation work, missing warning signs, failure to wear dosimeters, inadequate shielding and poor source security.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Apply ALARA (As Low As Reasonably Achievable) principle, maintain strict source accountability and conduct regular radiation surveys.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Federal Authority for Nuclear Regulation (FANR) regulations, company radiation procedures and relevant ADOSH-SF requirements.',

        'Hindi_title': 'X-Ray / Radiation Safety',
        'Hindi_what': 'X-Ray / Radiation Safety क्या है?',
        'Hindi_whatText':
            'एक्स-रे और विकिरण सुरक्षा, आयनीकरण विकिरण (ionizing radiation) के संपर्क को नियंत्रित करने और श्रमिकों को अनावश्यक जोखिमों से बचाने से संबंधित है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'हानिकारक विकिरण संपर्क को रोकना और विकिरण स्रोतों के पास काम करने वाले कर्मियों की रक्षा करना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'नियामक लाइसेंस प्राप्त करें, RPO नियुक्त करें, नियंत्रित क्षेत्र स्थापित करें, shielding का उपयोग करें और व्यक्तिगत dosimeters पहनें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management अनुपालन सुनिश्चित करे। RPO विकिरण सुरक्षा कार्यक्रम प्रबंधित करे। Workers नियमों का पालन करें और dosimeters पहनें।',
        'Hindi_checklist': 'Radiation Safety Checklist',
        'Hindi_checklistText':
            'Permits active, RPO appointed, barricades और signs, source security, dosimeters और emergency procedures की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'अनधिकृत विकिरण कार्य, चेतावनी संकेतों की कमी, dosimeters न पहनना और अपर्याप्त shielding।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'ALARA (As Low As Reasonably Achievable) सिद्धांत लागू करें और नियमित विकिरण सर्वेक्षण करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'FANR regulations, company radiation procedures और ADOSH-SF requirements।',

        'Malayalam_title': 'X-Ray / Radiation Safety',
        'Malayalam_what': 'X-Ray / Radiation Safety എന്താണ്?',
        'Malayalam_whatText':
            'Ionizing radiation exposure നിയന്ത്രിക്കുകയും തൊഴിലാളികളെയും മറ്റുള്ളവരെയും radiation അപകടങ്ങളിൽ നിന്ന് സംരക്ഷിക്കുകയും ചെയ്യുന്നതാണ് Radiation Safety.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഹാനികരമായ radiation exposure തടയുക, radiation sources-ന് அருகில் ജോലി ചെയ്യുന്നവരെ സംരക്ഷിക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Regulatory licenses നേടുക, RPO-യെ നിയമിക്കുക, controlled areas സ്ഥാപിക്കുക, shielding ഉപയോഗിക്കുക, dosimeters ധരിക്കുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management regulatory compliance ഉറപ്പാക്കണം. RPO safety program manage ചെയ്യണം. Workers rules പാലിക്കുകയും dosimeters ധരിക്കുകയും വേണം.',
        'Malayalam_checklist': 'Radiation Safety Checklist',
        'Malayalam_checklistText':
            'Permits active ആണോ, RPO appointed ആണോ, barricades & signs ഉണ്ടോ, source secured ആണോ, dosimeters ധരിച്ചോ എന്നിവ പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Unauthorized radiation work, warning signs ഇല്ലാത്തത്, dosimeters ധരിക്കാത്തത്, inadequate shielding.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'ALARA തത്വം പ്രയോഗിക്കുക, source accountability സൂക്ഷിക്കുക, নিয়মিত radiation surveys നടത്തുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'FANR Regulations, company radiation procedures, ADOSH-SF requirements.',

        'Tamil_title': 'X-Ray / Radiation Safety',
        'Tamil_what': 'X-Ray / Radiation Safety என்றால் என்ன?',
        'Tamil_whatText':
            'Ionizing radiation exposure-ஐ கட்டுப்படுத்தி workers மற்றும் மற்றவர்களை radiation ஆபத்துகளிலிருந்து பாதுகாப்பதாகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'தீங்கு விளைவிக்கும் radiation exposure-ஐ தடுத்து radiation sources அருகில் வேலை செய்பவர்களைப் பாதுகாப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Regulatory licenses பெறுவது, RPO-ஐ நியமிப்பது, controlled areas உருவாக்குவது, shielding பயன்படுத்துவது மற்றும் dosimeters அணிவது.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management compliance உறுதி செய்ய வேண்டும். RPO safety program-ஐ நிர்வகிக்க வேண்டும். Workers விதிகளைப் பின்பற்றி dosimeters அணிய வேண்டும்.',
        'Tamil_checklist': 'Radiation Safety Checklist',
        'Tamil_checklistText':
            'Permits, RPO appointment, warning signs, source security மற்றும் dosimeters ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Unauthorized radiation work, warning signs இல்லாமை, dosimeters அணியாதது மற்றும் போதிய shielding இல்லாமை.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'ALARA கொள்கையைப் பின்பற்றி, மூலப் பாதுகாப்பை உறுதி செய்து, नियमितமாக radiation surveys செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'FANR Regulations, company radiation procedures மற்றும் ADOSH-SF requirements.',
      },
      {
        'letter': 'Y',
        'title': 'Young Worker Safety',
        'desc':
            'Safety measures to protect young and inexperienced workers from workplace hazards.',
        'English_title': 'Young Worker Safety',
        'English_what': 'What is Young Worker Safety?',
        'English_whatText':
            'Young Worker Safety focuses on protecting young or inexperienced workers through proper training, supervision and risk controls.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To protect young and inexperienced workers from workplace hazards due to their lack of experience and physical maturity.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Assess risks specifically for young workers, provide comprehensive safety induction, assign close supervision, restrict hazardous or heavy tasks and ensure proper training.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management establishes young worker policies and training programs. Supervisors monitor daily work closely. Experienced mentors guide young workers safely.',
        'English_checklist': 'Young Worker Checklist',
        'English_checklistText':
            'Age/legal requirements verified, safety induction completed, mentor/supervisor assigned, hazardous tasks restricted, PPE provided and fit, regular check-ins conducted.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Assigning prohibited high-risk work, lack of supervision, inadequate training, ignoring physical limitations and assuming young workers know safety rules.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Pair young workers with experienced mentors, conduct frequent safety check-ins, encourage open communication and empower them to stop unsafe work.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HR and HSE policies, applicable UAE labor laws and relevant ADOSH-SF requirements.',

        'Hindi_title': 'Young Worker Safety',
        'Hindi_what': 'Young Worker Safety क्या है?',
        'Hindi_whatText':
            'युवा और कम अनुभवी श्रमिकों को उचित प्रशिक्षण, पर्यवेक्षण और जोखिम नियंत्रण के माध्यम से कार्यस्थल के खतरों से बचाना Young Worker Safety है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'अनुभव की कमी और शारीरिक परिपक्वता न होने के कारण年轻 श्रमिकों को कार्यस्थल के खतरों से बचाना।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'विशेष जोखिम मूल्यांकन करें, व्यापक सुरक्षा प्रेरण (induction) दें, करीबी निगरानी रखें और खतरनाक कार्यों को प्रतिबंधित करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management नीतियाँ और प्रशिक्षण दे। Supervisors दैनिक कार्य की निगरानी करें। मेंटर युवा श्रमिकों का मार्गदर्शन करें।',
        'Hindi_checklist': 'Young Worker Checklist',
        'Hindi_checklistText':
            'Age verification, safety induction, supervisor assignment, hazardous task restriction और PPE की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'निषेध उच्च जोखिम वाले काम सौंपना, पर्यवेक्षण की कमी, अपर्याप्त प्रशिक्षण और शारीरिक सीमाओं की अनदेखी करना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'युवा श्रमिकों को अनुभवी मेंटर्स के साथ जोड़ें, लगातार सुरक्षा समीक्षा करें और असुरक्षित काम रोकने के लिए प्रोत्साहित करें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company policies, UAE labor laws और ADOSH-SF requirements।',

        'Malayalam_title': 'Young Worker Safety',
        'Malayalam_what': 'Young Worker Safety എന്താണ്?',
        'Malayalam_whatText':
            'പരിചയക്കുറവുള്ള യുവ തൊഴിലാളികളെ training, supervision, risk controls എന്നിവയിലൂടെ workplace hazards-ൽ നിന്ന് സംരക്ഷിക്കുന്നതാണ് ഇത്.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'പരിചയക്കുറവും ശാരീരിക പക്വതക്കുറവും കാരണം യുവ തൊഴിലാളികൾക്ക് ഉണ്ടാകാനിടയുള്ള അപകടങ്ങൾ തടയുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Young workers-നായി പ്രത്യേക risk assessment നടത്തുക, safety induction നൽകുക, close supervision ഉറപ്പാക്കുക, dangerous tasks restrict ചെയ്യുക.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management policies ഉം training ഉം നൽകണം. Supervisors daily work monitor ചെയ്യണം. Mentors guidance നൽകണം.',
        'Malayalam_checklist': 'Young Worker Checklist',
        'Malayalam_checklistText':
            'Age verified ആണോ, induction കഴിഞ്ഞോ, supervisor assigned ആണോ, hazardous tasks restricted ആണോ എന്ന് പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'High-risk work നൽകൽ, supervision ഇല്ലാതിരിക്കൽ, training കുറവ്, physical limitations അവഗണിക്കുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'Experienced mentors-ന്റെ കൂടെ young workers-നെ നിയോഗിക്കുക, frequent safety check-ins നടത്തുക, open communication encourage ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HR/HSE policies, UAE labor laws, ADOSH-SF requirements.',

        'Tamil_title': 'Young Worker Safety',
        'Tamil_what': 'Young Worker Safety என்றால் என்ன?',
        'Tamil_whatText':
            'இளம் மற்றும் அனுபவமில்லாத தொழிலாளர்களை proper training, supervision மற்றும் risk controls மூலம் பணியிட அபாயங்களிலிருந்து பாதுகாப்பது.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'அனுபவக் குறைபாடு மற்றும் உடல் முதிர்ச்சியின்மை காரணமாக இளம் தொழிலாளர்களுக்கு ஏற்படும் விபத்துகளைத் தடுப்பது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Young workers-க்கென பிரத்யேக risk assessment செய்து, safety induction வழங்கி, close supervision மற்றும் dangerous tasks restriction உறுதி செய்ய வேண்டும்.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management கொள்கைகள் மற்றும் training வழங்க வேண்டும். Supervisors தினசரி வேலையைக் கண்காணிக்க வேண்டும். Mentors வழிகாட்ட வேண்டும்.',
        'Tamil_checklist': 'Young Worker Checklist',
        'Tamil_checklistText':
            'Age verification, safety induction, supervisor assignment மற்றும் hazardous tasks restriction ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'High-risk வேலையை வழங்குவது, supervision இல்லாமை மற்றும் போதிய training அளிக்காதது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'Experienced mentors-ஐ இளம் தொழிலாளர்களுடன் இணைத்து, தொடர்ந்து safety check-ins செய்து, பாதுகாப்பான சூழலை உறுதி செய்யவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company policies, UAE labor laws மற்றும் ADOSH-SF requirements.',
      },
      {
        'letter': 'Z',
        'title': 'Zero Harm',
        'desc':
            'A safety commitment focused on preventing workplace injuries, illnesses, incidents and environmental harm.',
        'English_title': 'Zero Harm',
        'English_what': 'What is Zero Harm?',
        'English_whatText':
            'Zero Harm is a safety goal and commitment to prevent injuries, occupational illnesses, incidents and unnecessary harm to people and the environment.',
        'English_purpose': 'Purpose',
        'English_purposeText':
            'To foster a proactive safety culture where every incident and injury is preventable, aiming for zero workplace accidents.',
        'English_requirements': 'Requirements',
        'English_requirementsText':
            'Commit to safety leadership, engage all workers, report all near misses and hazards, implement robust controls, learn from incidents and continuously improve safety performance.',
        'English_responsibilities': 'Responsibilities',
        'English_responsibilitiesText':
            'Management leads by example and provides safety resources. Supervisors enforce safety rules and support workers. Workers take personal responsibility for safety and stop unsafe work.',
        'English_checklist': 'Zero Harm Checklist',
        'English_checklistText':
            'Safety vision communicated, hazard reporting active, near misses investigated, safety meetings held, PPE compliance 100%, STOP work authority exercised when needed.',
        'English_violations': 'Common Violations',
        'English_violationsText':
            'Complacency, failure to report near misses, ignoring minor safety rules, prioritizing production speed over safety and lack of safety leadership engagement.',
        'English_bestPractice': 'Best Practice',
        'English_bestPracticeText':
            'Empower every worker with "Stop Work Authority", celebrate safety milestones, treat safety as a core value rather than just a rule and maintain open communication.',
        'English_reference': 'Reference',
        'English_referenceText':
            'Company HSE vision and policy, international safety standards (ISO 45001) and applicable ADOSH-SF requirements.',

        'Hindi_title': 'Zero Harm',
        'Hindi_what': 'Zero Harm क्या है?',
        'Hindi_whatText':
            'Zero Harm एक सुरक्षा लक्ष्य और प्रतिबद्धता है जिसका उद्देश्य चोटों, व्यावसायिक बीमारियों, दुर्घटनाओं और पर्यावरण को होने वाले नुकसान को रोकना है।',
        'Hindi_purpose': 'उद्देश्य',
        'Hindi_purposeText':
            'एक ऐसी सक्रिय सुरक्षा संस्कृति को बढ़ावा देना जहाँ हर दुर्घटना और चोट से बचा जा सके, और शून्य कार्यस्थल दुर्घटनाओं का लक्ष्य हो।',
        'Hindi_requirements': 'आवश्यकताएँ',
        'Hindi_requirementsText':
            'सुरक्षा नेतृत्व के लिए प्रतिबद्ध रहें, सभी श्रमिकों को शामिल करें, सभी near misses report करें और निरंतर सुधार करें।',
        'Hindi_responsibilities': 'जिम्मेदारियाँ',
        'Hindi_responsibilitiesText':
            'Management उदाहरण प्रस्तुत करे और संसाधन दे। Supervisors नियम लागू करें। Workers व्यक्तिगत जिम्मेदारी लें और unsafe work रोकें।',
        'Hindi_checklist': 'Zero Harm Checklist',
        'Hindi_checklistText':
            'Safety vision, hazard reporting, near miss investigation, safety meetings, PPE compliance और STOP work authority की जाँच करें।',
        'Hindi_violations': 'सामान्य उल्लंघन',
        'Hindi_violationsText':
            'आत्मसंतुष्टि (complacency), near misses report न करना, छोटे नियमों की अनदेखी करना और सुरक्षा से पहले उत्पादन को प्राथमिकता देना।',
        'Hindi_bestPractice': 'Best Practice',
        'Hindi_bestPracticeText':
            'प्रत्येक कार्यकर्ता को "Stop Work Authority" दें, सुरक्षा को एक मूल मूल्य के रूप में मानें और खुली संचार व्यवस्था रखें।',
        'Hindi_reference': 'संदर्भ',
        'Hindi_referenceText':
            'Company HSE policy, ISO 45001 standards और ADOSH-SF requirements।',

        'Malayalam_title': 'Zero Harm',
        'Malayalam_what': 'Zero Harm എന്താണ്?',
        'Malayalam_whatText':
            'തൊഴിൽ സ്ഥലത്തെ injuries, occupational illnesses, incidents, പരിസ്ഥിതിക്ക് ഉണ്ടാകാവുന്ന ദോഷങ്ങൾ എന്നിവ തടയുന്നതിനുള്ള safety goal and commitment ആണ് Zero Harm.',
        'Malayalam_purpose': 'ഉദ്ദേശ്യം',
        'Malayalam_purposeText':
            'ഓരോ അപകടവും പരിക്കും തടയാൻ സാധിക്കുന്നതാണെന്ന ചിന്തയോടെ ശക്തമായ safety culture വളർത്തിയെടുക്കുക.',
        'Malayalam_requirements': 'ആവശ്യകതകൾ',
        'Malayalam_requirementsText':
            'Safety leadership ഉറപ്പാക്കുക, workers-നെ involve ചെയ്യുക, near misses report ചെയ്യുക, robust controls implement ചെയ്യുക, continuous improvement.',
        'Malayalam_responsibilities': 'ഉത്തരവാദിത്തങ്ങൾ',
        'Malayalam_responsibilitiesText':
            'Management leadership നൽകുകയും resources നൽകുകയും വേണം. Supervisors rules enforce ചെയ്യണം. Workers personal responsibility എടുക്കുകയും unsafe work stop ചെയ്യുകയും വേണം.',
        'Malayalam_checklist': 'Zero Harm Checklist',
        'Malayalam_checklistText':
            'Safety vision communicated ആണോ, hazard reporting active ആണോ, near misses investigated ആണോ, PPE compliance ഉണ്ടോ എന്ന് പരിശോധിക്കുക.',
        'Malayalam_violations': 'സാധാരണ ലംഘനങ്ങൾ',
        'Malayalam_violationsText':
            'Complacency, near misses report ചെയ്യാതിരിക്കൽ, minor rules അവഗണിക്കുന്നത്, production speed-ന് safety-യേക്കാൾ മുൻഗണന നൽകുന്നത്.',
        'Malayalam_bestPractice': 'Best Practice',
        'Malayalam_bestPracticeText':
            'ഓരോ worker-നെയും "Stop Work Authority" ഉപയോഗിക്കാൻ empower ചെയ്യുക, safety-യെ ഒരു core value ആയി കാണുക, open communication maintain ചെയ്യുക.',
        'Malayalam_reference': 'Reference',
        'Malayalam_referenceText':
            'Company HSE vision/policy, ISO 45001 standards, ADOSH-SF requirements.',

        'Tamil_title': 'Zero Harm',
        'Tamil_what': 'Zero Harm என்றால் என்ன?',
        'Tamil_whatText':
            'பணியிட காயங்கள், நோய்கள், சம்பவங்கள் மற்றும் சுற்றுச்சூழல் பாதிப்புகளைத் தடுப்பதற்கான safety goal மற்றும் commitment ஆகும்.',
        'Tamil_purpose': 'நோக்கம்',
        'Tamil_purposeText':
            'ஒவ்வொரு விபத்தும் காயமும் தவிர்க்கக்கூடியது என்ற எண்ணத்துடன் proactive safety culture-ஐ உருவாக்குவது.',
        'Tamil_requirements': 'தேவைகள்',
        'Tamil_requirementsText':
            'Safety leadership வழங்குவது, அனைத்து workers-ஐயும் ஈடுபடுத்துவது, near misses மற்றும் hazards-ஐ report செய்வது மற்றும் continuous improvement செய்வது.',
        'Tamil_responsibilities': 'பொறுப்புகள்',
        'Tamil_responsibilitiesText':
            'Management முன்னுதாரணமாக இருக்க வேண்டும். Supervisors பாதுகாப்பு விதிகளை அமல்படுத்த வேண்டும். Workers பாதுகாப்பிற்கான தனிப்பட்ட பொறுப்பை ஏற்று unsafe work-ஐ நிறுத்த வேண்டும்.',
        'Tamil_checklist': 'Zero Harm Checklist',
        'Tamil_checklistText':
            'Safety vision, hazard reporting, near miss investigation, PPE compliance மற்றும் STOP work authority ஆகியவற்றைச் சரிபார்க்கவும்.',
        'Tamil_violations': 'பொதுவான மீறல்கள்',
        'Tamil_violationsText':
            'Complacency, near misses report செய்யாதது, சிறிய விதிகளைப் புறக்கணிப்பது மற்றும் safety-ஐ விட production-க்கு முன்னுரிமை அளிப்பது.',
        'Tamil_bestPractice': 'Best Practice',
        'Tamil_bestPracticeText':
            'ஒவ்வொரு worker-க்கும் "Stop Work Authority" வழங்கி, safety-ஐ ஒரு அடிப்படை மதிப்பாக (core value) கருதவும்.',
        'Tamil_reference': 'Reference',
        'Tamil_referenceText':
            'Company HSE vision and policy, ISO 45001 standards மற்றும் ADOSH-SF requirements.',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guidelines'),
      ),
      body: Center(
        child: Text('Loaded guidelines for language: $_language'),
      ),
    );
  }
}
