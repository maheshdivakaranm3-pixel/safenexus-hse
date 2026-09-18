/// SafeNexus HSE — Abu Dhabi topic profile registry.
///
/// Excavation is the first locked Gold Standard implementation.
/// The profile is intentionally a navigation/registry layer; detailed learning
/// content lives in the topic content module.

class AbuDhabiHseTopicProfile {
  final String cop;
  final String version;
  final String effectiveDate;
  final List<String> sections;

  const AbuDhabiHseTopicProfile({
    required this.cop,
    required this.version,
    required this.effectiveDate,
    required this.sections,
  });
}

const List<String> abuDhabiExcavationGoldSectionTitles = <String>[
  'Definition & Purpose',
  'Scope & Applications',
  'Types of Excavation',
  'Components / Parts',
  'Pre-Excavation Planning',
  'Site Investigation',
  'Ground / Soil Conditions',
  'Underground Services',
  'Excavation Hazards',
  'Hazard Identification',
  'Causes',
  'Risk & Consequences',
  'Hierarchy of Controls',
  'Shoring / Timbering',
  'Battering / Benching / Sloping',
  'Dimensions, Depths & Safe Limits',
  'Access & Egress',
  'Ladders',
  'Edge Protection & Barricading',
  'Spoil / Material / Plant Setback',
  'Water / Dewatering / Flooding',
  'Atmospheric Hazards & Ventilation',
  'Plant & Vehicle Interface',
  'Adjacent Structures',
  'Road / Public Interface',
  'Lighting / Night Work',
  'RAMS / JSA / Risk Assessment',
  'Permit / Authorization / NOC',
  'Safe Work Procedure',
  'Inspection & Examination',
  'Competency & Responsibilities',
  'PPE',
  'Emergency / Rescue',
  'Stop-Work Conditions',
  'Unsafe Practices → Corrective Actions',
  'Toolbox Talk',
  'Field Checklist / Quick Reference',
  'Abu Dhabi Regulatory References',
];

const Map<String, AbuDhabiHseTopicProfile> abuDhabiHseTopicProfiles = {
  'ad_excavation': AbuDhabiHseTopicProfile(
    cop: 'ADOSH-SF CoP 29.0 – Excavation Work',
    version: 'V4.1',
    effectiveDate: 'February 2026',
    sections: abuDhabiExcavationGoldSectionTitles,
  ),
};
