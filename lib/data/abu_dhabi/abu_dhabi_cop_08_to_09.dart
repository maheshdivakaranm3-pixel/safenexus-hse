// SafeNexus HSE — Abu Dhabi HSE Reference
// CoP 8.0, 9.0, 9.1 and 9.2 source-structured field reference.
// Current ADPHC registry: all Version 4.0, effective 15 July 2024.
// CoP 7.0 is intentionally not included because it is not a current
// standalone CoP in the ADPHC registry.

import 'abu_dhabi_cop_01_to_03.dart';

class AbuDhabiCop08To09 {
  static const List<AbuDhabiCopDocument> documents = [
    cop80GeneralWorkplaceAmenities,
    cop90WorkplaceWellness,
    cop91NewAndExpectantMothers,
    cop92WorkRelatedStress,
  ];

  static const cop80GeneralWorkplaceAmenities = AbuDhabiCopDocument(
    code: 'CoP 8.0',
    title: 'General Workplace Amenities',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 8.0 establishes minimum occupational safety and health requirements for general workplace conditions and welfare amenities. It focuses on maintaining workplaces free from recognizable hazards and ensuring appropriate access to welfare facilities such as eating areas, sanitary bathrooms, changing facilities and prayer facilities where required.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Purpose, Scope and Workplace Welfare Principles',
        requirements: [
          'Employers shall establish minimum requirements for general worksite conditions that comply with applicable occupational health and safety requirements.',
          'Workplace arrangements shall address recognizable safety and health hazards and provide appropriate welfare facilities for employees.',
          'Welfare arrangements shall reflect the workforce, work activities, workplace layout and foreseeable health and hygiene needs.',
          'Workplace conditions shall be routinely inspected and deficiencies shall be corrected.',
          'Employees shall be informed of workplace procedures that help maintain safe, clean and sanitary conditions.',
        ],
        hazards: [
          'Poor hygiene and sanitation.',
          'Inadequate welfare facilities for the workforce.',
          'Blocked access or poorly maintained facilities.',
          'Unsafe or unhygienic eating areas.',
          'Poor housekeeping creating slips, trips, contamination or fire risk.',
        ],
        controls: [
          'Provide suitable welfare facilities based on workplace needs.',
          'Maintain facilities in a clean, sanitary and serviceable condition.',
          'Routine workplace inspection and corrective action.',
          'Clear allocation of responsibility for cleaning, maintenance and replenishment.',
        ],
        documents: [
          'Workplace inspection checklist.',
          'Welfare-facility inspection records.',
          'Cleaning and maintenance schedules.',
          'Corrective-action records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Housekeeping, Floors and General Cleanliness',
        requirements: [
          'Places of employment, including passageways, storerooms and service rooms, shall be kept clean, orderly and sanitary.',
          'Workroom floors shall be maintained in a clean and, so far as reasonably practicable, dry condition.',
          'Where wet processes are used, drainage shall be maintained and suitable dry standing arrangements shall be provided where reasonably practicable.',
          'Waste and unnecessary materials shall not be allowed to accumulate in a way that creates a safety or health hazard.',
          'Spills and contamination shall be dealt with promptly using suitable controls.',
        ],
        hazards: [
          'Slip, trip and fall hazards.',
          'Standing water and poor drainage.',
          'Accumulated waste or combustible materials.',
          'Chemical or biological contamination.',
          'Obstructed passageways and emergency access.',
        ],
        controls: [
          'Planned housekeeping arrangements.',
          'Effective drainage for wet processes.',
          'Defined waste collection and removal arrangements.',
          'Prompt spill response.',
          'Routine inspection of floors, passageways and service areas.',
        ],
        inspection: [
          'Check floors for cleanliness, wet areas and damage.',
          'Check passageways and access routes are unobstructed.',
          'Check drainage and dry standing arrangements where applicable.',
          'Check waste accumulation and housekeeping standards.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Sanitary Bathrooms, Washing and Changing Facilities',
        requirements: [
          'Employees shall have access to clean and sanitary bathroom facilities appropriate to the workplace.',
          'Washing facilities shall be maintained in a hygienic and usable condition where required by the work activity and applicable requirements.',
          'Changing facilities shall be provided where required and shall be suitable for the workforce and work conditions.',
          'Facilities shall be accessible, adequately maintained and protected from conditions that could compromise hygiene.',
          'Where work involves contamination, suitable arrangements shall be established to prevent the transfer of contaminants to clean areas or personal clothing.',
        ],
        hazards: [
          'Poor sanitation and infectious-disease risk.',
          'Inadequate handwashing facilities.',
          'Contamination of personal clothing.',
          'Wet floors and slip hazards.',
          'Poor maintenance or blocked facilities.',
        ],
        controls: [
          'Routine cleaning and sanitation.',
          'Adequate supplies and functional fixtures.',
          'Segregation of contaminated and clean areas where needed.',
          'Prompt repair of defective facilities.',
        ],
        inspection: [
          'Check cleanliness and sanitation.',
          'Check water supply and washing facilities where provided.',
          'Check toilets, changing areas and fixtures for defects.',
          'Check floors, drainage and ventilation where applicable.',
        ],
        documents: [
          'Cleaning schedule.',
          'Facility inspection records.',
          'Maintenance requests and close-out records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Eating Facilities, Drinking Water and Prayer Facilities',
        requirements: [
          'Appropriate facilities for eating shall be provided where required by the workplace arrangements.',
          'Eating areas shall be maintained in a clean and hygienic condition and shall be separated from sources of contamination where necessary.',
          'Safe drinking-water arrangements shall be available in accordance with applicable requirements and workplace needs.',
          'Where required, employees shall have access to a prayer room or mosque as part of general welfare arrangements.',
          'Facilities shall be maintained so that workers can use them without unnecessary exposure to workplace hazards.',
        ],
        hazards: [
          'Food contamination.',
          'Consumption of food or drink in hazardous work areas.',
          'Unsafe or unhygienic drinking-water arrangements.',
          'Poor cleanliness of eating areas.',
        ],
        controls: [
          'Designated clean eating areas.',
          'Separation from hazardous processes and contamination sources.',
          'Routine cleaning and inspection.',
          'Clear identification and access to welfare facilities.',
        ],
        inspection: [
          'Check eating areas are clean and suitable.',
          'Check drinking-water arrangements are accessible and hygienic.',
          'Check welfare facilities are available and maintained.',
          'Check hazardous work areas are not being used as eating areas.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Workplace Conditions, Ventilation and Environmental Factors',
        requirements: [
          'Workplace conditions shall be managed so that foreseeable environmental factors do not create unacceptable safety or health risks.',
          'Ventilation arrangements shall be maintained where needed to control contaminants, heat, odours or other workplace conditions.',
          'Lighting shall be suitable for the work being performed and maintained so that workers can carry out tasks safely.',
          'Where workplace conditions change, the employer shall reassess relevant risks and controls.',
        ],
        hazards: [
          'Poor ventilation or indoor air quality.',
          'Insufficient lighting or glare.',
          'Heat, humidity or uncomfortable environmental conditions.',
          'Accumulation of airborne contaminants or odours.',
        ],
        controls: [
          'Adequate ventilation and air movement.',
          'Suitable lighting and maintenance.',
          'Engineering controls for contaminants and environmental conditions.',
          'Monitoring and corrective action where conditions deteriorate.',
        ],
        inspection: [
          'Check ventilation systems and visible defects.',
          'Check lighting and access to work areas.',
          'Check environmental complaints and corrective actions.',
          'Check changes to workplace conditions are assessed.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Inspection, Maintenance and Corrective Action',
        requirements: [
          'Employers shall routinely inspect workplace conditions in accordance with the applicable audit and inspection requirements.',
          'Deficiencies affecting health, safety or welfare shall be recorded and corrected in a timely manner.',
          'Repeated deficiencies shall be investigated for underlying causes rather than repeatedly corrected without prevention.',
          'Inspection arrangements shall cover welfare facilities as well as work areas and access routes.',
        ],
        controls: [
          'Scheduled inspections.',
          'Clear responsibility for corrective actions.',
          'Priority-based close-out of significant deficiencies.',
          'Trend review for repeated welfare or housekeeping issues.',
        ],
        inspection: [
          'Housekeeping and floors.',
          'Bathrooms and washing facilities.',
          'Changing facilities.',
          'Eating and drinking arrangements.',
          'Prayer facilities where applicable.',
          'Ventilation and lighting where relevant.',
          'Corrective-action status.',
        ],
        documents: [
          'Inspection checklist.',
          'Corrective-action tracker.',
          'Cleaning and maintenance records.',
          'Workplace welfare inspection trend records.',
        ],
      ),
    ],
    fieldChecklist: [
      'Workplace is clean, orderly and sanitary.',
      'Passageways and access routes are unobstructed.',
      'Floors are maintained clean and, where reasonably practicable, dry.',
      'Drainage is effective in wet-process areas.',
      'Clean and sanitary bathrooms are available.',
      'Washing and changing facilities are suitable where required.',
      'Eating facilities are clean and separated from contamination sources.',
      'Safe drinking-water arrangements are available.',
      'Prayer facility arrangements are provided where required.',
      'Ventilation and lighting are suitable for the work.',
      'Deficiencies are recorded and corrective actions are closed.',
    ],
    stopWorkIndicators: [
      'Workplace conditions create an immediate serious health or safety hazard.',
      'Critical access or emergency routes are blocked by poor housekeeping.',
      'Severe sanitation or contamination makes an area unsafe to occupy.',
      'A serious facility defect creates immediate risk of injury or exposure.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 8.0 – General Workplace Amenities, Version 4.0, 15 July 2024.',
      'ADOSH-SF Element 8 – Audit and Inspection.',
      'Applicable UAE federal and Abu Dhabi workplace welfare requirements.',
    ],
  );

  static const cop90WorkplaceWellness = AbuDhabiCopDocument(
    code: 'CoP 9.0',
    title: 'Workplace Wellness',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 9.0 establishes a workplace wellness approach covering health promotion and supportive workplace conditions. The focus is on practical programmes that promote healthier choices and address workplace and environmental factors that can influence worker wellbeing.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Workplace Wellness Principles and Responsibilities',
        requirements: [
          'Employers shall establish workplace wellness arrangements appropriate to the organisation and its workforce.',
          'Wellness initiatives shall complement, and not replace, the controls required to manage occupational hazards.',
          'Employees should be informed of available wellness initiatives and how to access them.',
          'Wellness activities shall be planned and monitored so that they are practical and do not introduce unintended risks.',
        ],
        hazards: [
          'Workplace factors contributing to poor wellbeing.',
          'Stress and fatigue affecting wellbeing.',
          'Poor access to healthy choices or supportive facilities.',
          'Wellness initiatives that are poorly designed or not evaluated.',
        ],
        controls: [
          'Risk-based workplace health promotion.',
          'Management support and worker participation.',
          'Access to appropriate wellness activities.',
          'Programme monitoring and evaluation.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Workplace Health Promotion Programme',
        requirements: [
          'As far as reasonably practicable, the workplace health promotion programme shall provide access to stress-management activities.',
          'The programme shall provide access to physical activity options.',
          'The programme shall provide access to healthy food choices.',
          'The workplace shall support a smoke-free environment.',
          'Initiatives shall have defined goals, objectives, activities and methods for evaluating their effectiveness.',
        ],
        hazards: [
          'Unmanaged workplace stress.',
          'Sedentary work and limited opportunities for physical activity.',
          'Poor food choices where healthier options are not available.',
          'Exposure to tobacco smoke in workplace environments.',
        ],
        controls: [
          'Stress-management resources.',
          'Reasonable opportunities for physical activity.',
          'Healthy food choices in applicable workplace facilities.',
          'Smoke-free workplace arrangements.',
          'Worker communication and participation.',
        ],
        documents: [
          'Wellness programme objectives.',
          'Initiative plans and activity records.',
          'Process, impact and outcome evaluation records.',
          'Programme review and improvement records.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Environmental and Workplace Factors Affecting Wellness',
        requirements: [
          'Programme evaluation shall consider workplace and environmental factors that can affect wellness.',
          'Relevant factors may include workplace stress, ventilation, indoor air quality and lighting.',
          'Where a workplace factor is identified as contributing to poor wellbeing, it shall be addressed through the appropriate OSH management process.',
          'Wellness concerns shall not be used as a substitute for controlling an underlying occupational hazard.',
        ],
        hazards: [
          'Poor indoor air quality.',
          'Unsuitable lighting.',
          'Excessive workplace stress.',
          'Poor workplace environmental conditions.',
        ],
        controls: [
          'Environmental inspection and monitoring where required.',
          'Engineering controls for identified workplace conditions.',
          'Risk assessment and corrective action.',
          'Worker feedback and consultation.',
        ],
        inspection: [
          'Review wellness complaints and recurring themes.',
          'Check environmental conditions identified by the programme.',
          'Review corrective actions for workplace factors affecting wellbeing.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Monitoring, Evaluation and Reporting',
        requirements: [
          'Employers shall evaluate the process, impact and outcome of workplace wellness initiatives.',
          'Evaluation shall determine whether initiatives are implemented as planned and achieving the intended effect.',
          'Unintended negative consequences shall be identified and addressed.',
          'Evaluation results shall inform subsequent planning and improvement.',
          'The required programme information shall be documented and made available to the concerned Sector Regulatory Authority upon request.',
        ],
        documents: [
          'Goals and objectives.',
          'Strategies and activities implemented.',
          'Evaluation methods.',
          'Evaluation results.',
          'Improvement actions.',
        ],
        inspection: [
          'Check programme implementation against plan.',
          'Check evaluation evidence.',
          'Check corrective actions arising from evaluation.',
          'Check documentation is complete and retrievable.',
        ],
      ),
    ],
    fieldChecklist: [
      'Workplace wellness programme is defined.',
      'Stress-management activities are accessible where applicable.',
      'Physical activity options are available where reasonably practicable.',
      'Healthy food choices are supported where applicable.',
      'Workplace is smoke-free.',
      'Environmental factors affecting wellness are considered.',
      'Worker feedback is considered.',
      'Programme outcomes are evaluated and documented.',
      'Improvement actions are tracked to completion.',
    ],
    stopWorkIndicators: [
      'An identified workplace condition presents an immediate serious health risk and has not been controlled.',
      'A wellness-related concern reveals an uncontrolled occupational hazard requiring immediate intervention.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 9.0 – Workplace Wellness, Version 4.0, 15 July 2024.',
      'ADOSH-SF Element 2 – Risk Management, where workplace risks require assessment and control.',
    ],
  );

  static const cop91NewAndExpectantMothers = AbuDhabiCopDocument(
    code: 'CoP 9.1',
    title: 'New and Expectant Mothers',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 9.1 requires employers to consider additional occupational health and safety risks for new, expectant and breastfeeding mothers. The central control is an appropriate risk assessment that considers the individual circumstances and the work factors that may affect the worker or her child.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Roles, Responsibilities and Confidential Communication',
        requirements: [
          'Employers shall consider the additional OSH risks associated with new, expectant and breastfeeding mothers.',
          'Workers should be encouraged to communicate relevant circumstances so that appropriate risk assessment and controls can be considered.',
          'Risk assessment and control measures shall involve the worker so that the arrangements are practical for her circumstances.',
          'Relevant information shall be communicated to persons who need to implement workplace controls while respecting appropriate privacy and confidentiality.',
        ],
        hazards: [
          'Failure to recognise changing work-related risks during pregnancy or after birth.',
          'Work arrangements that do not reflect individual circumstances.',
          'Inadequate communication of agreed workplace controls.',
        ],
        controls: [
          'Individual risk assessment.',
          'Worker consultation.',
          'Confidential communication of necessary control information.',
          'Regular review as circumstances change.',
        ],
        documents: [
          'New and expectant mother risk assessment.',
          'Control and review records.',
          'Consultation records where appropriate.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Additional Risk Assessment Considerations',
        requirements: [
          'The risk assessment shall consider the individual circumstances of the worker and the characteristics of the work.',
          'Relevant work factors may include manual handling, posture, prolonged standing or sitting, hot conditions, confined areas, protective clothing, slippery or wet surfaces, overtime and evening work.',
          'Work factors shall be assessed for their potential effect on the worker and the unborn or breastfeeding child, as applicable.',
          'Controls shall be reviewed when the worker reports a change in health or circumstances or when workplace conditions change.',
        ],
        hazards: [
          'Manual handling and awkward posture.',
          'Prolonged standing or sitting.',
          'Heat exposure.',
          'Restricted access to toilets or difficulty leaving the work area.',
          'Confined work areas or restrictive protective clothing.',
          'Slippery or wet surfaces and balance-related risks.',
          'Long hours, overtime or evening work.',
        ],
        controls: [
          'Modify work methods or tasks where required by the risk assessment.',
          'Reduce or control exposure to relevant physical and environmental hazards.',
          'Provide suitable access to welfare facilities and rest arrangements.',
          'Review working patterns where risk assessment identifies a need.',
          'Use additional engineering or administrative controls before relying on personal precautions.',
        ],
        inspection: [
          'Review workplace conditions against the individual risk assessment.',
          'Check agreed controls remain practical and effective.',
          'Check changes in work or environment have been assessed.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Breastfeeding Mothers and Workplace Arrangements',
        requirements: [
          'Workplace arrangements shall consider the needs of breastfeeding mothers as required by the applicable risk assessment and CoP requirements.',
          'Relevant work conditions, access arrangements and welfare facilities shall be considered so that breastfeeding-related needs can be managed safely.',
          'The worker shall be consulted about practical arrangements and any changes needed to control identified risks.',
        ],
        hazards: [
          'Inadequate welfare arrangements.',
          'Exposure to workplace contaminants where breastfeeding-related risks are identified.',
          'Work patterns that make agreed arrangements impractical.',
        ],
        controls: [
          'Suitable welfare and hygiene arrangements.',
          'Individual risk assessment and consultation.',
          'Control of relevant chemical, biological or environmental exposures.',
        ],
        documents: [
          'Risk assessment and review records.',
          'Workplace control arrangements where applicable.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Risk Assessment Review and Change Management',
        requirements: [
          'The risk assessment shall be treated as a live document and reviewed when circumstances change.',
          'The official CoP and associated ADOSH-SF guidance shall be used to determine applicable review points and controls.',
          'Reviews shall consider changes in health, medication, work environment, duties, work patterns or other relevant circumstances.',
          'Agreed changes shall be communicated to the persons responsible for implementing them.',
        ],
        controls: [
          'Scheduled and trigger-based review.',
          'Worker consultation.',
          'Documented control changes.',
          'Follow-up verification of implemented controls.',
        ],
        inspection: [
          'Check the current risk assessment is available.',
          'Check review triggers have been considered.',
          'Check agreed controls are implemented.',
          'Check further review is initiated when workplace conditions change.',
        ],
      ),
    ],
    fieldChecklist: [
      'Individual risk assessment completed when required.',
      'Worker has been consulted about practical controls.',
      'Manual handling and posture risks considered.',
      'Heat and environmental exposure considered.',
      'Toilet and welfare access considered.',
      'Slips, trips and balance risks considered.',
      'Overtime/evening work and work patterns considered.',
      'Breastfeeding-related workplace needs considered where applicable.',
      'Risk assessment is reviewed when circumstances change.',
      'Control changes are communicated to responsible persons.',
    ],
    stopWorkIndicators: [
      'A significant pregnancy, post-birth or breastfeeding-related workplace risk is identified with no effective control.',
      'A task cannot be safely performed under the current individual risk assessment and no suitable alternative control is in place.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 9.1 – New and Expectant Mothers, Version 4.0, 15 July 2024.',
      'ADOSH-SF Technical Guideline – New and Expectant Mothers, Version 4.0, 15 July 2024, for additional practical guidance.',
    ],
  );

  static const cop92WorkRelatedStress = AbuDhabiCopDocument(
    code: 'CoP 9.2',
    title: 'Managing Work-Related Stress',
    version: '4.0',
    effectiveDate: '15 July 2024',
    introduction:
        'CoP 9.2 establishes requirements for managing work-related stress through risk assessment and work-design controls. The programme is organised around six key areas: demands, control, support, relationships, role and change.',
    sections: [
      AbuDhabiCopSection(
        number: '1.0',
        title: 'Work-Related Stress Risk Assessment',
        requirements: [
          'Work-related stress management programmes shall be based on appropriate risk assessment in accordance with ADOSH-SF risk-management requirements.',
          'The assessment shall consider organisational and work-design factors rather than treating stress only as an individual problem.',
          'Workers should be consulted as part of the risk assessment and control process.',
          'Controls shall be reviewed when work organisation, staffing, workload or other relevant conditions change.',
        ],
        hazards: [
          'Excessive workload or unrealistic demands.',
          'Low control over work pace or methods.',
          'Insufficient management or colleague support.',
          'Poor workplace relationships or unacceptable behaviour.',
          'Unclear or conflicting roles.',
          'Poorly managed organisational change.',
        ],
        controls: [
          'Organisational and work-design controls.',
          'Worker consultation and feedback.',
          'Management support and clear communication.',
          'Monitoring of identified psychosocial risk factors.',
        ],
        documents: [
          'Work-related stress risk assessment.',
          'Action plan and corrective-action records.',
          'Worker consultation records where appropriate.',
        ],
      ),
      AbuDhabiCopSection(
        number: '2.0',
        title: 'Demands and Workload',
        requirements: [
          'Employees shall be provided with appropriate and achievable demands in relation to agreed hours of work.',
          'Employees skills and abilities shall be matched to job demands.',
          'Jobs shall be designed within the capabilities of employees.',
          'Concerns about the work environment shall be considered and addressed.',
          'Workload, work patterns and the work environment shall be considered during assessment.',
        ],
        hazards: [
          'Excessive workload.',
          'Unachievable deadlines.',
          'Insufficient staffing or resources.',
          'Unsuitable work patterns or excessive working hours.',
        ],
        controls: [
          'Workload planning.',
          'Adequate staffing and resources.',
          'Realistic deadlines and priorities.',
          'Review of work patterns and hours.',
          'Matching skills and capabilities to work demands.',
        ],
        inspection: [
          'Review workload and staffing indicators.',
          'Check recurring concerns and complaints.',
          'Check agreed work patterns and hours.',
          'Verify actions taken for identified excessive demands.',
        ],
      ),
      AbuDhabiCopSection(
        number: '3.0',
        title: 'Control, Support and Worker Participation',
        requirements: [
          'Where reasonably practicable, employees should have control over their pace of work.',
          'Employees should be encouraged to use skills and initiative in their work.',
          'Where reasonably practicable, employees should be encouraged to develop skills for new and challenging work.',
          'Employees should have an appropriate say over when breaks are taken within operational constraints.',
          'Employees should be consulted over their work patterns.',
          'Support shall include appropriate encouragement, resources and management support.',
        ],
        hazards: [
          'Low autonomy and lack of control.',
          'Insufficient support from supervisors or colleagues.',
          'Lack of resources or training.',
          'Limited worker participation in work arrangements.',
        ],
        controls: [
          'Appropriate worker autonomy.',
          'Supervisor and management support.',
          'Training and skills development.',
          'Consultation and feedback mechanisms.',
          'Adequate resources for assigned work.',
        ],
        documents: [
          'Consultation records.',
          'Training and development records.',
          'Action plans for identified psychosocial risks.',
        ],
      ),
      AbuDhabiCopSection(
        number: '4.0',
        title: 'Relationships, Role and Workplace Behaviour',
        requirements: [
          'The workplace shall promote positive working relationships and an environment where conflict and unacceptable behaviour are appropriately addressed.',
          'Employees should understand their role within the organisation.',
          'Employers shall avoid conflicting role expectations where practicable.',
          'Relevant concerns shall be addressed through established workplace procedures.',
        ],
        hazards: [
          'Workplace conflict.',
          'Bullying, harassment or unacceptable behaviour.',
          'Unclear responsibilities.',
          'Conflicting demands from different managers or functions.',
        ],
        controls: [
          'Clear roles and responsibilities.',
          'Positive leadership and communication.',
          'Accessible reporting and grievance mechanisms.',
          'Prompt investigation and corrective action where required.',
        ],
        inspection: [
          'Review recurring relationship or role concerns.',
          'Check reporting routes are known and accessible.',
          'Check corrective actions for identified issues.',
        ],
      ),
      AbuDhabiCopSection(
        number: '5.0',
        title: 'Managing Organisational Change',
        requirements: [
          'Organisational changes shall be planned and communicated in a manner that considers work-related stress risks.',
          'Employees shall receive appropriate information about significant changes affecting their work.',
          'The effect of changes on workload, roles, control, support and work patterns shall be considered.',
          'Change-related concerns shall be monitored and addressed through the risk-management process.',
        ],
        hazards: [
          'Uncertainty about employment or role changes.',
          'Sudden changes to workload or work patterns.',
          'Insufficient communication.',
          'Loss of support or resources during change.',
        ],
        controls: [
          'Change planning and communication.',
          'Worker consultation.',
          'Updated risk assessment.',
          'Adequate transition support and resources.',
        ],
        inspection: [
          'Check change-related risk assessment.',
          'Check communication and consultation evidence.',
          'Check actions for identified stress risks.',
        ],
      ),
      AbuDhabiCopSection(
        number: '6.0',
        title: 'Monitoring, Review and Continual Improvement',
        requirements: [
          'The effectiveness of work-related stress controls shall be reviewed using appropriate information and worker feedback.',
          'Corrective actions shall address identified root causes where practicable.',
          'The programme shall be reviewed when significant organisational or work-design changes occur.',
          'Confidentiality shall be respected when handling personal or sensitive worker information.',
        ],
        controls: [
          'Periodic programme review.',
          'Worker consultation.',
          'Trend analysis of relevant indicators.',
          'Corrective and preventive actions.',
        ],
        documents: [
          'Stress risk assessment reviews.',
          'Action tracker.',
          'Consultation records.',
          'Programme review records.',
        ],
        inspection: [
          'Check actions are implemented and effective.',
          'Review recurring work-design concerns.',
          'Verify significant changes trigger reassessment.',
        ],
      ),
    ],
    fieldChecklist: [
      'Work-related stress risks have been assessed.',
      'Demands and workload are achievable.',
      'Skills and abilities are matched to job demands.',
      'Workers have appropriate control and participation.',
      'Management and colleague support is available.',
      'Workplace relationship concerns have reporting routes.',
      'Roles and responsibilities are clear.',
      'Organisational change is communicated and assessed.',
      'Corrective actions are monitored for effectiveness.',
    ],
    stopWorkIndicators: [
      'A psychosocial or organisational condition creates an immediate serious risk to worker safety or health requiring urgent intervention.',
      'A significant work-design change has introduced a serious uncontrolled risk that has not been assessed.',
    ],
    references: [
      'ADPHC ADOSH-SF CoP 9.2 – Managing Work-Related Stress, Version 4.0, 15 July 2024.',
      'ADOSH-SF Element 2 – Risk Management.',
    ],
  );
}
