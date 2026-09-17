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

const Map<String, AbuDhabiHseTopicProfile> abuDhabiHseTopicProfiles = {
  'ad_excavation': AbuDhabiHseTopicProfile(
    cop: 'ADOSH-SF CoP 29.0 – Excavation Work',
    version: 'V4.1',
    effectiveDate: 'February 2026',
    sections: [
      'Scope: Applies to employers in Abu Dhabi and covers excavation activities including earth or rock removal, ground disturbance, trenches, shafts, wells, grading, tunnelling, boring, drilling, post driving, cofferdams and caissons, including activities that may expose or damage underground services.',

      'Planning: Complete a site-specific risk assessment and documented safe system of work. A competent person must assess the excavation before work starts. Verify applicable permits, authorisations, notifications, approvals, drawings, surveys, service information and emergency arrangements.',

      'Ground conditions: Identify the ground or soil type before excavation. Review available ground investigation information, trial pits, boreholes and groundwater conditions. Consider contamination, water ingress and adjacent ground stability. Do not apply one universal excavation angle; use the applicable CoP requirements for the actual ground conditions.',

      'Support: For trenches or excavations greater than 1.2 m where there is danger of material falling or collapse, provide suitable timbering or shoring. Support systems must be suitable, secure and maintained. Installation, alteration and dismantling must be carried out by competent persons under appropriate supervision.',

      'Access and egress: Provide safe means of entering and leaving the excavation. Ladders must be secure and maintained. Where reasonably practicable, ladder positioning should follow a height-to-base ratio not flatter than 4:1. Ladders must project at least 1 m (4 rungs) above ground level to provide a suitable handhold. Do not use walings or struts as access routes.',

      'Edge protection: Where a person may fall more than 2 m, provide appropriate rigid barriers. Where the fall potential is below 2 m, provide suitable physical edge demarcation. CoP 29.0 specifies 950 mm barrier height. Protect excavation edges from vehicle intrusion using suitable barriers or wheel stops where required.',

      'Public and night protection: Where excavations interface with public areas or thoroughfares, maintain effective barricading and warning arrangements. Use suitable hazard warning lights during darkness where applicable. Replace temporarily removed barriers as soon as reasonably practicable.',

      'Atmospheric hazards: Assess the possibility of suffocating, toxic or explosive gases. Potential sources include hydrogen sulphide, methane, sulphur dioxide, exhaust gases and LPG leakage. Provide ventilation and atmospheric monitoring where required. Where confined-space conditions exist, apply the applicable confined-space requirements; not every excavation is automatically a confined space.',

      'Inspection: A competent and experienced person must inspect the excavation before work starts, at least once a day and before each shift. Conduct the required thorough examination at the specified interval and after substantial collapse or damage. Record inspection and examination results.',

      'Weather and water: Reassess excavation stability after heavy rain, flooding, groundwater changes or other adverse conditions. Control water ingress and prevent conditions that could weaken excavation sides or support systems.',

      'Plant and vehicles: Keep heavy plant, vehicles, materials and other loads away from excavation edges unless the support system and excavation have been assessed for the imposed loading. Provide suitable physical protection where plant could accidentally enter the excavation.',

      'Underground services: Confirm available service drawings, surveys, service-owner information, NOCs and other required approvals before excavation. Where underground services are identified, follow the applicable safe-digging and service-protection requirements, including the requirements of CoP 39.0.',

      'Emergency: Establish arrangements for excavation collapse, flooding, underground-service strike, gas release, fire, falls, plant intrusion and medical emergencies as applicable. Maintain clear escape routes and ensure emergency arrangements are communicated to workers.',

      'Field checklist: Verify drawings and service information; permits and NOCs; competent supervision; ground conditions; excavation support or safe sloping; ladder and access; edge protection; plant exclusion controls; warning lights; atmospheric controls; inspection records; emergency arrangements and worker competency.',

      'Stop-work conditions: Stop work when there is collapse, cracking, bulging, slumping or unexpected movement; damaged or incomplete support; unexpected ground or water conditions; unidentified underground services; missing permit or authorisation; unsafe access or egress; dangerous atmosphere; unsafe edge loading; failed barricading or public protection; or an inspection identifies an uncontrolled serious hazard.',

      'Documents and records: Maintain applicable risk assessments, method statements or safe systems of work, permits, drawings, surveys, service-search records, NOCs and approvals, engineering/support information, inspection and examination records, training and competency records, toolbox-talk records and emergency arrangements.',

      'Training and competency: Workers, supervisors and relevant plant operators must understand excavation hazards, safe systems of work, controls, emergency response, rescue, first aid, site security and applicable restrictions. Training must be refreshed when duties change, unfamiliar hazards are introduced or inadequate knowledge is identified.',

      'Interview Q&A: Regulatory reference — ADOSH-SF CoP 29.0 Excavation Work. Shoring/timbering threshold — greater than 1.2 m where there is danger of material falling or collapse. Ladder projection — at least 1 m (4 rungs) above ground level. Barrier height — 950 mm under the CoP requirement. Fall protection — rigid barriers where a person may fall more than 2 m. Inspection — before starting, at least daily and before each shift, with the required thorough examinations and post-collapse/post-damage checks.',

      'Related Abu Dhabi requirements: CoP 21.0 Permit to Work Systems; CoP 22.0 Barricading of Hazards; CoP 27.0 Confined Spaces; CoP 33.0 Working On or Adjacent to a Road; CoP 39.0 Overhead and Underground Services; CoP 53.0/53.1 Construction OSH Management; CoP 54.0 Waste Management.',
    ],
  ),
};
