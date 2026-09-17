import '../models/reference_topic.dart';

class AbuDhabiHseTopicProfile {
  final String cop, version, effectiveDate;
  final List<String> sections;
  const AbuDhabiHseTopicProfile({
    required this.cop, required this.version, required this.effectiveDate,
    required this.sections,
  });
}

const abuDhabiHseTopicProfiles = <String, AbuDhabiHseTopicProfile>{
  'ad_excavation': AbuDhabiHseTopicProfile(
    cop: 'ADOSH-SF CoP 29.0 – Excavation Work',
    version: 'V4.1',
    effectiveDate: 'February 2026',
    sections: [
      'Scope: applies to employers in Abu Dhabi; covers earth/rock movement, ground disturbance, driving objects into ground, underground-service exposure, digging, shafts, wells, trenches, grading, tunnelling, boring/drilling, post driving, cofferdams and caissons.',
      'Planning: competent-person assessment, risk assessment, documented safe system of work, applicable PTW, emergency planning, survey/drawings, validated service searches, required permits/authorisations/NOCs and competent supervision.',
      'Ground conditions: identify soil/ground type; review borehole/trial-pit information and water table; consider contamination and groundwater effects. Slope angles must be selected from the CoP soil-specific table, not a universal angle.',
      'Support: provide timbering/shoring for trenches or excavations greater than 1.2 m where there is danger of material falling or collapsing. Support must be suitable, secure and installed/altered/dismantled by competent persons under supervision.',
      'Access: provide safe entry/exit. Ladders must be secured and maintained; where reasonably practicable use a height-to-base ratio not flatter than 4:1 and project at least 1 m (4 rungs) above ground level. Do not use walings/struts as access.',
      'Edge protection: where a person may fall more than 2 m use rigid barriers; below 2 m use physical edge demarcation. Barriers are 950 mm high under CoP 29.0. Protect against vehicle entry with wheel stops/barriers and use warning lights in darkness where applicable.',
      'Atmosphere: control suffocating, toxic or explosive gases. Consider H2S, methane, sulphur dioxide, plant exhaust and LPG leakage. Deep/confined excavations require gas/oxygen testing arrangements in accordance with CoP 27.0 where applicable.',
      'Inspection: competent-person inspection before work starts, at least daily and before each shift. Thorough examination weekly (every seven days) and after substantial collapse or damage; record results.',
      'Emergency: plan for collapse, flooding, service strike, gas release, fire, falls, plant intrusion and medical emergencies as applicable. Maintain rapid escape routes.',
      'Field checklist: verify drawings/services, permits/NOCs, competent supervisor, ground/support method, ladder/access, 950 mm barriers, >2 m fall controls, plant edge protection, warning lights, atmosphere controls and inspection records.',
      'Stop-work: collapse/cracking/movement; damaged or incomplete support; unexpected ground/water condition; unknown service; missing authorisation; unsafe access; dangerous atmosphere; unsafe edge loading; failed public/traffic protection; failed inspection.',
      'Records: risk assessment, method statement/safe system, permit where required, survey/service records, NOCs/approvals, support design, inspection/examination records, training records, emergency arrangements and toolbox talks.',
      'Training: excavation workers and relevant supervisors/operators must understand hazards, controls, safe systems, emergency rescue, first aid, night work, debris removal, site security and restrictions; retrain when duties or hazards change or deficiencies are identified.',
      'Related CoPs: 21.0 PTW; 22.0 Barricading; 27.0 Confined Spaces; 33.0 Work On/Adjacent to Road; 39.0 Overhead/Underground Services; 53.0/53.1 Construction OSH Management; 54.0 Waste Management.',
    ],
  ),
};
