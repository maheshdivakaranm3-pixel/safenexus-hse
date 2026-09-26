// lib/data/abu_dhabi/abu_dhabi_cop_04_to_06.dart
// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 4.0–6.0 source-structured field reference.
// CoP 4.0 and 5.0 follow current ADPHC/ADOSH-SF documents.
// CoP 6.0 is presented as legacy/integrated Element 6 Emergency Management,
// not as a current standalone CoP.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop04To06 {
  static const List<AbuDhabiCopDocument> documents = [
    cop40FirstAid,
    cop50OccupationalHealth,
    cop60EmergencyManagement,
  ];

  static const cop40FirstAid = AbuDhabiCopDocument(
    code: 'CoP 4.0',
    title: 'First Aid and Medical Emergency Treatment',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'This Code of Practice applies to employers within Abu Dhabi for provision of first aid and medical emergency treatment to employees, workers and other persons. First aid is immediate assistance intended to preserve life, prevent deterioration and promote recovery. A medical emergency is a condition with a high probability of disabling or immediately life-threatening consequences requiring first aid or other immediate medical intervention.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Purpose, Scope and Emergency Principles',
        requirements: [
          'Provide first-aid arrangements appropriate to the workplace hazards, workforce and foreseeable emergency scenarios.',
          'Identify foreseeable injuries and illnesses through risk assessment and establish proportionate first-aid and medical response arrangements.',
          'Emergency arrangements shall be communicated to workers and other relevant persons who may be affected.',
          'Where another competent regulatory authority has a more stringent applicable requirement, the more stringent requirement shall be followed.',
        ],
        hazards: [
          'Delayed treatment after injury or sudden illness.',
          'Inadequate first-aid coverage for workforce size, work activities or remote locations.',
          'Uncontrolled escalation from a minor injury to a medical emergency.',
          'Failure to communicate emergency arrangements.',
        ],
        controls: [
          'Elimination or reduction of foreseeable injury and exposure risks.',
          'Engineering and workplace controls that reduce the likelihood or severity of injury.',
          'Emergency response procedures and competent first-aid personnel.',
          'Accessible first-aid equipment and suitable medical escalation arrangements.',
        ],
        documents: [
          'First-aid needs assessment.',
          'Emergency response arrangements.',
          'First-aider competency records.',
          'First-aid equipment inspection records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'First-Aider Training and Competency',
        requirements: [
          'First-aiders shall be trained and competent for the duties assigned to them.',
          'Training shall be appropriate to workplace hazards and foreseeable emergency conditions.',
          'First-aiders shall understand emergency communication, casualty assessment, immediate care, escalation and handover to emergency medical services.',
          'Training and competency records shall be maintained and kept available for verification.',
          'Where specialist hazards exist, additional emergency response competency shall be provided as identified by risk assessment.',
        ],
        hazards: [
          'Untrained persons attempting treatment beyond their competence.',
          'Incorrect casualty assessment or delayed escalation.',
          'Loss of first-aid capability because competent persons are absent from the work area.',
        ],
        controls: [
          'Competency-based training.',
          'Adequate first-aider coverage for working arrangements and locations.',
          'Refresher training and periodic competency verification.',
          'Clear escalation to professional medical services.',
        ],
        inspection: [
          'Check current first-aider list and competency status.',
          'Verify coverage for shifts, remote work areas and higher-risk activities.',
          'Verify emergency contact details and escalation arrangements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'First-Aid Facilities and Equipment',
        requirements: [
          'First-aid facilities shall be readily accessible and suitable for the workplace risk profile.',
          'First-aid kits shall be appropriate to the hazards and activities identified by assessment.',
          'Equipment shall be maintained in a clean, serviceable and readily available condition.',
          'Emergency equipment locations shall be clearly identified and kept accessible.',
          'Specialist equipment shall be provided where the identified hazard requires it.',
        ],
        hazards: [
          'Missing or expired first-aid supplies.',
          'Blocked access to emergency equipment.',
          'Unsuitable equipment for foreseeable injuries.',
          'Contamination of first-aid equipment.',
        ],
        controls: [
          'Risk-based selection of equipment.',
          'Routine inspection and replenishment.',
          'Clear signage and unobstructed access.',
          'Hygiene and infection-control arrangements.',
        ],
        inspection: [
          'Check kit completeness and condition.',
          'Check expiry dates and sterile packaging.',
          'Check AED availability and status where provided.',
          'Check access, signage and emergency contact information.',
        ],
        documents: [
          'First-aid kit inspection checklist.',
          'Equipment maintenance records.',
          'AED inspection/service records where applicable.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Medical Emergency Response',
        requirements: [
          'Recognise medical emergencies promptly and activate the emergency response system without unnecessary delay.',
          'Provide immediate first aid within the responder’s competence while arranging professional medical assistance where required.',
          'Maintain clear access for emergency responders and ambulances.',
          'Provide accurate information about the casualty, incident location, hazards and treatment already given during handover.',
          'Do not move a seriously injured casualty unless necessary to prevent immediate further danger or as directed by competent medical responders.',
        ],
        hazards: [
          'Delayed emergency call or delayed evacuation.',
          'Secondary exposure to chemicals, fire, electricity, traffic or other hazards.',
          'Uncontrolled casualty movement.',
          'Poor communication during emergency handover.',
        ],
        controls: [
          'Emergency alarm and communication system.',
          'Trained first-aiders.',
          'Defined emergency access and assembly arrangements.',
          'Isolation of ongoing hazards before casualty assistance where practicable.',
        ],
        documents: [
          'Emergency contact list.',
          'Emergency response procedure.',
          'Incident/first-aid treatment record.',
          'Medical handover information where applicable.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Infection Prevention and Special Hazards',
        requirements: [
          'First-aid responders shall use appropriate infection-control precautions.',
          'Contaminated materials shall be handled and disposed of using suitable arrangements.',
          'For hazardous-material incidents, responders shall not enter an unsafe area merely to provide first aid; the scene shall be made safe or specialist emergency response activated.',
          'Chemical exposure arrangements shall reflect the substance-specific SDS and emergency procedures.',
          'Eye and skin exposure controls shall be supported by suitable emergency washing facilities where the hazard requires them.',
        ],
        hazards: [
          'Blood-borne infection.',
          'Chemical exposure during rescue or treatment.',
          'Contaminated waste.',
          'Secondary exposure to the first-aider.',
        ],
        controls: [
          'Gloves and task-appropriate PPE.',
          'Hand hygiene and contamination control.',
          'SDS-based emergency arrangements.',
          'Specialist response for hazardous environments.',
        ],
        inspection: [
          'Check infection-control supplies.',
          'Check emergency washing/shower facilities where applicable.',
          'Check specialist emergency equipment identified by risk assessment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Worker Accommodation and Medical Facilities',
        requirements: [
          'Where employer-provided accommodation is within scope, first-aid and medical arrangements shall address the population and foreseeable health emergencies.',
          'Medical professionals providing services beyond first aid shall hold the required Department of Health - Abu Dhabi licence.',
          'Medical and advanced first-aid facilities shall maintain required licences.',
          'Emergency contact and referral arrangements shall be communicated to residents and workers.',
        ],
        hazards: [
          'Large populations without adequate emergency coverage.',
          'Delayed access to medical treatment.',
          'Unlicensed medical activity.',
        ],
        controls: [
          'Licensed medical services where required.',
          'Emergency transport and referral arrangements.',
          'Adequate first-aid coverage and communication.',
        ],
      ),
    ],

      AbuDhabiCopSection(
        number: '7.0',
        title: 'First-Aid Kit Management, Inspection and Readiness',
        requirements: [
          'First-aid equipment shall be appropriate to the hazards, activities and foreseeable injuries identified by risk assessment.',
          'First-aid kits and facilities shall be readily accessible, clearly identified and protected from obstruction.',
          'Contents shall be checked at a defined frequency and after use so that used, damaged, expired or contaminated items are replaced.',
          'Emergency equipment shall be kept clean, serviceable and ready for immediate use.',
          'The inspection process shall identify the location, condition, completeness and required corrective actions for each first-aid facility or kit.',
          'Where specialist hazards are present, additional first-aid or emergency equipment shall be provided where identified by the risk assessment and applicable requirements.',
        ],
        hazards: [
          'Missing or expired first-aid supplies.',
          'Blocked or inaccessible first-aid equipment.',
          'Contaminated or damaged equipment.',
          'Workers unable to locate emergency equipment quickly.',
        ],
        controls: [
          'Clearly marked and accessible locations.',
          'Routine inspection and replenishment.',
          'Defined responsibility for first-aid equipment checks.',
          'Location maps or emergency information where needed.',
        ],
        inspection: [
          'Check kit/facility identification and accessibility.',
          'Check completeness and condition of contents.',
          'Check expiry dates where applicable.',
          'Check specialist emergency equipment required by the risk assessment.',
          'Record deficiencies and close corrective actions.',
        ],
        documents: [
          'First-aid equipment inspection checklist.',
          'Replenishment records.',
          'Corrective-action records.',
          'First-aid facility location list.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Casualty Assessment, Handover and Emergency Communication',
        requirements: [
          'First-aiders shall work within their level of training and competence and obtain professional medical assistance when required.',
          'Emergency communication shall provide a clear route for requesting medical assistance and communicating the location and nature of the emergency.',
          'The casualty shall be protected from further harm while immediate care and escalation are arranged.',
          'Relevant information shall be handed over to professional medical responders where practicable, including known hazards, injury mechanism, exposure information and care already provided.',
          'Emergency arrangements shall account for access, remote work areas, restricted locations and site-specific hazards.',
        ],
        hazards: [
          'Delayed ambulance or medical response.',
          'Incorrect information during emergency handover.',
          'Secondary exposure to the casualty or responder.',
          'Uncontrolled movement of a seriously injured casualty.',
        ],
        controls: [
          'Emergency contact and escalation procedure.',
          'Trained first-aiders and designated emergency roles.',
          'Clear site access and location information.',
          'Isolation of ongoing hazards before or during casualty care where safe to do so.',
        ],
        documents: [
          'Emergency contact list.',
          'Site emergency response plan.',
          'First-aid treatment/incident records as applicable.',
          'Medical handover information where required.',
        ],
      ),
    fieldChecklist: [
      'First-aid needs assessment completed and current.',
      'Competent first-aiders available for the work arrangement.',
      'First-aid kits accessible, complete and serviceable.',
      'Emergency contacts displayed and current.',
      'AED available and maintained where provided.',
      'Emergency access route is clear.',
      'Workers know how to summon emergency assistance.',
      'Specialist hazards have appropriate emergency controls.',
      'First-aid and incident records are maintained.',
      'Medical facilities requiring licensing have valid licensing.',
    ],
    stopWorkIndicators: [
      'No effective first-aid or medical emergency arrangement for a high-risk activity.',
      'Required first-aid equipment is unavailable or inaccessible.',
      'No competent first-aider or equivalent emergency arrangement where the risk assessment requires coverage.',
      'Emergency access is blocked.',
      'An unsafe hazardous environment requires specialist response but unprotected persons are attempting rescue.',
    ],
    references: [
      'ADPHC/ADOSH-SF CoP 4.0 – First Aid and Medical Emergency Treatment, Version 4.0, 15 July 2024.',
      'Department of Health – Abu Dhabi requirements for licensed medical professionals and facilities where applicable.',
      'UAE and Abu Dhabi competent-authority emergency requirements applicable to the workplace.',
    ],
    verificationNote:
        'Current official ADPHC CoP 4.0 source verified against the English document dated 15 July 2024.',
  );

  static const cop50OccupationalHealth = AbuDhabiCopDocument(
    code: 'CoP 5.0',
    title: 'Occupational Health Screening and Medical Surveillance',
    version: '4.0',
    effectiveDate: 'July 2024',
    introduction:
        'This Code of Practice establishes occupational health screening and medical surveillance arrangements for workers whose work or exposure profile requires health assessment. The programme should identify relevant health risks, establish appropriate examinations and surveillance, protect medical confidentiality and provide the information needed to manage occupational health risks.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Purpose and Occupational Health Programme',
        requirements: [
          'Establish occupational health arrangements based on workplace hazards, exposures, job roles and applicable requirements.',
          'Use health screening and surveillance to identify health effects associated with occupational hazards and to support preventive action.',
          'Coordinate occupational health arrangements with risk assessments and exposure-control programmes.',
          'Use competent occupational-health professionals for medical assessment and interpretation.',
        ],
        hazards: [
          'Unidentified occupational disease or adverse health effects.',
          'Workers continuing exposure without appropriate health surveillance.',
          'Failure to identify changes in health that may be related to work.',
        ],
        controls: [
          'Hazard identification and exposure assessment.',
          'Engineering and administrative exposure controls.',
          'Appropriate screening and medical surveillance.',
          'Health information used to improve workplace controls.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Pre-Placement and Periodic Screening',
        requirements: [
          'Pre-placement or pre-employment assessment shall be used where required for the job and exposure profile.',
          'Periodic examinations shall be scheduled according to applicable occupational-health requirements and identified exposure risks.',
          'The health assessment should consider relevant work history, medical history and exposure information.',
          'Additional examination shall be arranged when exposure, symptoms or other occupational-health indicators require it.',
        ],
        hazards: [
          'Placing a worker into a hazardous exposure without appropriate baseline information.',
          'Failure to identify deterioration or exposure-related health effects.',
          'Incomplete occupational history.',
        ],
        controls: [
          'Baseline health assessment.',
          'Exposure-specific surveillance schedules.',
          'Medical review when conditions change.',
          'Communication between occupational health and HSE functions while protecting confidentiality.',
        ],
        inspection: [
          'Verify the surveillance programme is current.',
          'Check that required worker groups are included.',
          'Check follow-up actions from occupational-health findings.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Exposure-Specific Medical Surveillance',
        requirements: [
          'Surveillance shall be linked to the specific hazardous exposure and potential health effect.',
          'Where respiratory protection is required, the occupational-health process shall address the worker’s ability to safely use the required respiratory protection where applicable.',
          'Exposure-specific examinations and tests shall be selected by the competent medical professional in accordance with the applicable requirements.',
          'Where a medical finding indicates increased risk, appropriate medical advice and workplace-control review shall be initiated.',
        ],
        hazards: [
          'Noise-induced hearing effects.',
          'Respiratory effects from hazardous airborne substances.',
          'Skin effects from occupational exposure.',
          'Musculoskeletal effects.',
          'Toxicological effects from specific hazardous substances.',
        ],
        controls: [
          'Eliminate or substitute hazardous exposure where practicable.',
          'Engineering controls and containment.',
          'Administrative exposure controls.',
          'Appropriate PPE and respiratory/hearing protection.',
          'Medical surveillance matched to the exposure.',
        ],
        documents: [
          'Exposure assessment.',
          'Occupational-health surveillance schedule.',
          'Medical examination records under appropriate confidentiality controls.',
          'Relevant physician/occupational-health reports.',
          'Corrective-action records for identified occupational-health risks.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Medical Records and Confidentiality',
        requirements: [
          'Medical information shall be handled confidentially and only disclosed or used as permitted by applicable requirements.',
          'Occupational-health records shall be maintained securely for the required retention period.',
          'Employers should receive the information necessary to manage work-related risk without unnecessarily exposing confidential medical details.',
          'Workers should be informed about relevant occupational-health findings and required follow-up through the appropriate medical process.',
        ],
        hazards: [
          'Unauthorised disclosure of personal medical information.',
          'Incomplete records.',
          'Failure to act on medically identified occupational risks.',
        ],
        controls: [
          'Controlled access to medical records.',
          'Defined record-management responsibilities.',
          'Secure storage and transmission.',
          'Clear separation between medical confidentiality and HSE risk-management needs.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Medical Removal, Restrictions and Follow-Up',
        requirements: [
          'Where competent medical advice identifies a work-related risk requiring restriction or removal from exposure, the employer shall manage the worker in accordance with the applicable medical and employment requirements.',
          'Workplace exposure controls shall be reviewed when occupational-health findings indicate inadequate control.',
          'Follow-up examinations or tests shall be arranged where required by the applicable surveillance programme.',
          'Return-to-work arrangements should be managed through competent medical advice where a health condition has affected work capability.',
        ],
        hazards: [
          'Continued exposure after an adverse health finding.',
          'Failure to implement medical recommendations.',
          'Uncontrolled return to a hazardous task.',
        ],
        controls: [
          'Medical recommendation and work restriction process.',
          'Exposure reduction or removal.',
          'Corrective action on workplace controls.',
          'Documented follow-up.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Worker Communication and Programme Review',
        requirements: [
          'Workers should understand the purpose of required occupational-health screening and surveillance.',
          'Relevant occupational-health information shall be communicated through appropriate professional channels.',
          'The occupational-health programme shall be reviewed when hazards, processes, substances, equipment or work patterns change.',
          'Health surveillance results should be considered when evaluating whether existing exposure controls remain effective.',
        ],
        controls: [
          'Worker awareness.',
          'Periodic programme review.',
          'Integration with risk assessment and monitoring.',
          'Corrective action and continuous improvement.',
        ],
        inspection: [
          'Check surveillance coverage against the current workforce and exposure register.',
          'Check overdue examinations and follow-up actions.',
          'Check that changes in process or exposure trigger programme review.',
        ],
      ),
    ],

      AbuDhabiCopSection(
        number: '7.0',
        title: 'Exposure-Based Surveillance Programme Management',
        requirements: [
          'The occupational health programme shall be linked to identified workplace hazards and exposure risks.',
          'The employer shall identify workers or groups who require health screening or medical surveillance based on applicable requirements and exposure conditions.',
          'Surveillance arrangements shall be reviewed when processes, substances, equipment, work patterns or exposure conditions change.',
          'Medical surveillance shall be performed by appropriately qualified healthcare professionals within their scope of practice.',
          'Results requiring occupational-health follow-up shall be managed through appropriate medical and workplace controls while protecting medical confidentiality.',
        ],
        hazards: [
          'Workers exposed to health hazards without appropriate surveillance.',
          'Failure to reassess surveillance after a process or exposure change.',
          'Inadequate follow-up of abnormal health findings.',
          'Confidential medical information being improperly disclosed.',
        ],
        controls: [
          'Hazard and exposure register.',
          'Defined surveillance population and schedule.',
          'Competent occupational-health provider.',
          'Documented referral and follow-up process.',
          'Confidential handling of medical information.',
        ],
        inspection: [
          'Check that relevant exposure groups are identified.',
          'Check that required surveillance is scheduled and completed.',
          'Check follow-up arrangements for findings requiring action.',
          'Check that changes in work or exposure are reflected in the programme.',
        ],
        documents: [
          'Exposure register.',
          'Occupational-health surveillance programme.',
          'Appointment/referral records as applicable.',
          'Aggregate programme review records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Health Surveillance Records, Confidentiality and Fitness Controls',
        requirements: [
          'Occupational-health information shall be handled confidentially and accessed only by authorised persons for legitimate purposes.',
          'Employers shall retain the occupational-health records required by applicable law and the relevant Code of Practice.',
          'Where a healthcare professional identifies work restrictions or additional controls, the employer shall implement the workplace controls communicated within the appropriate confidentiality boundaries.',
          'Health surveillance records shall be traceable to the relevant worker, hazard or exposure programme while maintaining appropriate confidentiality.',
          'Trends and programme effectiveness may be reviewed using appropriate aggregated information without unnecessary disclosure of individual medical details.',
        ],
        hazards: [
          'Loss or unauthorised disclosure of medical information.',
          'Workers continuing hazardous work without required restrictions or follow-up.',
          'Incomplete records preventing effective occupational-health management.',
        ],
        controls: [
          'Controlled access to medical records.',
          'Clear interface between occupational-health provider and employer.',
          'Documented workplace restrictions and control actions.',
          'Periodic programme review using appropriate aggregate information.',
        ],
        inspection: [
          'Verify record-control arrangements.',
          'Verify that required surveillance records are available to authorised personnel.',
          'Verify that workplace restrictions or recommendations are implemented where applicable.',
          'Verify that programme reviews identify recurring occupational-health risks.',
        ],
        documents: [
          'Confidential medical records.',
          'Occupational-health programme review.',
          'Workplace restriction/control records where applicable.',
          'Exposure and surveillance tracking records.',
        ],
      ),
    fieldChecklist: [
      'Occupational-health risk assessment is available.',
      'Worker groups requiring screening or surveillance are identified.',
      'Pre-placement requirements are applied where required.',
      'Periodic surveillance schedule is current.',
      'Exposure-specific surveillance is defined.',
      'Medical records are controlled confidentially.',
      'Follow-up actions are tracked.',
      'Work restrictions/removal recommendations are managed appropriately.',
      'Changes in hazards trigger programme review.',
      'Occupational-health findings are considered in HSE control reviews.',
    ],
    stopWorkIndicators: [
      'A known high-risk exposure is being performed without required occupational-health surveillance.',
      'A worker is knowingly assigned to a hazardous exposure contrary to a competent medical restriction.',
      'A significant occupational-health finding identifies uncontrolled exposure and no corrective action is being taken.',
      'Required medical assessment or follow-up is unavailable for a task where it is a mandatory control.',
    ],
    references: [
      'ADPHC/ADOSH-SF CoP 5.0 – Occupational Health Screening and Medical Surveillance, Version 4.0, July 2024.',
      'Applicable Department of Health – Abu Dhabi requirements.',
      'Relevant ADOSH-SF CoPs and occupational exposure requirements.',
    ],
    verificationNote:
        'Current official ADPHC CoP 5.0 English document verified as Version 4.0, July 2024.',
  );

  static const cop60EmergencyManagement = AbuDhabiCopDocument(
    code: 'CoP 6.0',
    title: 'Emergency Management Requirements — Legacy / Integrated Reference',
    version: 'Integrated into ADOSH-SF Element 6',
    effectiveDate: 'Current framework reference',
    introduction:
        'CoP 6.0 is not presented here as a current standalone ADPHC Code of Practice. Emergency management requirements were incorporated into ADOSH-SF Element 6. This SafeNexus reference keeps the historical CoP 6 subject visible for field learning while directing users to the current integrated emergency-management framework.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Status and Current Framework',
        requirements: [
          'Treat emergency management as a mandatory OSH management requirement under the current ADOSH-SF framework.',
          'Use the current ADOSH-SF Element 6 requirements and applicable competent-authority requirements when developing the emergency management system.',
          'Do not treat this legacy reference as a replacement for the current ADOSH-SF framework.',
        ],
        controls: [
          'Maintain a documented emergency management process.',
          'Link emergency planning to risk assessment and credible emergency scenarios.',
          'Coordinate emergency arrangements with competent authorities and site-specific requirements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Emergency Risk Assessment and Planning',
        requirements: [
          'Identify credible emergency scenarios from the entity’s hazards and risk assessment.',
          'Develop response arrangements for foreseeable scenarios such as fire, medical emergencies, spills, releases, evacuation and other significant events relevant to the workplace.',
          'Define responsibilities, communication, escalation, emergency equipment and external support.',
          'Identify evacuation routes, assembly areas and alternative arrangements where required.',
        ],
        hazards: [
          'Fire and explosion.',
          'Medical emergency.',
          'Hazardous-material release or spill.',
          'Electrical or energy-related emergency.',
          'Structural or work-at-height emergency.',
          'Severe weather or other site-specific emergency.',
        ],
        controls: [
          'Emergency response plan.',
          'Alarm and communication systems.',
          'Emergency equipment.',
          'Evacuation and assembly arrangements.',
          'Competent emergency response personnel.',
        ],
        documents: [
          'Emergency Management Plan.',
          'Emergency contact list.',
          'Emergency scenario procedures.',
          'Site evacuation plan.',
          'Emergency equipment inspection records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Emergency Response and Evacuation',
        requirements: [
          'Emergency procedures shall clearly state how to raise the alarm, summon assistance, isolate hazards where safe, evacuate and account for persons.',
          'Emergency routes and exits shall be kept available and suitable for the workplace.',
          'Assembly areas shall be identified and communicated.',
          'Emergency responders shall understand their roles and limitations.',
          'Emergency response shall not expose rescuers to uncontrolled hazards.',
        ],
        controls: [
          'Alarm systems.',
          'Emergency lighting where required.',
          'Clear evacuation routes.',
          'Muster/assembly arrangements.',
          'Trained emergency response teams.',
          'Communication and accountability systems.',
        ],
        inspection: [
          'Check emergency exits and routes.',
          'Check emergency alarms and communication arrangements.',
          'Check assembly-point signage.',
          'Check emergency equipment status.',
          'Verify emergency contact information.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Emergency Equipment and Resources',
        requirements: [
          'Provide emergency equipment appropriate to the identified scenarios and applicable requirements.',
          'Emergency equipment shall be accessible, maintained and inspected.',
          'Specialist equipment shall be selected according to the emergency scenarios and hazards identified by risk assessment.',
          'Workers shall know the location and basic use limitations of emergency equipment relevant to their role.',
        ],
        hazards: [
          'Unavailable or defective emergency equipment.',
          'Incorrect equipment for the hazard.',
          'Untrained use of specialist rescue equipment.',
        ],
        controls: [
          'Risk-based equipment selection.',
          'Routine inspection and maintenance.',
          'Competent-user training.',
          'Clear identification and access.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Drills, Training and Continual Improvement',
        requirements: [
          'Train relevant personnel in emergency procedures and responsibilities.',
          'Conduct drills or exercises appropriate to the identified emergency scenarios and organisational requirements.',
          'Record drill results, deficiencies and corrective actions.',
          'Review the emergency plan after incidents, drills, significant changes and lessons learned.',
        ],
        documents: [
          'Training records.',
          'Drill schedule.',
          'Drill reports.',
          'Corrective-action tracker.',
          'Emergency-plan revision history.',
        ],
        inspection: [
          'Check drill completion and action close-out.',
          'Check emergency-team competency.',
          'Check lessons learned are incorporated into the plan.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'External Emergency Services and Coordination',
        requirements: [
          'Maintain appropriate arrangements for contacting external emergency services.',
          'Provide emergency responders with relevant site information where required.',
          'Coordinate site emergency arrangements with competent authorities and emergency-service requirements.',
          'Emergency response plans shall reflect access constraints, remote locations and site-specific hazards where applicable.',
        ],
        controls: [
          'Emergency contact directory.',
          'Site access and responder information.',
          'Pre-planned coordination with relevant external services.',
          'Clear site location identification.',
        ],
      ),
    ],

      AbuDhabiCopSection(
        number: '7.0',
        title: 'Emergency Response Plan Content and Site Readiness',
        requirements: [
          'Emergency response plans shall be based on risk assessment and the credible emergency scenarios that could affect persons, property or operations.',
          'The plan shall define who raises the alarm, who leads the response, who controls the area, who accounts for personnel and who communicates with external responders.',
          'Emergency procedures shall be simple, accessible and practical for the people expected to use them.',
          'Evacuation routes, alternative routes and assembly arrangements shall reflect actual site conditions and foreseeable changes.',
          'Emergency plans shall consider the needs of workers, contractors, visitors and other persons who may be affected.',
          'Where relevant, separate on-site and off-site arrangements shall be considered in accordance with the applicable emergency-management requirements.',
        ],
        hazards: [
          'Emergency plan does not match actual site conditions.',
          'Unclear emergency roles or conflicting instructions.',
          'Blocked evacuation routes or unsuitable assembly areas.',
          'Failure to account for contractors, visitors or remote work groups.',
        ],
        controls: [
          'Scenario-based emergency planning.',
          'Defined command and communication structure.',
          'Clearly marked evacuation routes and assembly points.',
          'Personnel accountability arrangements.',
          'Regular review of site information and emergency contacts.',
        ],
        inspection: [
          'Walk the evacuation routes and check for obstruction.',
          'Verify assembly points remain suitable.',
          'Verify emergency contacts and site maps are current.',
          'Verify emergency roles are known by designated personnel.',
          'Check that changes to the site are reflected in the emergency plan.',
        ],
        documents: [
          'Emergency Management Procedure.',
          'Emergency Response Plan.',
          'Site emergency map.',
          'Emergency contact list.',
          'Personnel accountability arrangements.',
        ],
      ),
      AbuDhabiCopSection(
        number: '8.0',
        title: 'Alarm, Communication, Accountability and Recovery',
        requirements: [
          'Emergency alarm and communication methods shall be suitable for the site and the identified emergency scenarios.',
          'Personnel shall know how an emergency is raised and what immediate actions are expected of them.',
          'Arrangements shall be established for accounting for workers, contractors and visitors at the assembly point or other designated location.',
          'Emergency communications shall remain effective for isolated or noisy work areas where applicable.',
          'After an emergency, the affected area shall not be returned to normal operation until the responsible persons determine that the relevant hazards are controlled and applicable requirements for restart are satisfied.',
          'Lessons learned from incidents and exercises shall be incorporated into the emergency-management system.',
        ],
        hazards: [
          'Alarm not heard or understood.',
          'Missing persons not identified during evacuation.',
          'Conflicting or incomplete emergency information.',
          'Premature restart following an emergency.',
        ],
        controls: [
          'Tested alarm and communication arrangements.',
          'Muster/accountability system.',
          'Emergency communication hierarchy.',
          'Controlled re-entry and restart process.',
          'Post-event investigation and corrective action.',
        ],
        inspection: [
          'Test alarm/communication arrangements according to the site programme.',
          'Verify accountability arrangements.',
          'Check emergency contact information.',
          'Review drill and incident corrective actions.',
          'Check that emergency equipment and routes remain ready after site changes.',
        ],
        documents: [
          'Alarm/test records.',
          'Muster/accountability records.',
          'Drill and exercise reports.',
          'Emergency incident records.',
          'Corrective-action and lessons-learned records.',
        ],
      ),
    fieldChecklist: [
      'Current emergency management plan is available.',
      'Credible emergency scenarios are identified.',
      'Emergency roles and responsibilities are assigned.',
      'Alarm and communication arrangements are functional.',
      'Emergency exits and routes are clear.',
      'Assembly points are identified.',
      'Emergency equipment is available and maintained.',
      'Emergency contacts are current.',
      'Relevant personnel are trained.',
      'Drills/exercises and corrective actions are recorded.',
      'Plan is reviewed after significant changes or incidents.',
    ],
    stopWorkIndicators: [
      'A high-risk operation has no effective emergency response arrangement.',
      'Emergency evacuation routes are blocked or unusable.',
      'Critical emergency communication or alarm arrangements are unavailable.',
      'Required emergency equipment is missing or defective.',
      'Workers are exposed to a credible emergency scenario without an effective response plan.',
    ],
    references: [
      'ADOSH-SF Element 6 – Emergency Management, current framework requirements.',
      'ADPHC legislation and mechanisms applicable to emergency management.',
      'Relevant current ADOSH-SF Codes of Practice and competent-authority requirements.',
    ],
    verificationNote:
        'Historical CoP 6.0 is deliberately labelled as legacy/integrated. Current emergency-management requirements are addressed through ADOSH-SF Element 6 and applicable current requirements.',
  );
}
