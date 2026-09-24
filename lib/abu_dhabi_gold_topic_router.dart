import 'package:flutter/material.dart';

import 'data/abu_dhabi_specialist_hse_complete_gold.dart';
import 'data/abu_dhabi_5AJ_part1_interfaces_specialist_plant_gold.dart';
import 'data/abu_dhabi_5AJ_part2_gap_duplicate_cop36_gold.dart';
import 'data/abu_dhabi_5AB_to_5AE_plant_haulage_compaction_gold.dart';
import 'data/abu_dhabi_5AF_to_5AI_paver_trencher_compressor_generator_gold.dart';
import 'data/abu_dhabi_5S_to_5V_mobile_material_handling_gold.dart';
import 'data/abu_dhabi_5W_to_5Z_earthmoving_gold.dart';
import 'data/abu_dhabi_forklift_powered_lift_trucks_gold.dart';
import 'data/abu_dhabi_mewp_gold.dart';
import 'data/abu_dhabi_crane_lifting_book_gold.dart';
import 'models/reference_topic.dart';



class WorkingAtHeightGoldPoint {
  final String clause;
  final String title;
  final String meaning;
  final String hazards;
  final String controls;
  final String fieldCheck;
  final String commonMistake;
  final String action;
  final String records;

  const WorkingAtHeightGoldPoint({
    required this.clause,
    required this.title,
    required this.meaning,
    required this.hazards,
    required this.controls,
    required this.fieldCheck,
    required this.commonMistake,
    required this.action,
    required this.records,
  });
}

class WorkingAtHeightGoldSection {
  final String number;
  final String title;
  final String introduction;
  final WorkingAtHeightGoldPoint point;

  const WorkingAtHeightGoldSection({
    required this.number,
    required this.title,
    required this.introduction,
    required this.point,
  });
}

const List<WorkingAtHeightGoldSection> workingAtHeightGoldStandardSections = [
  WorkingAtHeightGoldSection(
    number: '01',
    title: 'Definition & Purpose',
    introduction: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 01',
      title: 'Definition & Purpose',
      meaning: 'Working at height means work where a person could fall from one level to another and requires planned fall prevention and protection.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '02',
    title: 'Scope & Applications',
    introduction: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 02',
      title: 'Scope & Applications',
      meaning: 'Cover construction, maintenance, inspection, access, roof work, platforms, scaffolds, ladders, MEWPs and other applicable elevated work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '03',
    title: 'Types of Work at Height',
    introduction: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 03',
      title: 'Types of Work at Height',
      meaning: 'Include roofs, edges, openings, scaffolds, ladders, MEWPs, temporary platforms, formwork and other elevated work situations.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '04',
    title: 'Components / Equipment',
    introduction: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 04',
      title: 'Components / Equipment',
      meaning: 'Cover platforms, guardrails, toe boards, covers, harnesses, lanyards, lifelines, connectors and approved anchor systems.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '05',
    title: 'Planning & Design',
    introduction: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 05',
      title: 'Planning & Design',
      meaning: 'Plan the work before starting; select the safest access method and account for rescue, dropped objects, environment and interfaces.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '06',
    title: 'Site Assessment',
    introduction: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 06',
      title: 'Site Assessment',
      meaning: 'Assess edges, openings, fragile surfaces, access, ground conditions, electrical services, traffic, weather and people below.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '07',
    title: 'Hierarchy of Controls',
    introduction: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 07',
      title: 'Hierarchy of Controls',
      meaning: 'Prefer elimination and avoidance, then collective fall prevention, then engineered fall arrest and finally administrative controls/PPE.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '08',
    title: 'Fall Prevention',
    introduction: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 08',
      title: 'Fall Prevention',
      meaning: 'Prevent the fall with safe platforms, guardrails, edge protection, covers and suitable access rather than relying first on fall arrest.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '09',
    title: 'Fall Arrest',
    introduction: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 09',
      title: 'Fall Arrest',
      meaning: 'Where prevention cannot fully control the risk, use a compatible personal fall-arrest system with suitable anchor, clearance and rescue arrangements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '10',
    title: 'Guardrails & Edge Protection',
    introduction: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 10',
      title: 'Guardrails & Edge Protection',
      meaning: 'Protect exposed edges and access openings with suitable collective protection; do not remove protection without a controlled alternative.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '11',
    title: 'Floor / Shaft / Opening Protection',
    introduction: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 11',
      title: 'Floor / Shaft / Opening Protection',
      meaning: 'Securely cover or guard floor openings, shafts and other voids; identify and protect temporary openings.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '12',
    title: 'Roof Work',
    introduction: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 12',
      title: 'Roof Work',
      meaning: 'Assess roof condition, access, edges, fragile areas, skylights, weather and rescue before roof work.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '13',
    title: 'Fragile Surfaces',
    introduction: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 13',
      title: 'Fragile Surfaces',
      meaning: 'Treat fragile roofs, sheets, skylights and weak surfaces as fall hazards until their strength is verified and suitable controls are installed.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '14',
    title: 'Ladders',
    introduction: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 14',
      title: 'Ladders',
      meaning: 'Use ladders only for appropriate tasks and durations; select, inspect, secure and position them according to the applicable requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '15',
    title: 'Scaffolds',
    introduction: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 15',
      title: 'Scaffolds',
      meaning: 'Use inspected and correctly configured scaffolds with complete platforms, edge protection, safe access and controlled loading.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '16',
    title: 'MEWP / Aerial Platforms',
    introduction: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 16',
      title: 'MEWP / Aerial Platforms',
      meaning: 'Use the correct MEWP, trained operator, pre-use inspection, ground assessment, exclusion zone and manufacturer requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '17',
    title: 'Temporary Platforms',
    introduction: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 17',
      title: 'Temporary Platforms',
      meaning: 'Ensure temporary working platforms are designed, stable, complete and suitable for the intended load and task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '18',
    title: 'Harnesses & Lanyards',
    introduction: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 18',
      title: 'Harnesses & Lanyards',
      meaning: 'Select compatible equipment, inspect before use, connect correctly and ensure the system is suitable for the planned task.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '19',
    title: 'Anchor Points & Lifelines',
    introduction: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 19',
      title: 'Anchor Points & Lifelines',
      meaning: 'Use approved anchors/lifelines suitable for the system; never connect to an unverified point.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '20',
    title: 'Fall Clearance & Swing Fall',
    introduction: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 20',
      title: 'Fall Clearance & Swing Fall',
      meaning: 'Confirm sufficient clearance below the worker and control swing-fall hazards before using a fall-arrest system.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '21',
    title: 'Dropped Objects',
    introduction: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 21',
      title: 'Dropped Objects',
      meaning: 'Control tools, materials and components at height using secure storage, tethering where appropriate, toe boards and exclusion zones.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '22',
    title: 'Weather / Wind / Heat',
    introduction: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 22',
      title: 'Weather / Wind / Heat',
      meaning: 'Reassess elevated work for wind, rain, heat, poor visibility, wet surfaces and other environmental conditions.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '23',
    title: 'Electrical / Overhead Services',
    introduction: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 23',
      title: 'Electrical / Overhead Services',
      meaning: 'Identify overhead electrical and other services before access or equipment positioning and apply the required isolation, clearance and authority controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '24',
    title: 'People / Traffic Interface',
    introduction: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 24',
      title: 'People / Traffic Interface',
      meaning: 'Protect people, vehicles and public areas below or adjacent to elevated work using barriers, exclusion zones and controlled access.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '25',
    title: 'RAMS / JSA / Risk Assessment',
    introduction: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 25',
      title: 'RAMS / JSA / Risk Assessment',
      meaning: 'Make the assessment task-specific and include access, fall controls, dropped objects, environment, equipment, interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '26',
    title: 'PTW / Authorization',
    introduction: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 26',
      title: 'PTW / Authorization',
      meaning: 'Use required permits, authorisations and coordination controls for high-risk or interfacing activities.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '27',
    title: 'Safe Work Procedure',
    introduction: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 27',
      title: 'Safe Work Procedure',
      meaning: 'Sequence the work: plan → assess → establish protection → inspect equipment → brief workers → perform task → monitor → close safely.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '28',
    title: 'Inspection & Examination',
    introduction: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 28',
      title: 'Inspection & Examination',
      meaning: 'Inspect work-at-height systems before use and at required intervals/events; remove defective equipment from service.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '29',
    title: 'Competency & Responsibilities',
    introduction: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 29',
      title: 'Competency & Responsibilities',
      meaning: 'Define competent workers, supervisors, HSE personnel, inspectors, operators and rescue roles; verify training and authorization.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '30',
    title: 'PPE',
    introduction: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 30',
      title: 'PPE',
      meaning: 'Use task-appropriate helmet, footwear, gloves, eye protection, high visibility and fall-protection equipment where required.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '31',
    title: 'Emergency / Rescue',
    introduction: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 31',
      title: 'Emergency / Rescue',
      meaning: 'Plan rescue before work. Control the scene, communicate, recover a suspended worker safely, provide first aid and arrange medical evaluation.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '32',
    title: 'Stop-Work Conditions',
    introduction: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 32',
      title: 'Stop-Work Conditions',
      meaning: 'Stop for missing edge protection, unsafe openings, defective fall equipment, unknown anchors, inadequate clearance, unsafe access, severe weather or absent rescue controls.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '33',
    title: 'Unsafe Practices → Corrective Actions',
    introduction: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 33',
      title: 'Unsafe Practices → Corrective Actions',
      meaning: 'Record the actual unsafe condition, immediate control, root cause, responsible person and verified close-out.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '34',
    title: 'Toolbox Talk',
    introduction: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 34',
      title: 'Toolbox Talk',
      meaning: 'Brief workers on task hazards, access, edge protection, fall-arrest limits, dropped objects, weather, electrical interfaces and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '35',
    title: 'Field Checklist',
    introduction: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 35',
      title: 'Field Checklist',
      meaning: 'Check planning, access, platform, edge protection, openings, equipment, anchors, clearance, dropped objects, weather, exclusion zones and rescue.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '36',
    title: 'Quick Reference',
    introduction: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 36',
      title: 'Quick Reference',
      meaning: 'Use: ELIMINATE → PREVENT → PROTECT → INSPECT → ACCESS → CONTROL OBJECTS → CHECK CLEARANCE → RESCUE READY.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '37',
    title: 'UAE / Abu Dhabi / Dubai Applicability',
    introduction: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 37',
      title: 'UAE / Abu Dhabi / Dubai Applicability',
      meaning: 'Keep Abu Dhabi requirements separate from Dubai and other jurisdictions; verify the applicable authority and current document version.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
  WorkingAtHeightGoldSection(
    number: '38',
    title: 'Official Regulatory References',
    introduction: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
    point: WorkingAtHeightGoldPoint(
      clause: 'Step 38',
      title: 'Official Regulatory References',
      meaning: 'Primary Abu Dhabi baseline: ADOSH-SF CoP 23.0 — Working at Heights. Cross-reference applicable scaffold, ladder, MEWP, electrical and other HSE requirements.',
      hazards: 'Identify falls, falling objects, equipment failure, unsafe access, environmental hazards and interface risks relevant to this section.',
      controls: 'Apply the hierarchy of controls, use suitable engineered protection, competent personnel, inspection, supervision and task-specific procedures.',
      fieldCheck: 'Verify the physical control in the field before allowing the work to proceed.',
      commonMistake: 'Relying on generic instructions or PPE while a higher-level physical control is missing.',
      action: 'Stop or control the task, correct the failed critical control and verify it before restart.',
      records: 'RAMS/JSA, inspection record, competency evidence, permit/authorization and corrective-action record where applicable.',
    ),
  ),
];


/// Step 5AK-A: central Gold Standard router.
///
/// The old Abu Dhabi registry remains the index. This router decides whether
/// a selected topic has a dedicated Gold Standard data source. If it does,
/// the app opens that source instead of the older generic CoP content.
Widget? buildAbuDhabiGoldTopicPage(ReferenceTopic topic) {
  switch (topic.id) {
    case 'ad_cop_29_0':
      return null; // Excavation is handled by AbuDhabiHseTopicPage.
    case 'ad_cop_23_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: workingAtHeightGoldStandardSections,
        regulatory: 'ADPHC CoP 23.0 — Working at Heights — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_26_0':
      return ScaffoldingGoldBookPage(
        topic: topic,
        sections: scaffoldingGoldStandardSections,
        regulatory: 'ADPHC CoP 26.0 — Scaffolding — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_27_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: confinedSpaceGoldStandardSections,
        regulatory: 'ADPHC CoP 27.0 — Confined Spaces — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_21_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: permitToWorkGoldStandardSections,
        regulatory: 'ADPHC CoP 21.0 — Permit to Work Systems — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_11_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: safetyInHeatGoldStandardSections,
        regulatory: 'ADPHC CoP 11.0 — Safety in the Heat — V4.0; effective 15 July 2024.',
      );
    case 'ad_cop_35_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: portablePowerToolsGoldStandardSections,
        regulatory: 'ADPHC CoP 35.0 — Portable Power Tools — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_40_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: formworkGoldStandardSections,
        regulatory: 'ADPHC CoP 40.0 — False Work (Formwork) — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_51_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: forkliftPoweredLiftTruckGoldSections,
        regulatory: 'ADPHC CoP 51.0 — Powered Lift Trucks — V4.1; effective 27 February 2026.',
      );
    case 'ad_cop_14_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5P — Manual Handling')
            .toList(),
        regulatory: 'ADPHC CoP 14.0 — Manual Handling and Ergonomics.',
      );
    case 'ad_cop_15_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) =>
                section.category == '5N — Electricity on Site & Electrical Tools')
            .toList(),
        regulatory: 'ADPHC CoP 15.0 — Electrical Safety.',
      );
    case 'ad_cop_28_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5Q — Hot Work')
            .toList(),
        regulatory: 'ADPHC CoP 28.0 — Hot Work.',
      );
    case 'ad_cop_34_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: craneLiftingGoldStandardSections,
        regulatory:
            'ADPHC CoP 34.0 — Safe Use of Lifting Equipment and Lifting Accessories.',
      );
    case 'ad_cop_43_0':
      return AbuDhabiGoldBookPage(
        topic: topic,
        sections: abuDhabiFiveNQGoldStandardSections
            .where((section) => section.category == '5O — Temporary Works')
            .toList(),
        regulatory: 'ADPHC CoP 43.0 — Temporary Structures.',
      );
    case 'ad_cop_36_0':
      return AbuDhabiPlantEquipmentGoldIndexPage(topic: topic);
    default:
      return null;
  }
}


/// Production Gold Standard implementation for CoP 26.0 Scaffolding.
///
/// Navigation:
/// Subject introduction -> 38 chapter points -> point detail ->
/// tappable sub-points -> sub-point detail.
///
/// The existing consolidated Gold data remains the source of the content.
/// The enhancement layer adds field examples, measurements, checklists,
/// stop-work points, emergency prompts and visual guidance without creating
/// a new scaffolding data file.
class ScaffoldingGoldBookPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<ScaffoldingGoldSection> sections;
  final String regulatory;

  const ScaffoldingGoldBookPage({
    super.key,
    required this.topic,
    required this.sections,
    required this.regulatory,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Scaffolding'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          _introCard(),
          const SizedBox(height: 14),
          const Text(
            'Complete Field Handbook',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${sections.length} structured chapters • Tap any chapter to open the detailed field page.',
            style: const TextStyle(fontSize: 14.5, height: 1.45),
          ),
          const SizedBox(height: 12),
          ...sections.asMap().entries.map(
            (entry) => _chapterCard(context, entry.key + 1, entry.value),
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ABU DHABI HSE • GOLD STANDARD',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              topic.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'Scaffolding is a temporary access and working-platform system. '
              'Safe use depends on suitable selection, competent erection and '
              'alteration, inspection, stability, safe access, fall protection, '
              'load control and effective management of interfaces and changes.',
              style: TextStyle(fontSize: 15, height: 1.55),
            ),
            const SizedBox(height: 14),
            const Text(
              'Main Hazards',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 7),
            ...const [
              'Falls from height',
              'Scaffold instability or collapse',
              'Falling objects and materials',
              'Unsafe access and egress',
              'Overloading',
              'Unsafe erection or alteration',
              'Electrical interface',
              'Weather and wind exposure',
              'Poor foundation or ground condition',
            ].map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              regulatory,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.45,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chapterCard(
    BuildContext context,
    int index,
    ScaffoldingGoldSection section,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text(
            '$index',
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: darkGreen,
          ),
        ),
        subtitle: Text(
          section.introduction,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ScaffoldingChapterDetailPage(
              chapterNumber: index,
              section: section,
            ),
          ),
        ),
      ),
    );
  }
}

class ScaffoldingChapterDetailPage extends StatelessWidget {
  final int chapterNumber;
  final ScaffoldingGoldSection section;

  const ScaffoldingChapterDetailPage({
    super.key,
    required this.chapterNumber,
    required this.section,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final p = section.point;
    final enhancement = scaffoldingGoldEnhancements[section.title];

    final subPoints = <_ScaffoldingSubPoint>[
      _ScaffoldingSubPoint('Meaning / What this means', p.meaning),
      _ScaffoldingSubPoint('Hazards / Consequences', p.hazards),
      _ScaffoldingSubPoint('Control Measures', p.controls),
      _ScaffoldingSubPoint('HSE Officer Field Check', p.fieldCheck),
      _ScaffoldingSubPoint('Common Mistake', p.commonMistake),
      _ScaffoldingSubPoint('Corrective Action', p.action),
      _ScaffoldingSubPoint('Records / Evidence', p.records),
    ].where((item) => item.detail.trim().isNotEmpty).toList();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          section.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHAPTER $chapterNumber • ${section.number}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    section.introduction,
                    style: const TextStyle(fontSize: 15, height: 1.55),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Clause: ${p.clause}',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Detailed Field Controls',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap each item to open its full explanation.',
            style: TextStyle(fontSize: 14.5),
          ),
          const SizedBox(height: 12),
          ...subPoints.asMap().entries.map(
            (entry) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                ),
                title: Text(
                  entry.value.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
                subtitle: Text(
                  entry.value.detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                  color: darkGreen,
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ScaffoldingSubPointDetailPage(
                      chapterTitle: section.title,
                      point: entry.value,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (enhancement != null) ...[
            const SizedBox(height: 10),
            const Text(
              'Gold Standard Field Layer',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 7),
            _enhancementCard('Regulatory Basis', enhancement.regulatory, Icons.gavel),
            _enhancementCard('Measurements / Limits', enhancement.measurements, Icons.straighten),
            _enhancementCard('Field Example', enhancement.fieldExample, Icons.construction),
            _visualCard(enhancement.visualGuide),
            _enhancementCard('Field Checklist', enhancement.checklist, Icons.fact_check_outlined),
            _enhancementCard('Stop-Work Conditions', enhancement.stopWork, Icons.stop_circle_outlined),
            _enhancementCard('Emergency / Rescue', enhancement.emergency, Icons.emergency_outlined),
            _enhancementCard('Interview Question', enhancement.interview, Icons.school_outlined),
            _enhancementCard('Official / Control Reference', enhancement.reference, Icons.menu_book_outlined),
          ],
        ],
      ),
    );
  }

  Widget _enhancementCard(String title, String detail, IconData icon) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: green),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    detail,
                    style: const TextStyle(fontSize: 14.5, height: 1.55),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _visualCard(String guide) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.account_tree_outlined, color: green),
                SizedBox(width: 11),
                Text(
                  'Visual Field Guide',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: green.withValues(alpha: 0.07),
                border: Border.all(color: green.withValues(alpha: 0.18)),
              ),
              child: Text(
                guide,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.55,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 9),
            const Text(
              'SafeNexus visual principle: use a simple diagram/illustration whenever a measurement, sequence, component relationship or safe/unsafe condition is easier to understand visually.',
              style: TextStyle(fontSize: 12.8, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaffoldingSubPoint {
  final String title;
  final String detail;

  const _ScaffoldingSubPoint(this.title, this.detail);
}

class ScaffoldingSubPointDetailPage extends StatelessWidget {
  final String chapterTitle;
  final _ScaffoldingSubPoint point;

  const ScaffoldingSubPointDetailPage({
    super.key,
    required this.chapterTitle,
    required this.point,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          point.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SCAFFOLDING • FIELD DETAIL',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: green,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    chapterTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    point.title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    point.detail,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.verified_user_outlined, color: green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Field use: apply the current approved CoP, risk assessment, method statement, competent-person requirements, manufacturer instructions and project controls applicable to the task.',
                      style: TextStyle(fontSize: 14.5, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _GoldChapter {
  final String title;
  final String subtitle;
  final List<dynamic> sections;

  const _GoldChapter({required this.title, required this.subtitle, required this.sections});
}

class AbuDhabiGoldBookPage extends StatelessWidget {
  final ReferenceTopic topic;
  final List<dynamic> sections;
  final String regulatory;

  const AbuDhabiGoldBookPage({
    super.key,
    required this.topic,
    required this.sections,
    required this.regulatory,
  });

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(topic.shortTitle, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                const SizedBox(height: 9),
                Text('Gold Standard Field Handbook', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                const SizedBox(height: 10),
                Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                const SizedBox(height: 12),
                Text(regulatory, style: const TextStyle(fontSize: 14.2, height: 1.45, fontWeight: FontWeight.w800)),
              ]),
            ),
          ),
          const SizedBox(height: 14),
          ...sections.asMap().entries.map((e) => _sectionCard(context, e.key + 1, e.value)),
        ],
      ),
    );
  }

  Widget _sectionCard(BuildContext context, int number, dynamic section) {
    final title = _sectionTitle(section);
    final preview = _sectionPreview(section);
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: green.withValues(alpha: 0.12),
          child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
        subtitle: preview.isEmpty ? null : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.chevron_right, color: darkGreen),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldSectionPage(title: title, section: section))),
      ),
    );
  }
}

class AbuDhabiGoldSectionPage extends StatelessWidget {
  final String title;
  final dynamic section;

  const AbuDhabiGoldSectionPage({super.key, required this.title, required this.section});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final points = _sectionPoints(section);
    final sectionIntro = _readString(section, 'introduction');
    final category = _readString(section, 'category');
    final number = _readString(section, 'number');

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (number.isNotEmpty)
                    Text(number, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: green)),
                  if (category.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(category, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: darkGreen)),
                  ],
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  if (sectionIntro.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(sectionIntro, style: const TextStyle(fontSize: 15, height: 1.5)),
                  ],
                  const SizedBox(height: 12),
                  Text(
                    '${points.length} detailed point${points.length == 1 ? '' : 's'} • Tap any point to open the full field explanation.',
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...points.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final point = entry.value;
            final pointTitle = _readString(point, 'title').isEmpty
                ? 'Field Point $index'
                : _readString(point, 'title');
            final preview = _pointPreview(point);

            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: green.withValues(alpha: 0.12),
                  child: Text('$index', style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                ),
                title: Text(pointTitle, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
                subtitle: preview.isEmpty
                    ? const Text('Open detailed field explanation')
                    : Text(preview, maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: const Icon(Icons.chevron_right, color: darkGreen),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AbuDhabiGoldPointDetailPage(
                      title: pointTitle,
                      point: point,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class AbuDhabiGoldPointDetailPage extends StatelessWidget {
  final String title;
  final dynamic point;

  const AbuDhabiGoldPointDetailPage({super.key, required this.title, required this.point});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  @override
  Widget build(BuildContext context) {
    final fields = _pointFields(point);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('GOLD STANDARD FIELD EXPLANATION', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 7),
                  Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text(
                    'Use this page as the field-level explanation. Check the applicable controlled CoP, approved method statement, risk assessment, manufacturer instructions and project requirements before execution.',
                    style: TextStyle(fontSize: 14.5, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...fields.map((field) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.shield_outlined, color: green),
                          const SizedBox(width: 10),
                          Expanded(child: Text(field.$1, style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: darkGreen))),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Text(field.$2, style: const TextStyle(fontSize: 15, height: 1.55)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

String _readString(dynamic object, String field) {
  try {
    final value = switch (field) {
      'title' => object.title,
      'detail' => object.detail,
      'content' => object.content,
      'meaning' => object.meaning,
      'hazards' => object.hazards,
      'controls' => object.controls,
      'fieldCheck' => object.fieldCheck,
      'commonMistake' => object.commonMistake,
      'action' => object.action,
      'records' => object.records,
      'fieldProcedure' => object.fieldProcedure,
      'roles' => object.roles,
      'preWork' => object.preWork,
      'duringWork' => object.duringWork,
      'monitoring' => object.monitoring,
      'emergency' => object.emergency,
      'stopWork' => object.stopWork,
      'checklist' => object.checklist,
      'interview' => object.interview,
      'number' => object.number,
      'category' => object.category,
      'introduction' => object.introduction,
      _ => null,
    };
    if (value is String) return value.trim();
  } catch (_) {}
  return '';
}

String _sectionTitle(dynamic section) {
  for (final field in const ['title', 'name', 'heading', 'category', 'number']) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  return 'Field Safety Section';
}

String _sectionPreview(dynamic section) {
  for (final field in const [
    'introduction',
    'detail',
    'content',
    'meaning',
    'description',
  ]) {
    final value = _readString(section, field);
    if (value.isNotEmpty) return value;
  }
  final points = _sectionPoints(section);
  if (points.isNotEmpty) return _pointPreview(points.first);
  return '';
}

List<dynamic> _sectionPoints(dynamic section) {
  try {
    final list = section.points as List;
    return list.toList();
  } catch (_) {}
  try {
    return [section.point];
  } catch (_) {}
  return const [];
}

String _pointPreview(dynamic point) {
  for (final field in const ['detail', 'content', 'meaning', 'hazards', 'controls']) {
    final value = _readString(point, field);
    if (value.isNotEmpty) return value;
  }
  return '';
}

List<(String, String)> _pointFields(dynamic point) {
  final result = <(String, String)>[];

  void add(String label, String field) {
    final value = _readString(point, field);
    if (value.isNotEmpty) result.add((label, value));
  }

  add('Meaning / Detail', 'detail');
  add('Content', 'content');
  add('Meaning', 'meaning');
  add('Hazards / Consequences', 'hazards');
  add('Control Measures', 'controls');
  add('Field HSE Check', 'fieldCheck');
  add('Common Mistake', 'commonMistake');
  add('Corrective Action', 'action');
  add('Records / Evidence', 'records');
  add('Field Procedure', 'fieldProcedure');
  add('Roles & Responsibilities', 'roles');
  add('Before Starting', 'preWork');
  add('During Work', 'duringWork');
  add('Monitoring / Verification', 'monitoring');
  add('Emergency / Rescue', 'emergency');
  add('Stop-Work Condition', 'stopWork');
  add('HSE Officer Checklist', 'checklist');
  add('Interview Question', 'interview');

  // Some Gold sources expose a list of strings inside a point.
  try {
    final list = point.points as List;
    for (final item in list) {
      final text = item.toString().trim();
      if (text.isNotEmpty) result.add(('Field Point', text));
    }
  } catch (_) {}

  return result;
}

class AbuDhabiPlantEquipmentGoldIndexPage extends StatelessWidget {
  final ReferenceTopic topic;
  const AbuDhabiPlantEquipmentGoldIndexPage({super.key, required this.topic});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF6F8F7);

  List<_GoldChapter> get chapters => [
    _GoldChapter(title: '5S–5V — Mobile / Material Handling', subtitle: 'Gold equipment chapters', sections: abuDhabi5STo5VTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5W–5Z — Earthmoving', subtitle: 'Gold equipment chapters', sections: abuDhabi5WTo5ZTopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AB–5AE — Haulage / Compaction', subtitle: 'Gold equipment chapters', sections: abuDhabi5ABTo5AETopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: '5AF–5AI — Paver / Trencher / Compressor / Generator', subtitle: 'Gold equipment chapters', sections: abuDhabi5AFTo5AITopics.expand((t) => t.sections).toList()),
    _GoldChapter(title: 'Crane & Lifting', subtitle: 'Dedicated Gold Standard book', sections: craneLiftingGoldStandardSections),
    _GoldChapter(title: 'MEWP', subtitle: 'Dedicated Gold Standard book', sections: mewpGoldStandardSections),
    _GoldChapter(title: '5AJ Part 1 — Interfaces / Specialist Plant', subtitle: 'Master audit and field interfaces', sections: abuDhabiPlantInterfaceGoldSections),
    _GoldChapter(title: '5AJ Part 2 — Gaps / Duplicate / CoP 36.0', subtitle: 'Master audit and closure', sections: abuDhabiPlantAuditGoldSections),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: const Text('Plant & Equipment — Gold Standard'), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 34),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkGreen)),
                  const SizedBox(height: 8),
                  const Text('CoP 36.0 • Integrated Gold Standard Plant & Equipment Reference', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: green)),
                  const SizedBox(height: 10),
                  Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  const SizedBox(height: 10),
                  const Text('The registry remains the index; these dedicated books are now the active detailed content layer.', style: TextStyle(fontSize: 14.5, height: 1.45)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          ...chapters.map((chapter) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(backgroundColor: green.withValues(alpha: 0.12), child: const Icon(Icons.precision_manufacturing_outlined, color: darkGreen)),
            title: Text(chapter.title, style: const TextStyle(fontWeight: FontWeight.w900, color: darkGreen)),
            subtitle: Text('${chapter.subtitle} • ${chapter.sections.length} sections'),
            trailing: const Icon(Icons.chevron_right, color: darkGreen),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AbuDhabiGoldBookPage(topic: topic, sections: chapter.sections, regulatory: 'Integrated under ADPHC CoP 36.0 Plant and Equipment; apply the specific related CoP and manufacturer requirements for the equipment/task.'))),
          ))),
        ],
      ),
    );
  }
}
