
class WorkerWelfareGoldPoint {
  final String title;
  final String content;

  const WorkerWelfareGoldPoint({
    required this.title,
    required this.content,
  });
}

class WorkerWelfareGoldSection {
  final String title;
  final List<WorkerWelfareGoldPoint> points;

  const WorkerWelfareGoldSection({
    required this.title,
    required this.points,
  });
}

const List<WorkerWelfareGoldSection> workerWelfareGoldStandardSections = [
  WorkerWelfareGoldSection(
    title: '01. Purpose and Scope',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Worker welfare means providing safe, healthy, hygienic and suitable workplace facilities and arrangements that support worker health, dignity and safe performance. Welfare planning shall cover the workplace and, where applicable, employer-supplied accommodation, transport, food and related services. Requirements shall be matched to the work activity, workforce size, location, environmental conditions and applicable Abu Dhabi requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '02. Welfare Planning',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare requirements shall be identified during project planning and incorporated into the OSH management system, site layout and mobilization plan. Consider workforce numbers, gender, shifts, remote areas, hot-weather exposure, accessibility, emergency access, cleaning arrangements, water supply, sanitation, accommodation interfaces and contractor responsibilities before work starts.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '03. Drinking Water',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide a reliable supply of suitable potable drinking water in accessible locations. Protect water from contamination, maintain clean dispensers and containers, provide hygienic drinking arrangements and monitor availability throughout the shift. Water provision shall be increased or relocated when work conditions, workforce distribution or heat exposure require it.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '04. Water Hygiene',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Drinking-water containers, coolers, dispensers and associated equipment shall be clean, protected and maintained. Do not permit practices that can contaminate shared drinking facilities. Any suspected contamination, damaged container or unsafe supply shall be isolated and corrected promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '05. Toilets and Sanitary Conveniences',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable sanitary conveniences that are accessible, hygienic, adequately maintained and appropriate for the workforce and work location. Toilets shall be kept clean, supplied, serviced and positioned so workers can use them without unnecessary exposure to traffic, hazards or excessive travel distance.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '06. Washing Facilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable washing facilities where work creates a need for personal cleaning. Facilities shall have an adequate supply of suitable water and hygiene supplies as applicable to the work. Increase cleaning and servicing where contamination, chemicals, dust, oils or other occupational exposures make this necessary.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '07. Rest Areas',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable rest facilities protected from workplace hazards and environmental conditions. Rest areas shall be kept clean and maintained, with sufficient seating and arrangements appropriate to the workforce and work pattern. Rest facilities shall not be used for storage of hazardous materials or equipment.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '08. Heat and Weather Protection',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare arrangements shall support the controls required for hot, humid, dusty, rainy or otherwise severe weather. Provide suitable shaded or cooled recovery areas and drinking-water arrangements as required by the applicable heat-management controls. Coordinate welfare planning with ADOSH-SF Safety in the Heat requirements and the site heat-stress risk assessment.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '09. Changing and Drying Facilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where the work requires workers to change clothing or remove contaminated or wet workwear, provide suitable arrangements that maintain hygiene, privacy and separation from clean clothing and food areas. Facilities shall be maintained so contaminated clothing does not create secondary exposure.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '10. Eating and Meal Areas',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Designate clean eating areas separated from hazardous work, chemicals, waste, dust-generating activities and contaminated equipment. Maintain tables, seating, cleaning arrangements and waste controls. Food shall not be stored or consumed in areas where contamination from work activities can occur.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '11. Food Hygiene Interface',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where food is prepared, handled or served as part of the workplace arrangement, coordinate welfare controls with applicable occupational food-handling requirements. Food preparation areas shall be hygienic, suitably maintained and protected from contamination. Food-service contractors shall have defined responsibilities and monitoring arrangements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '12. Accommodation Interface',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where accommodation is supplied or controlled by the employer, welfare planning shall interface with the applicable Abu Dhabi accommodation requirements. Workplace welfare controls do not replace accommodation-specific requirements. Responsibilities for accommodation management, hygiene, maintenance, emergency arrangements and reporting shall be clearly assigned.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '13. Temporary Accommodation',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Temporary employer-supplied accommodation shall be planned, operated and maintained in accordance with the applicable Abu Dhabi requirements. Consider fire safety, sanitation, potable water, ventilation, cleanliness, emergency access, electrical safety, waste control, occupancy management and maintenance. Licensing and authority requirements shall also be considered.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '14. Ventilation and Indoor Conditions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare and occupied areas shall have suitable ventilation and indoor environmental conditions. HVAC and ventilation systems shall be maintained and kept free from conditions that could create health risks. Do not allow welfare spaces to become excessively hot, poorly ventilated, contaminated or overcrowded.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '15. Lighting',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable lighting for welfare areas, access routes, toilets, washing facilities, eating areas and other occupied spaces. Lighting shall support safe movement, cleaning, inspection and emergency response. Defective lighting shall be reported and corrected.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '16. Housekeeping',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare areas shall be maintained clean, orderly and free from unnecessary obstructions. Cleaning schedules shall be documented where appropriate. Spillages, food waste, standing water, damaged fixtures, blocked access and unhygienic conditions shall be corrected promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '17. Waste Management',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide suitable waste containers near welfare and eating areas. Waste shall be removed at an appropriate frequency to prevent accumulation, odour, pests and hygiene problems. Waste segregation shall follow the site waste-management plan and applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '18. Pest and Vector Control',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Prevent conditions that attract insects, rodents and other pests. Control food waste, standing water, damaged waste containers and poor housekeeping. Where pest-control treatments are required, use competent service providers and manage chemicals so workers are not exposed unnecessarily.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '19. First Aid and Medical Access',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare planning shall interface with the site first-aid and medical emergency arrangements. Workers shall know how to obtain assistance, where first-aid resources are located and how emergencies are communicated. Access routes for emergency response shall remain clear.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '20. Worker Transportation',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Where the employer provides transportation, vehicles and transport arrangements shall be suitable for the intended journey and workforce. Vehicle safety, driver competence, passenger management, seat-belt use, loading restrictions, maintenance, emergency arrangements and fatigue controls shall be addressed under the applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '21. Welfare Access and Location',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Locate welfare facilities so workers can access them safely without crossing unnecessary traffic routes, lifting zones, excavation edges, hazardous-energy areas or other restricted zones. Provide safe pedestrian access and keep routes unobstructed.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '22. Accessibility and Special Needs',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Consider workers with disabilities, temporary limitations or other special access requirements when planning welfare facilities. Access routes, sanitary facilities, seating, emergency arrangements and communication methods shall be suitable for the workforce and applicable requirements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '23. Privacy and Dignity',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare facilities shall protect privacy and dignity. Toilets, washing, changing and accommodation arrangements shall be designed and managed so workers can use them safely and respectfully. Where the workforce requires separate facilities, the site shall provide suitable arrangements.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '24. Contractor and Subcontractor Welfare',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Principal contractors and employers shall define welfare responsibilities for contractors and subcontractors. Site induction, welfare access, facility servicing, complaints, inspections, accommodation interfaces and corrective actions shall be coordinated so every worker receives the applicable welfare protections.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '25. Worker Information and Communication',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Workers shall be informed about welfare facilities, locations, permitted use, hygiene expectations, emergency arrangements and how to report shortages or unsafe conditions. Information shall be communicated in a form workers can understand.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '26. Worker Complaints and Reporting',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Provide a practical method for workers to report missing water, sanitation problems, excessive heat, poor hygiene, overcrowding, damaged facilities or other welfare concerns. Reports shall be recorded where required, investigated and closed with corrective action. Workers should not be discouraged from raising genuine welfare concerns.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '27. Welfare Inspection and Monitoring',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Inspect welfare facilities at a frequency appropriate to workforce size, usage, risk and environmental conditions. Check water availability, sanitation, cleanliness, supplies, temperature or ventilation where relevant, waste, pest control, access, lighting, damage and emergency access. Record findings and track corrective actions.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '28. Competency and Responsibilities',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Assign clear responsibilities for welfare planning, facility provision, cleaning, servicing, inspection, maintenance and corrective actions. Supervisors shall monitor day-to-day conditions. HSE personnel shall verify compliance and escalate deficiencies. Contractors shall meet their assigned welfare obligations.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '29. RAMS, Risk Assessment and Welfare',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Welfare needs shall be considered during risk assessment and method planning, particularly for remote work, large workforces, night shifts, hot-weather activities, contaminated work, work at isolated locations and activities requiring special hygiene arrangements. Welfare controls shall be reviewed when conditions change.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '30. Emergency Welfare Arrangements',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Emergency planning shall consider loss of potable water, failure of sanitation, severe weather, fire, medical events, accommodation emergencies, utility failure and evacuation. Emergency routes and assembly areas shall remain usable, and welfare facilities shall not obstruct emergency response.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '31. Stop-Work and Escalation Conditions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Escalate immediately where welfare deficiencies create a significant health or safety risk. Examples include unavailable potable drinking water during heat exposure, severely unhygienic sanitary facilities, unsafe accommodation conditions, blocked emergency access, serious electrical or fire hazards in welfare areas, contaminated water or conditions that make the facility unsafe to use. Correct the deficiency before affected work or occupancy continues where required by the risk.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '32. Unsafe Practices and Corrective Actions',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Unsafe practices include drinking non-potable water, storing chemicals in eating areas, using welfare rooms as material stores, ignoring sanitation failures, allowing waste accumulation, blocking welfare access, bypassing cleaning schedules, overcrowding facilities or failing to report serious welfare deficiencies. Corrective actions shall address the immediate condition and the underlying cause.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '33. Toolbox Talk Points',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Explain welfare locations, drinking-water arrangements, toilet and washing facilities, rest areas, eating rules, heat recovery arrangements, hygiene, waste disposal, emergency contacts and reporting channels. Reinforce that welfare facilities are part of the site safety system and that workers should report deficiencies promptly.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '34. Field Checklist',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Verify: potable drinking water available; dispensers clean; toilets accessible and hygienic; washing facilities functional; rest areas suitable; heat protection available; eating areas clean; waste controlled; pest issues controlled; lighting adequate; ventilation suitable; access routes clear; first-aid access maintained; transport arrangements controlled; contractor welfare responsibilities understood; inspections recorded; corrective actions closed.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '35. Quick Reference',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'FIELD RULE: PLAN welfare before mobilization. PROVIDE suitable facilities. KEEP them clean and serviceable. MONITOR water, sanitation, heat protection and hygiene. INFORM workers. REPORT deficiencies. CORRECT promptly. VERIFY during inspections. Welfare is an OSH control, not an optional site convenience.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '36. UAE and Abu Dhabi Applicability',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'For Abu Dhabi projects, welfare controls shall be aligned with the applicable ADOSH-SF requirements and the requirements of the relevant sector and authority. The official ADPHC Code of Practices registry lists CoP 8.0 General Workplace Amenities, CoP 18.0 Employer Supplied Accommodation - General Requirements, CoP 18.1 Temporary Employer Supplied Accommodation, CoP 11.0 Safety in the Heat, CoP 4.0 First Aid and Medical Emergency Treatment, CoP 16.0 OSH Requirements for People with Special Needs and CoP 19.0 Occupational Food Handling and Food Preparation Areas. Apply the requirement that is relevant to the actual activity and facility.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '37. Related CoPs and Cross References',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Cross-reference welfare controls with CoP 8.0 General Workplace Amenities; CoP 11.0 Safety in the Heat; CoP 16.0 OSH Requirements for People with Special Needs; CoP 18.0 Employer Supplied Accommodation - General Requirements; CoP 18.1 Temporary Employer Supplied Accommodation; CoP 19.0 Occupational Food Handling and Food Preparation Areas; CoP 4.0 First Aid and Medical Emergency Treatment; and CoP 54.0 Waste Management, as applicable.',
      ),
    ],
  ),
  WorkerWelfareGoldSection(
    title: '38. Official Regulatory References',
    points: [
      WorkerWelfareGoldPoint(
        title: 'Key Controls',
        content:
            'Primary official reference: Abu Dhabi Public Health Centre (ADPHC), Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF), Code of Practices registry. Current registry information identifies CoP 8.0 General Workplace Amenities, Version 4.0 effective 15 July 2024; CoP 18.0 Employer Supplied Accommodation - General Requirements, Version 4.0 effective 15 July 2024; and CoP 18.1 Temporary Employer Supplied Accommodation, Version 4.0 effective 15 July 2024. Always verify the official ADPHC registry and applicable authority requirements before relying on legal or numerical requirements in the field.',
      ),
    ],
  ),
];
