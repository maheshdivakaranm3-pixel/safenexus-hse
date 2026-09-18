class MewpGoldPoint {
  final String title;
  final String content;

  const MewpGoldPoint({
    required this.title,
    required this.content,
  });
}

class MewpGoldSection {
  final String title;
  final List<MewpGoldPoint> points;

  const MewpGoldSection({
    required this.title,
    required this.points,
  });
}

const List<MewpGoldSection> mewpGoldStandardSections = [
  MewpGoldSection(
    title: '01. Definition & Purpose',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Define MEWP use as work involving mobile elevating work platforms used to position people and tools at height, with controls for stability, falls, collision, entrapment, electrical contact and machine-specific hazards.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '02. Scope & Applications',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Cover scissor lifts, boom-type MEWPs, vertical mast platforms and other powered mobile platforms used for construction, maintenance, installation, inspection, access and similar work.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '03. MEWP Types',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify the machine type, operating principle, rated capacity, platform configuration, drive system, outreach and manufacturer limitations before selection and use.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '04. Selection & Suitability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Select a MEWP suitable for the task, working height, outreach, ground conditions, access route, environment, load, indoor/outdoor use and foreseeable hazards. Do not select equipment only by maximum height.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '05. Manufacturer Instructions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Follow the manufacturer\'s operating manual, rated capacity, configuration limits, warning labels, inspection instructions and emergency procedures. Manufacturer limitations shall not be overridden by site practice.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '06. Hazard Identification',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify overturning, falls, entrapment/crushing, collision, dropped objects, electrical contact, unstable ground, vehicle interface, wind, weather, mechanical failure, unauthorized use and unsafe access before operation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '07. Risk Assessment & RAMS/JSA',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Include MEWP hazards in the task risk assessment and RAMS/JSA. Define machine selection, controls, exclusion zones, rescue, traffic interface, weather limits, emergency arrangements and competent-person responsibilities.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '08. Ground Conditions & Stability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Verify ground strength, level, bearing capacity, slopes, voids, trenches, edges, underground services and hidden hazards. Use manufacturer-approved stabilisation arrangements where applicable and prevent travel over unsuitable ground.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '09. Outriggers, Stabilizers & Levelling',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Where fitted, deploy outriggers or stabilizers exactly as specified by the manufacturer. Use suitable ground protection where required. Confirm the machine is stable and level before elevation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '10. Load & Capacity Control',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Never exceed the rated platform load or configuration limits. Include people, tools, materials and accessories in the load. Respect reduced capacity caused by outreach, platform configuration or other manufacturer-defined conditions.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '11. Fall Prevention',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Keep workers inside the designated platform and use the machine\'s prescribed guardrails, gates and access systems. Do not climb on guardrails, use boxes or improvised platforms, or lean outside the platform to gain additional reach.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '12. Harness & Personal Fall Protection',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use personal fall protection where required by the machine manufacturer, risk assessment and applicable requirements. Connect only to designated anchorage points and use compatible equipment. Never attach to unsuitable structural parts.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '13. Access & Egress',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use the designated access gate, steps or ladder. Keep access points clear. Do not enter or leave an elevated platform except where a specifically planned, risk-assessed and authorised procedure permits it.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '14. Overhead Electrical Hazards',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Identify overhead and nearby electrical services before positioning or travelling. Maintain the applicable separation distances and controls required by the authority, utility owner, risk assessment and manufacturer. Treat unidentified lines as potentially energised until verified.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '15. Collision & Entrapment',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Control crushing and trapping between the platform, structure, ceiling, beams, pipework or other obstacles. Use a spotter or other control where visibility is restricted and maintain effective communication.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '16. Traffic & Pedestrian Interface',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Separate MEWP operations from vehicles and pedestrians using suitable barriers, exclusion zones, signs, traffic controls and spotters where required. Control reversing, blind areas and interaction with mobile plant.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '17. Wind & Weather',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Operate only within manufacturer and site weather limits. Stop or lower the platform when wind, lightning, heavy rain, poor visibility, sandstorms or other conditions make operation unsafe.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '18. Working Near Edges, Openings & Excavations',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Maintain safe clearance from unprotected edges, excavations, shafts, slopes and floor openings. Assess ground failure and overturning risk, especially when travelling or positioning close to an edge.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '19. Dropped Objects & Exclusion Zones',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Prevent tools and materials from falling from the platform. Secure suitable tools, maintain housekeeping and establish exclusion zones below or around elevated work where people or property could be exposed.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '20. Tools, Materials & Attachments',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Use only tools and attachments permitted by the manufacturer and risk assessment. Do not use the platform as a crane, lifting point or material-handling device unless specifically designed and approved for that purpose.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '21. Pre-Use Inspection',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Before each use or shift, inspect controls, emergency stop, alarms, guardrails, gate, tyres or wheels, hydraulic systems, leaks, batteries or fuel system, steering, brakes, emergency lowering, structural components, decals and safety devices.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '22. Thorough Examination & Maintenance',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Maintain required examination, inspection, servicing and repair records. Defects affecting safe operation shall be reported, the machine removed from service where necessary, and repairs completed by competent personnel before return to use.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '23. Operator Competency',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Only trained, authorised and competent operators shall operate the MEWP. Competency shall cover the machine type, controls, hazards, manufacturer instructions, pre-use inspection, emergency procedures and site-specific risks.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '24. Supervisor & HSE Responsibilities',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Supervisors shall verify suitable equipment, competent operators, RAMS/JSA, site controls, exclusion zones and emergency arrangements. HSE personnel shall monitor compliance, inspect controls and ensure unsafe conditions are escalated.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '25. Communication & Spotter',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Establish reliable communication between operator, ground personnel, spotter and supervisor where required. Agree signals before work starts. A spotter shall not be used as a substitute for proper visibility or engineered controls.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '26. Charging, Fuel & Energy Safety',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Control battery charging, refuelling and energy sources in designated areas. Prevent ignition sources, spills, incompatible charging arrangements and exposure to hazardous energy. Follow manufacturer requirements for batteries and fuel systems.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '27. Safe Operating Procedure',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Plan the route, inspect the machine, establish the work zone, position on suitable ground, complete functional checks, elevate smoothly, maintain clearances, perform the task within capacity and lower the platform safely before relocation.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '28. Parking, Shutdown & Transport',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Lower the platform fully where required, park on a suitable surface, isolate or secure the machine according to manufacturer instructions and prevent unauthorised use. Apply transport and tie-down requirements when moving the machine between locations.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '29. Rescue & Emergency',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Provide a practical rescue plan before elevated work starts. Operators and ground personnel shall know emergency lowering and communication procedures. Rescue arrangements shall consider operator incapacity, entrapment, power failure, machine failure and medical emergencies.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '30. PPE',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Provide PPE based on the risk assessment, including safety footwear, hard hat, high-visibility clothing, eye protection, hearing protection, gloves and fall-protection equipment where applicable. PPE shall complement, not replace, engineering controls.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '31. Stop-Work Conditions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Stop operation for loss of stability, defective safety devices, failed inspection, excessive wind, lightning, unsafe ground, uncontrolled electrical exposure, overloaded platform, loss of communication, collision risk, unauthorised operation or any condition outside manufacturer limits.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '32. Unsafe Practices → Corrective Actions',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Correct unsafe acts such as climbing guardrails, overloading, moving with unsafe elevation, bypassing alarms, using improvised access, operating near uncontrolled power lines or working outside weather limits. Stop, isolate the hazard, correct the control and reauthorise work.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '33. Toolbox Talk',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Brief workers on machine type, task limits, ground conditions, exclusion zones, overhead hazards, fall protection, communication, traffic interface, weather, emergency lowering, rescue arrangements and stop-work authority before the activity.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '34. Field Checklist',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Verify machine identification; valid inspection/examination status; operator competency; pre-use inspection; emergency controls; guardrails and gate; ground condition; capacity; overhead services; exclusion zone; traffic control; weather; PPE; communication; rescue plan; housekeeping; defect reporting.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '35. Quick Reference',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'FIELD RULE: SELECT the right MEWP. INSPECT before use. CHECK ground and overhead hazards. STAY within the platform. RESPECT capacity and manufacturer limits. CONTROL people and vehicles. MONITOR weather. KNOW the rescue plan. STOP when conditions become unsafe.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '36. UAE / Abu Dhabi / Dubai Applicability',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'For Abu Dhabi, apply the current ADOSH-SF requirements and relevant sector or authority requirements. MEWP controls are specifically addressed within ADOSH-SF CoP 36.0 Plant and Equipment, alongside related requirements for working at height, overhead services, electrical safety, traffic and lifting where applicable. Dubai and other jurisdictions shall be checked against their own current requirements.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '37. Related CoPs & Cross-References',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Relevant Abu Dhabi references include CoP 36.0 Plant and Equipment; CoP 23.0 Working at Heights; CoP 39.0 Overhead and Underground Services; CoP 15.0 Electrical Safety; CoP 33.0 Working On or Adjacent to a Road; CoP 44.0 Traffic Management and Logistics; and other applicable CoPs based on the task.',
      ),
    ],
  ),
  MewpGoldSection(
    title: '38. Official Regulatory References',
    points: [
      MewpGoldPoint(
        title: 'Key Controls',
        content: 'Primary official reference: Abu Dhabi Public Health Centre (ADPHC), ADOSH-SF CoP 36.0 Plant and Equipment, Version 4.1, effective 27 February 2026. The official CoP states that plant includes equipment that lifts people, such as MEWPs, and addresses risk assessment, controls, maintenance, inspection, records and responsibilities. Verify the current ADPHC registry and applicable authority requirements before relying on legal or numerical requirements.',
      ),
    ],
  ),
];
