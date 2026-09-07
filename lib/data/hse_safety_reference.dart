import '../models/reference_topic.dart';

/// ============================================================
/// HSE SAFETY REFERENCE
///
/// Practical construction HSE topics for UAE workplaces.
/// These topics are general professional HSE references and
/// are kept separate from UAE, Abu Dhabi and Dubai standards.
/// ============================================================

const List<ReferenceTopic> hseSafetyReference = [
  // ============================================================
  // 1. EXCAVATION
  // ============================================================

  ReferenceTopic(
    id: 'excavation_safety',
    title: 'Excavation Safety',
    shortTitle: 'Excavation',
    category: 'Construction Safety',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety requirements and good practices for excavation, trenching, soil stability, access, protective systems and underground services.',
  ),

  // ============================================================
  // 2. SCAFFOLDING
  // ============================================================

  ReferenceTopic(
    id: 'scaffolding_safety',
    title: 'Scaffolding Safety',
    shortTitle: 'Scaffolding',
    category: 'Work at Height',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe erection, inspection, modification, use and dismantling of scaffolding systems, including access, stability and fall prevention.',
  ),

  // ============================================================
  // 3. WORKING AT HEIGHT
  // ============================================================

  ReferenceTopic(
    id: 'working_at_height',
    title: 'Working at Height',
    shortTitle: 'Working at Height',
    category: 'Work at Height',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe work practices for activities where workers may fall from an elevated position, including access, fall protection and rescue arrangements.',
  ),

  // ============================================================
  // 4. POWER TOOLS
  // ============================================================

  ReferenceTopic(
    id: 'power_tools_safety',
    title: 'Power Tools Safety',
    shortTitle: 'Power Tools',
    category: 'Tools & Equipment',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe selection, inspection, operation and maintenance of portable power tools to control electrical, mechanical, cutting and flying-particle hazards.',
  ),

  // ============================================================
  // 5. FORMWORK
  // ============================================================

  ReferenceTopic(
    id: 'formwork_safety',
    title: 'Formwork Safety',
    shortTitle: 'Formwork',
    category: 'Temporary Works',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety practices for formwork installation, support, inspection, concrete pouring, stripping and dismantling.',
  ),

  // ============================================================
  // 6. PERMIT TO WORK
  // ============================================================

  ReferenceTopic(
    id: 'permit_to_work',
    title: 'Permit to Work',
    shortTitle: 'PTW',
    category: 'Permit to Work',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'A controlled system for authorising high-risk work and confirming that hazards, isolations, precautions and responsibilities have been addressed before work starts.',
  ),

  // ============================================================
  // 7. HOT & HUMID CLIMATE
  // ============================================================

  ReferenceTopic(
    id: 'hot_humid_climate',
    title: 'Working in Hot & Humid Climate',
    shortTitle: 'Heat Stress',
    category: 'Occupational Health',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Practical controls for protecting workers from heat stress, dehydration, fatigue and heat-related illness when working in hot and humid conditions.',
  ),

  // ============================================================
  // 8. CONFINED SPACE
  // ============================================================

  ReferenceTopic(
    id: 'confined_space_safety',
    title: 'Confined Space Safety',
    shortTitle: 'Confined Space',
    category: 'High Risk Work',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety controls for entry into confined spaces, including hazard assessment, atmospheric testing, ventilation, isolation, communication and rescue.',
  ),

  // ============================================================
  // 9. WORKING NEAR LIVE ROADS
  // ============================================================

  ReferenceTopic(
    id: 'working_near_live_roads',
    title: 'Working Near Live Roads',
    shortTitle: 'Live Road Safety',
    category: 'Traffic Management',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety measures for construction and maintenance activities near live traffic, including traffic control, barriers, signs, lighting and worker visibility.',
  ),

  // ============================================================
  // 10. CONCRETING
  // ============================================================

  ReferenceTopic(
    id: 'concreting_safety',
    title: 'Concreting Safety',
    shortTitle: 'Concreting',
    category: 'Construction Safety',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe practices for concrete delivery, pumping, placing, vibrating, finishing and related activities, including control of plant and material hazards.',
  ),

  // ============================================================
  // 11. BARRICADING OF HAZARDS
  // ============================================================

  ReferenceTopic(
    id: 'barricading_of_hazards',
    title: 'Barricading of Hazards',
    shortTitle: 'Barricading',
    category: 'Hazard Control',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Requirements and good practices for isolating hazardous areas using suitable barricades, warning signs and controlled access arrangements.',
  ),

  // ============================================================
  // 12. WORKER WELFARE
  // ============================================================

  ReferenceTopic(
    id: 'worker_welfare',
    title: 'Worker Welfare',
    shortTitle: 'Worker Welfare',
    category: 'Occupational Health',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Essential workplace welfare provisions including drinking water, sanitation, rest areas, hygiene, accommodation-related considerations and worker wellbeing.',
  ),

  // ============================================================
  // 13. MEWP
  // ============================================================

  ReferenceTopic(
    id: 'mewp_safety',
    title: 'Mobile Elevated Work Platform (MEWP)',
    shortTitle: 'MEWP',
    category: 'Work at Height',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe selection, inspection, positioning and operation of mobile elevated work platforms, including stability, fall protection and emergency lowering.',
  ),

  // ============================================================
  // 14. ELECTRICITY & ELECTRICAL TOOLS
  // ============================================================

  ReferenceTopic(
    id: 'site_electricity_electrical_tools',
    title: 'Electricity on Site & Electrical Tools',
    shortTitle: 'Electrical Safety',
    category: 'Electrical Safety',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Controls for temporary site electrical systems, distribution boards, cables, portable electrical tools, grounding, protection devices and inspections.',
  ),

  // ============================================================
  // 15. TEMPORARY WORKS
  // ============================================================

  ReferenceTopic(
    id: 'temporary_works',
    title: 'Temporary Works',
    shortTitle: 'Temporary Works',
    category: 'Temporary Works',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety management of temporary structures and systems such as formwork, falsework, temporary supports, access systems and other temporary installations.',
  ),

  // ============================================================
  // 16. MANUAL HANDLING
  // ============================================================

  ReferenceTopic(
    id: 'manual_handling',
    title: 'Manual Handling',
    shortTitle: 'Manual Handling',
    category: 'Ergonomics',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safe manual handling practices covering lifting, carrying, pushing, pulling, team handling, load assessment and prevention of musculoskeletal injuries.',
  ),

  // ============================================================
  // 17. HOT WORKS
  // ============================================================

  ReferenceTopic(
    id: 'hot_works_safety',
    title: 'Hot Works Safety',
    shortTitle: 'Hot Works',
    category: 'Fire Safety',
    authority: 'HSE Safety Reference',
    jurisdiction: 'General HSE',
    description:
        'Safety controls for welding, cutting, grinding, brazing and other hot work activities, including fire prevention, gas cylinder safety and permit requirements.',
  ),
];
