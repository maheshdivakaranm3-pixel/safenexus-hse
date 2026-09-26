// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 10.0, 11.0 and 12.0 — detailed field reference.
// Current ADPHC registry: Version 4.0, effective 15 July 2024.
// Content structure is topic-specific; presentation follows the existing
// SafeNexus HSE reference design without changing UI/navigation.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop10To12 {
  static const List<AbuDhabiCopDocument> documents = [
    cop100Rehabilitation,
    cop110SafetyInTheHeat,
    cop120Legionnaires,
  ];

  static const cop100Rehabilitation = AbuDhabiCopDocument(
    code: 'CoP 10.0',
    title: 'Rehabilitation and Return to Work',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 10.0 establishes occupational safety and health arrangements for rehabilitation and return to work. The objective is to support a safe, structured and sustainable return to work after work-related or other health conditions while considering functional capacity, workplace hazards, medical advice and appropriate work adjustments.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Purpose, Scope and Rehabilitation Principles',
        requirements: [
          'A rehabilitation and return-to-work process shall be appropriate to the organisation, workforce and identified occupational health needs.',
          'Return-to-work arrangements shall be based on the worker’s functional capacity and the hazards and demands of the proposed work.',
          'The process shall support safe recovery without exposing the returning worker or other persons to uncontrolled risk.',
          'Relevant medical information shall be handled confidentially and only the information necessary for workplace control arrangements should be communicated to responsible persons.',
          'The rehabilitation process should coordinate appropriate occupational-health, management, worker and other competent-party inputs.',
        ],
        hazards: [
          'Returning a worker to duties beyond current functional capacity.',
          'Failure to modify a task after an injury or health condition.',
          'Premature return causing reinjury or deterioration.',
          'Poor communication of work restrictions.',
          'Stigma or inappropriate treatment of a worker during rehabilitation.',
        ],
        controls: [
          'Individual return-to-work assessment.',
          'Medical/occupational-health advice within professional scope.',
          'Task modification and suitable duties.',
          'Progressive return where appropriate.',
          'Confidential and need-to-know communication.',
        ],
        documents: [
          'Rehabilitation/return-to-work procedure.',
          'Individual return-to-work plan where required.',
          'Functional restrictions or recommendations communicated for workplace control.',
          'Review and follow-up records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Assessment of Functional Capacity and Job Demands',
        requirements: [
          'The proposed duties shall be compared with the worker’s current functional capabilities and relevant restrictions.',
          'Assessment shall consider physical, cognitive, environmental and organisational demands relevant to the job.',
          'Relevant job demands may include lifting, carrying, pushing, pulling, climbing, prolonged standing or sitting, driving, shift work, exposure to heat, chemicals, noise or other hazards.',
          'Where the original job cannot be performed safely, suitable alternative duties or modifications shall be considered.',
          'The assessment shall be reviewed when the worker’s condition, duties or workplace conditions change.',
        ],
        hazards: [
          'Mismatch between job demands and functional ability.',
          'Uncontrolled exposure to the hazard that contributed to the condition.',
          'Inadequate task modification.',
          'Return to high-risk work without appropriate reassessment.',
        ],
        controls: [
          'Job-demand analysis.',
          'Task modification.',
          'Engineering and administrative controls.',
          'Suitable alternative work.',
          'Periodic review of restrictions.',
        ],
        inspection: [
          'Verify proposed duties match current restrictions.',
          'Check required modifications are actually implemented.',
          'Check relevant hazards are controlled before return.',
          'Review the plan when duties or conditions change.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Return-to-Work Plan and Suitable Duties',
        requirements: [
          'A return-to-work plan should define the duties, restrictions, responsible persons and review arrangements applicable to the worker.',
          'Suitable duties shall be meaningful and shall not create new uncontrolled hazards.',
          'Where a progressive return is appropriate, workload, hours or task complexity may be increased in accordance with competent advice and review.',
          'Supervisors shall understand the workplace controls necessary to support the agreed plan without receiving unnecessary confidential medical information.',
          'Changes to duties shall be documented and communicated to the persons responsible for implementation.',
        ],
        hazards: [
          'Restrictions not followed in practice.',
          'Supervisor misunderstanding of limitations.',
          'Uncontrolled increase in workload.',
          'Worker assigned unfamiliar or higher-risk tasks during return.',
        ],
        controls: [
          'Written plan and clear responsibilities.',
          'Supervisor briefing on necessary restrictions.',
          'Progressive review.',
          'Worker feedback.',
          'Task-specific risk assessment.',
        ],
        documents: [
          'Return-to-work plan.',
          'Task risk assessment.',
          'Review records.',
          'Workplace adjustment records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Monitoring, Review and Case Closure',
        requirements: [
          'Return-to-work arrangements shall be reviewed at appropriate intervals and when the worker or workplace condition changes.',
          'The effectiveness of controls shall be evaluated through worker and supervisor feedback and appropriate occupational-health input.',
          'If restrictions cannot be safely maintained, the work arrangement shall be reassessed before continuing the affected task.',
          'Case closure shall occur only when the appropriate responsible parties determine that the return-to-work arrangement has been completed or otherwise appropriately concluded.',
          'Lessons learned from rehabilitation cases should be used to improve workplace controls where a work-related hazard contributed to the condition.',
        ],
        inspection: [
          'Check review dates and follow-up actions.',
          'Check workplace adjustments remain in place.',
          'Check restrictions are understood and followed.',
          'Check recurring causes are referred to the OSH risk-management process.',
        ],
      ),
    ],
    fieldChecklist: [
      'A suitable rehabilitation/return-to-work process is available.',
      'Job demands have been considered against functional capability.',
      'Relevant restrictions are communicated to responsible persons on a need-to-know basis.',
      'Suitable duties or task modifications are implemented.',
      'The worker is consulted about practical arrangements.',
      'Supervisors understand required workplace controls.',
      'Return-to-work arrangements are reviewed when conditions change.',
      'Recurring work-related causes are referred for preventive action.',
    ],
    stopWorkIndicators: [
      'The returning worker is assigned duties that clearly exceed documented restrictions or functional capability.',
      'A required workplace adjustment is absent and creates an immediate serious risk.',
      'The hazard associated with the original condition remains uncontrolled for the proposed task.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 10.0 – Rehabilitation and Return to Work, Version 4.0, 15 July 2024.',
      'ADOSH-SF risk-management requirements applicable to return-to-work controls.',
    ],
  );

  static const cop110SafetyInTheHeat = AbuDhabiCopDocument(
    code: 'CoP 11.0',
    title: 'Safety in the Heat',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 11.0 addresses occupational heat exposure and the controls required to prevent heat-related illness. Effective heat management combines assessment of environmental and work factors, planning, acclimatisation, hydration, rest and recovery, training, supervision and emergency response.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Heat Exposure Assessment and Work Planning',
        requirements: [
          'Employers shall assess heat-related risks associated with the work, environment, clothing, workload, duration and individual factors.',
          'Heat-risk controls shall be planned before high-heat work begins and reviewed as conditions change.',
          'Work organisation shall consider environmental heat, humidity, radiant heat, workload, physical effort and recovery opportunities.',
          'Higher-risk tasks shall receive additional planning, supervision and controls.',
        ],
        hazards: [
          'Heat exhaustion.',
          'Heat stroke and other heat-related illness.',
          'Dehydration.',
          'Reduced concentration and increased error rate.',
          'Fatigue affecting safe operation of tools, vehicles or equipment.',
        ],
        controls: [
          'Reduce heat exposure where practicable.',
          'Engineering controls such as shade, ventilation or cooling.',
          'Work/rest planning and scheduling.',
          'Hydration and suitable recovery arrangements.',
          'Training, acclimatisation and supervision.',
        ],
        documents: [
          'Heat-risk assessment.',
          'Heat-stress management plan where required.',
          'Worker training records.',
          'Heat monitoring or inspection records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Hydration, Rest, Shade and Recovery',
        requirements: [
          'Workers exposed to heat shall have access to suitable drinking water and arrangements for hydration appropriate to the work and environmental conditions.',
          'Rest and recovery arrangements shall be sufficient for the identified heat risk and workload.',
          'Shade or other suitable cooling arrangements shall be provided where required by the risk assessment and applicable requirements.',
          'Rest areas shall be maintained so that workers can recover without unnecessary additional heat exposure.',
          'Supervisors shall monitor workers for signs of heat strain and take prompt action where symptoms appear.',
        ],
        hazards: [
          'Dehydration.',
          'Inadequate recovery.',
          'Continued work during symptoms of heat illness.',
          'Resting in an area that remains excessively hot.',
        ],
        controls: [
          'Accessible drinking water.',
          'Suitable shaded/cool recovery areas.',
          'Planned rest and work rotation.',
          'Supervisor checks and worker self-reporting.',
        ],
        inspection: [
          'Check water availability and accessibility.',
          'Check shade/cooling arrangements.',
          'Check rest areas and their actual condition.',
          'Check supervisors understand heat-illness warning signs.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Acclimatisation, Training and Worker Fitness',
        requirements: [
          'Workers who are new to hot work or returning after a period away shall be managed in accordance with applicable acclimatisation arrangements.',
          'Workers shall receive information on heat hazards, prevention, symptoms and emergency actions.',
          'Workers shall be encouraged to report symptoms early and to stop or seek assistance when heat illness is suspected.',
          'Supervisors shall recognise signs of heat stress and understand the required response.',
          'Individual factors that may increase heat vulnerability shall be considered through appropriate occupational-health arrangements without unnecessary disclosure of confidential medical information.',
        ],
        hazards: [
          'Unacclimatised workers exposed to high heat.',
          'Failure to recognise early symptoms.',
          'Workers concealing symptoms because of production pressure.',
          'Inadequate supervision.',
        ],
        controls: [
          'Structured acclimatisation.',
          'Training and toolbox communication.',
          'Competent supervision.',
          'Worker reporting and stop-work culture.',
          'Occupational-health advice where appropriate.',
        ],
        documents: [
          'Heat-awareness training records.',
          'Acclimatisation arrangements.',
          'Heat-risk communication records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Heat-Related Illness Recognition and Emergency Response',
        requirements: [
          'Workers and supervisors shall know the signs and symptoms of heat-related illness and the required emergency response.',
          'Suspected serious heat illness shall be treated as a medical emergency and professional medical assistance shall be obtained promptly.',
          'The affected worker shall be moved away from the heat source and cooled using appropriate first-aid/emergency measures within the responder’s competence.',
          'The person shall not simply be returned to work after significant symptoms without appropriate assessment and follow-up.',
          'Heat-related incidents shall be investigated for underlying workplace causes and corrective actions.',
        ],
        hazards: [
          'Delayed treatment of serious heat illness.',
          'Worker collapse in a hazardous work area.',
          'Secondary injury during a heat-related event.',
          'Failure to correct the exposure after an incident.',
        ],
        controls: [
          'Emergency communication and first-aid arrangements.',
          'Rapid removal from heat exposure.',
          'Competent first-aid/medical response.',
          'Post-incident investigation and corrective action.',
        ],
        inspection: [
          'Check emergency contacts and first-aid arrangements.',
          'Check supervisors can recognise escalation indicators.',
          'Review heat-related incidents and corrective actions.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Monitoring, Supervision and Continual Improvement',
        requirements: [
          'Heat controls shall be monitored during high-risk periods and adjusted when environmental or work conditions change.',
          'Supervisors shall consider workload, worker condition, environmental conditions and effectiveness of recovery arrangements.',
          'Worker feedback and heat-related incidents shall be used to improve controls.',
          'Heat-risk assessments shall be reviewed after significant changes, incidents or evidence that existing controls are ineffective.',
        ],
        controls: [
          'Environmental and task monitoring appropriate to the risk.',
          'Supervisor observations.',
          'Worker feedback.',
          'Incident and near-miss review.',
          'Corrective-action tracking.',
        ],
        inspection: [
          'Check heat controls are actually implemented at the workface.',
          'Check work/rest and hydration arrangements.',
          'Check incident and near-miss trends.',
          'Check corrective actions are closed and effective.',
        ],
      ),
    ],
    fieldChecklist: [
      'Heat-risk assessment completed for relevant work.',
      'Workers have access to drinking water.',
      'Suitable shade/cooling and recovery arrangements are available.',
      'Work/rest arrangements reflect the heat risk.',
      'Acclimatisation arrangements are implemented where required.',
      'Workers and supervisors know heat-illness warning signs.',
      'Emergency response arrangements are available.',
      'Heat controls are monitored as conditions change.',
      'Heat-related incidents and near misses are reviewed.',
    ],
    stopWorkIndicators: [
      'A worker shows signs of serious heat illness and work continues instead of initiating emergency response.',
      'Required hydration, shade/cooling or recovery controls are unavailable for a high-heat task.',
      'Environmental or work conditions have materially changed and the existing heat controls are no longer adequate.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 11.0 – Safety in the Heat, Version 4.0, 15 July 2024.',
      'ADPHC Technical Guideline – Safety in the Heat, Version 4.0.',
      'Applicable UAE/Abu Dhabi heat-stress requirements and competent-authority instructions.',
    ],
  );

  static const cop120Legionnaires = AbuDhabiCopDocument(
    code: 'CoP 12.0',
    title: 'Prevention and Control of Legionnaires Disease',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 12.0 addresses prevention and control of Legionnaires disease associated with workplace water systems. The control approach is based on identifying systems that can create aerosol exposure, assessing risk, implementing suitable water-system controls, maintaining systems correctly and responding promptly to suspected cases or loss of control.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'What is Legionnaires Disease and Where is the Risk?',
        requirements: [
          'Employers shall identify workplace water systems and activities that could create a risk of exposure to Legionella bacteria and contaminated aerosols.',
          'Risk assessment shall consider system design, temperature control, stagnation, water storage, aerosol generation, maintenance and vulnerable persons where relevant.',
          'Potentially hazardous systems shall be managed through an appropriate control programme.',
        ],
        hazards: [
          'Inhalation of contaminated water aerosols.',
          'Poorly maintained hot- and cold-water systems.',
          'Water stagnation and low-use outlets.',
          'Inadequate temperature control.',
          'Contaminated cooling or water systems that generate aerosols.',
        ],
        controls: [
          'Water-system risk assessment.',
          'System design and maintenance controls.',
          'Temperature and stagnation management.',
          'Cleaning, disinfection and monitoring as required.',
          'Competent personnel and documented responsibilities.',
        ],
        documents: [
          'Legionella risk assessment.',
          'Water-system schematic/inventory where appropriate.',
          'Control and monitoring records.',
          'Maintenance and cleaning records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Water System Management and Risk Controls',
        requirements: [
          'Relevant water systems shall be designed, operated and maintained to minimise conditions that support Legionella growth and aerosol exposure.',
          'Dead legs, stagnant sections and infrequently used outlets shall be identified and managed.',
          'Water-system components shall be maintained in accordance with the system risk assessment and applicable technical requirements.',
          'Storage tanks, calorifiers, showers, cooling systems and other relevant equipment shall be included where they present a foreseeable risk.',
          'Control measures shall be supported by competent persons with appropriate knowledge of the system.',
        ],
        hazards: [
          'Stagnant water.',
          'Inadequate water-system maintenance.',
          'Aerosol generation from showers or other outlets.',
          'Poorly controlled storage or distribution systems.',
        ],
        controls: [
          'System inventory and schematic understanding.',
          'Good system design and maintenance.',
          'Regular use/management of low-use outlets.',
          'Cleaning and disinfection where required.',
          'Competent system management.',
        ],
        inspection: [
          'Check relevant water-system components.',
          'Check low-use outlets and stagnant sections.',
          'Check maintenance and cleaning status.',
          'Check control records against the risk assessment.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Monitoring, Maintenance and Records',
        requirements: [
          'Monitoring shall be appropriate to the identified water-system risks and applicable control programme.',
          'Water-system maintenance shall be planned and recorded.',
          'Abnormal results, equipment failures or loss of control shall trigger investigation and corrective action.',
          'Records shall demonstrate that identified controls are being implemented and reviewed.',
          'Changes to water systems, building use or occupancy shall be considered in the risk assessment.',
        ],
        controls: [
          'Planned preventive maintenance.',
          'Monitoring programme.',
          'Documented corrective action.',
          'Periodic review of the water-system risk assessment.',
        ],
        inspection: [
          'Review monitoring records.',
          'Check maintenance completion.',
          'Check corrective actions for abnormal findings.',
          'Check changes to the system are reflected in the risk assessment.',
        ],
        documents: [
          'Monitoring results.',
          'Maintenance logs.',
          'Cleaning/disinfection records.',
          'Corrective-action records.',
          'Risk-assessment review records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Aerosol-Generating Equipment and Worker Protection',
        requirements: [
          'Activities involving showers, sprays, cooling systems or other aerosol-generating water equipment shall be assessed for Legionella exposure risk.',
          'Maintenance activities shall be planned so that workers are protected from exposure to contaminated water or aerosols.',
          'Appropriate isolation, cleaning, disinfection and personal protective measures shall be used where identified by the risk assessment and applicable procedures.',
          'Workers shall receive information and training appropriate to their tasks and exposure.',
        ],
        hazards: [
          'Exposure during maintenance or cleaning.',
          'Aerosol generation during system operation or disturbance.',
          'Uncontrolled entry into contaminated areas or equipment.',
        ],
        controls: [
          'Task-specific risk assessment.',
          'Isolation and controlled maintenance.',
          'Suitable PPE and hygiene controls.',
          'Competent maintenance personnel.',
          'Safe cleaning/disinfection procedures.',
        ],
        inspection: [
          'Check maintenance work follows the approved procedure.',
          'Check required isolation and PPE.',
          'Check worker competency and training.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Suspected Cases, Escalation and Review',
        requirements: [
          'Suspected Legionnaires disease or significant loss of water-system control shall be escalated through the applicable occupational-health, medical and regulatory processes.',
          'The affected water system shall be assessed promptly to determine whether additional control measures are necessary.',
          'Where contamination or system failure is suspected, access and use of affected equipment shall be controlled as appropriate until the risk is assessed and managed.',
          'Corrective actions shall address both the immediate condition and underlying system-management causes.',
          'Lessons learned shall be incorporated into the water-system risk assessment and control programme.',
        ],
        hazards: [
          'Continued exposure after suspected contamination.',
          'Delayed escalation of a suspected case.',
          'Failure to identify the source or contributing system conditions.',
        ],
        controls: [
          'Medical and regulatory escalation.',
          'Prompt system assessment.',
          'Controlled access/use where necessary.',
          'Corrective action and verification.',
        ],
        documents: [
          'Incident or suspected-case records as applicable.',
          'System investigation records.',
          'Corrective-action records.',
          'Updated risk assessment.',
        ],
      ),
    ],
    fieldChecklist: [
      'Relevant workplace water systems have been identified.',
      'Legionella risk assessment is current.',
      'Water-system responsibilities are assigned to competent persons.',
      'Stagnant sections and low-use outlets are identified and controlled.',
      'Relevant maintenance and monitoring are completed.',
      'Aerosol-generating equipment is included in the assessment.',
      'Maintenance workers have appropriate procedures and protection.',
      'Abnormal results or loss of control are escalated.',
      'Corrective actions are verified and closed.',
      'System changes trigger risk-assessment review.',
    ],
    stopWorkIndicators: [
      'A significant loss of water-system control creates an uncontrolled exposure risk and no effective interim control is in place.',
      'Maintenance or cleaning of a potentially contaminated aerosol-generating system is being performed without the required risk controls.',
      'A suspected serious contamination event is identified and affected equipment remains in use without assessment.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 12.0 – Prevention and Control of Legionnaires Disease, Version 4.0, 15 July 2024.',
      'Applicable ADPHC occupational-health and public-health requirements.',
      'Relevant water-system maintenance and technical guidance applicable to the identified system.',
    ],
  );
}
