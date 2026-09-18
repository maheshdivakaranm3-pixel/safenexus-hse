/// SafeNexus HSE — Abu Dhabi HSE Gold Standard
/// Topic: Safety in the Heat / Working in Hot & Humid Climate
/// Regulatory basis: ADOSH-SF CoP 11.0, Version 4.0, effective 15 July 2024.
///
/// Structured reference content. Site heat-management procedures, medical
/// guidance, risk assessments and current official requirements remain applicable.

class SafetyInHeatGoldPoint {
  final String title;
  final List<String> points;

  const SafetyInHeatGoldPoint({required this.title, required this.points});
}

class SafetyInHeatGoldSection {
  final String number;
  final String title;
  final List<SafetyInHeatGoldPoint> points;

  const SafetyInHeatGoldSection({
    required this.number,
    required this.title,
    required this.points,
  });
}

const List<SafetyInHeatGoldSection> safetyInHeatGoldStandardSections = [
  SafetyInHeatGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat exposure occurs when environmental heat, humidity, radiant heat, workload, clothing and individual factors reduce the body\'s ability to lose heat. The purpose is to prevent heat-related illness and maintain safe work performance.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '02',
    title: 'Scope & Applications',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Applies to outdoor and indoor work where heat exposure can occur, including construction, road work, lifting, confined or poorly ventilated areas, workshops, kitchens and hot process areas.',
          'Controls must be adapted to the actual work, season, location, duration and exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '03',
    title: 'Heat Stress Hazards',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Key hazards include high air temperature, humidity, radiant heat, low air movement, heavy physical work, direct sunlight, hot surfaces, impermeable PPE, dehydration, inadequate acclimatization and long exposure duration.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '04',
    title: 'Heat Balance & Environmental Factors',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess temperature together with humidity, radiant heat, air movement, workload, clothing and exposure duration. Humidity can reduce evaporative cooling and increase heat strain.',
          'Do not judge heat risk from air temperature alone.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '05',
    title: 'Worker Heat-Illness Awareness',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Workers should know early symptoms and immediately report headache, dizziness, weakness, unusual fatigue, thirst, nausea, cramps, confusion or other abnormal symptoms.',
          'Workers must never be discouraged from reporting heat symptoms.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '06',
    title: 'Heat Cramps',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat cramps can occur during or after strenuous activity and sweating. Stop the activity, move the person to a cooler area, provide appropriate first aid and medical assessment according to the site procedure.',
          'Escalate if symptoms are severe, persistent or accompanied by signs of serious heat illness.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '07',
    title: 'Heat Exhaustion',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Possible signs include heavy sweating, weakness, dizziness, headache, nausea, thirst and reduced ability to continue work safely.',
          'Stop work, move to a cool area, cool the person, provide appropriate fluids if the person is alert and able to drink, and obtain medical assistance according to the emergency procedure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '08',
    title: 'Heat Stroke',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat stroke is a life-threatening emergency. Warning signs can include altered mental status, confusion, collapse, seizures or very high body temperature.',
          'Activate emergency medical response immediately and begin rapid cooling according to trained first-aid procedures. Do not leave the casualty alone.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '09',
    title: 'Risk Assessment',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess heat exposure as part of the risk-management process, considering task, location, season, weather, workload, clothing, worker acclimatization, duration, breaks, hydration, supervision and emergency arrangements.',
          'Review the assessment when conditions or work methods change.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '10',
    title: 'Work Planning',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Plan heavy work for cooler periods where practicable, reduce unnecessary exposure, provide recovery opportunities and organize manpower so that heat exposure can be controlled.',
          'Use mechanization, job rotation and task redesign where practicable to reduce physical heat load.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '11',
    title: 'Acclimatization',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'New workers, workers returning after an extended absence and workers with limited recent heat exposure require a controlled acclimatization approach under the employer\'s heat-management procedure.',
          'Increase exposure and workload progressively while providing closer supervision and monitoring during acclimatization.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '12',
    title: 'Hydration',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide adequate cool potable drinking water at accessible locations close to the work.',
          'Encourage workers to drink regularly rather than waiting until severe thirst develops. Apply the employer\'s approved hydration program and medical guidance for electrolyte replacement where appropriate.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '13',
    title: 'Rest & Recovery',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide suitable rest or recovery arrangements based on the heat-risk assessment and applicable ADOSH requirements.',
          'Recovery areas should reduce heat exposure and provide shade or cooling as appropriate.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '14',
    title: 'Shade & Cooling',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide effective shaded or cooled recovery areas appropriate to the worksite and number of workers.',
          'Use ventilation, fans, air conditioning, evaporative cooling or other suitable engineering controls where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '15',
    title: 'Ventilation & Air Movement',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Improve air movement and ventilation where it reduces heat accumulation and does not introduce another hazard.',
          'For indoor hot processes, control the heat source and exhaust hot air or steam where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '16',
    title: 'Clothing & PPE',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Select clothing and PPE that provide required protection while minimizing unnecessary heat burden.',
          'Consider breathable or task-suitable clothing where compatible with the hazard. Do not remove mandatory PPE to manage heat without an approved alternative control.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '17',
    title: 'Workload & Physical Exertion',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Assess metabolic workload. Heavy lifting, manual handling, repetitive work and high-force tasks increase heat strain.',
          'Use mechanical aids, team lifting, task rotation and work redesign where practicable.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '18',
    title: 'Sun & Radiant Heat',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Control direct solar exposure using shade, scheduling, suitable clothing and recovery arrangements.',
          'Radiant heat from furnaces, hot equipment, concrete, asphalt or other surfaces must also be considered.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '19',
    title: 'Humidity & Poor Air Movement',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'High humidity reduces the body\'s ability to lose heat through sweat evaporation. Poor air movement can further reduce cooling.',
          'Increase monitoring and controls when humidity and heat combine to create significant heat strain.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '20',
    title: 'Indoor & Enclosed Hot Areas',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Identify workshops, plant rooms, kitchens, tanks, roofs, poorly ventilated areas and other locations where heat can accumulate.',
          'Provide ventilation, cooling, work-rest arrangements and monitoring appropriate to the assessed exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '21',
    title: 'High-Risk Work & Individuals',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Consider strenuous work, high PPE burden, heat-sensitive tasks, remote locations and workers who may be at increased risk based on relevant occupational-health advice.',
          'Do not make assumptions about an individual\'s medical condition. Use occupational-health processes where individual assessment is required.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '22',
    title: 'Monitoring & Supervision',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Supervisors should monitor environmental conditions, work intensity, hydration access, rest arrangements and worker behavior or symptoms.',
          'Increase monitoring during extreme conditions, acclimatization and high-risk tasks.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '23',
    title: 'Buddy System & Communication',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Use buddy or team monitoring where appropriate so workers can recognize early signs of heat illness in themselves and others.',
          'Provide clear communication routes for requesting water, rest, medical help or stopping work.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '24',
    title: 'Emergency Preparedness',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'The site heat-emergency plan should define alarm/communication, first aid, cooling, medical escalation, transport, access for emergency services and responsibilities.',
          'Ensure emergency equipment and trained first-aid personnel are available as required by the site arrangements.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '25',
    title: 'First Aid & Immediate Response',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Move the affected person away from heat, stop exertion and begin appropriate cooling and first aid while arranging medical assistance according to the severity of symptoms.',
          'Do not allow an unwell worker to return to heat exposure until appropriately assessed and cleared under the site\'s medical process.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '26',
    title: 'RAMS / JSA / PTW Interface',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Heat controls must be incorporated into RAMS/JSA and task risk assessments where heat exposure exists.',
          'Where a permit is required, heat-related controls should be reflected in the permit conditions and pre-work verification.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '27',
    title: 'Site Facilities & Welfare',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Provide accessible drinking water, suitable sanitation and recovery facilities in accordance with applicable workplace welfare requirements.',
          'Locate facilities so workers can use them without excessive additional heat exposure.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '28',
    title: 'Weather & Work-Schedule Management',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Monitor reliable weather information and site conditions. Adjust scheduling, workload, manpower and controls when heat conditions increase.',
          'Do not rely on a calendar date alone; actual conditions and applicable regulatory requirements must be considered.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '29',
    title: 'Inspection & Verification',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Supervisors and HSE personnel should verify water availability, shade/cooling, signage, monitoring arrangements, emergency readiness and compliance with the heat-management plan.',
          'Record inspections and corrective actions according to the site system.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '30',
    title: 'Competency & Responsibilities',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Employers provide the heat-management system and resources. Supervisors implement and monitor controls. HSE verifies compliance and supports risk assessment. Workers follow controls, hydrate, use rest arrangements and report symptoms.',
          'Training should cover heat hazards, symptoms, prevention, reporting and emergency response.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '31',
    title: 'Stop-Work Conditions',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Stop or modify work when heat conditions exceed the approved control basis, cooling/rest arrangements are unavailable, water is unavailable, emergency arrangements fail, workers show heat-illness symptoms, or the risk assessment is no longer adequate.',
          'Restart only after effective controls are restored and the responsible authority confirms safe conditions.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '32',
    title: 'Unsafe Practices → Corrective Actions',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Unsafe practices include hiding symptoms, refusing recovery breaks, inadequate water access, working alone without required controls, removing mandatory PPE, ignoring weather warnings and continuing symptomatic workers.',
          'Stop the unsafe activity, correct the control failure, provide appropriate assistance and verify before restart.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '33',
    title: 'Toolbox Talk',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Explain heat hazards, symptoms, hydration, rest and recovery, acclimatization, clothing/PPE, buddy monitoring, reporting, emergency response and stop-work authority.',
          'Remind workers that early reporting can prevent serious heat illness.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '34',
    title: 'Field Checklist',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          '☐ Heat-risk assessment reviewed',
          '☐ Weather/conditions checked',
          '☐ Drinking water accessible',
          '☐ Shade/cooling available',
          '☐ Rest/recovery arrangements ready',
          '☐ Acclimatization controls applied where needed',
          '☐ Supervisors briefed',
          '☐ Workers trained',
          '☐ Emergency/first-aid arrangements ready',
          '☐ Heat symptoms understood',
          '☐ Buddy monitoring arranged where required',
          '☐ Workload and schedule controlled',
          '☐ PPE suitable for heat exposure',
          '☐ Records and inspections maintained',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '35',
    title: 'Quick Reference',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'IDENTIFY HEAT → ASSESS EXPOSURE → PLAN → HYDRATE → COOL/REST → MONITOR → REPORT SYMPTOMS → RESPOND EARLY → REVIEW.',
          'Never ignore heat-illness symptoms. Heat stroke is a medical emergency.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '36',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'The Abu Dhabi reference is ADOSH-SF CoP 11.0 — Safety in the Heat, listed by ADPHC as Version 4.0 effective 15 July 2024.',
          'Abu Dhabi requirements must be distinguished from Dubai or other emirate requirements. Client and sector requirements may add controls.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '37',
    title: 'Related CoPs & Cross References',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'CoP 2.0 Personal Protective Equipment.',
          'CoP 3.0 Occupational Noise and CoP 3.1 Vibration.',
          'CoP 4.0 First Aid and Medical Emergency Treatment.',
          'CoP 5.0 Occupational Health Screening and Medical Surveillance.',
          'CoP 8.0 General Workplace Amenities.',
          'CoP 14.0 Manual Handling and Ergonomics.',
          'CoP 15.0 Electrical Safety.',
          'CoP 21.0 Permit to Work Systems.',
          'CoP 23.0 Working at Heights.',
          'CoP 25.0 Driver Fatigue Prevention.',
          'CoP 27.0 Confined Spaces.',
        ],
      ),
    ],
  ),
  SafetyInHeatGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    points: [
      SafetyInHeatGoldPoint(
        title: 'Key controls',
        points: [
          'Primary reference: Abu Dhabi Occupational Safety and Health Center (ADPHC), ADOSH-SF CoP 11.0 — Safety in the Heat, Version 4.0, effective 15 July 2024, as listed in the official CoP registry.',
          'Check the official ADPHC registry and current CoP document before relying on a legal or numerical requirement.',
        ],
      ),
    ],
  ),
];
