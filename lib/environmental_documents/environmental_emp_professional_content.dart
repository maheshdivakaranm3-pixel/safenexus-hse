/// SafeNexus HSE — Environmental Management Plan (EMP) content framework.
/// Additive file: does not replace existing Environmental topic or document files.
/// Legal applicability must be confirmed against current permit, authority and project conditions.
class EmpSourceReference {
  final String id, title, authority, url, note;
  const EmpSourceReference(this.id, this.title, this.authority, this.url, this.note);
}

class EmpApplicability {
  final String jurisdiction;
  final String status;
  final String basis;
  final String projectCheck;
  const EmpApplicability(this.jurisdiction, this.status, this.basis, this.projectCheck);
}

class EmpSection {
  final String id, title, purpose, guidance, requiredEvidence;
  final List<String> editableFields;
  final List<String> sourceIds;
  final List<EmpApplicability> applicability;
  const EmpSection({
    required this.id, required this.title, required this.purpose,
    required this.guidance, required this.requiredEvidence,
    required this.editableFields, required this.sourceIds,
    required this.applicability,
  });
}

const empSourceReferences = <EmpSourceReference>[
  EmpSourceReference(
    'EAD-SMR-2024',
    'Technical Guidance Document on Environmental Self-Monitoring and Reporting, EAD-EQ-EAP-TG-21, Rev. 00, 30 May 2024',
    'Environment Agency – Abu Dhabi (EAD)',
    'https://www.ead.gov.ae/-/media/Project/EAD/EAD/Join-the-Moment/EAD-EQ-EAP-TG-21-SRP-TGD_0524_01.pdf',
    'Use for monitoring/reporting design where the programme, permit or authority direction applies; verify current revision and project applicability.',
  ),
  EmpSourceReference(
    'EAD-SMR-PROGRAM',
    'Self-Monitoring and Reporting Programme',
    'Environment Agency – Abu Dhabi (EAD)',
    'https://www.ead.gov.ae/en/Join-the-Movement/Government-and-Businesses/Self-Monitoring-and-Reporting-Program',
    'EAD describes programme reporting for key activities and environmental impacts; participation and submissions are not assumed for every project.',
  ),
  EmpSourceReference(
    'DM-ES-TG',
    'Environmental Sustainability Technical Guidelines and Publications',
    'Dubai Municipality (DM), Environmental Sustainability Department',
    'https://www.dm.gov.ae/municipality-business/environment-sustainability-technical-guidelines/',
    'DM identifies approved technical guidelines as environmental requirements for concerned entities; select the relevant guideline for the activity and location.',
  ),
  EmpSourceReference(
    'DM-LAWS',
    'Dubai Municipality Laws and Legislations portal',
    'Dubai Municipality',
    'https://www.dm.gov.ae/municipality-business/copy-of-laws-and-legislations/',
    'Use the current legislation, circulars and department-specific publications applicable to the project.',
  ),
  EmpSourceReference(
    'EAD-SEA',
    'EAD Strategic Environmental Assessment programme — Environmental Management Framework context',
    'Environment Agency – Abu Dhabi (EAD)',
    'https://www.ead.gov.ae/en/Media-Centre/News/Assessment-Programme',
    'EAD describes an environmental management framework covering objectives, roles, training, monitoring and audit in the SEA context; not a universal EMP approval rule.',
  ),
];

const empApplicabilityGuide = <EmpApplicability>[
  EmpApplicability('UAE Federal', 'VERIFY PROJECT APPLICABILITY', 'Check current federal environmental legislation, implementing instruments, competent authority and any federal permit/approval relevant to the activity.', 'Record instrument title/number, current version, applicability rationale, responsible authority and evidence. Do not assume a federal permit is required for every project.'),
  EmpApplicability('Abu Dhabi', 'CONDITIONAL / VERIFY', 'Check EAD requirements, project environmental assessment/permit, approved conditions and whether EAD self-monitoring/reporting programme applies.', 'Confirm project category, permit number, approved EMP/CEMP conditions, reporting scope and written authority direction.'),
  EmpApplicability('Dubai', 'CONDITIONAL / VERIFY', 'Check Dubai Municipality environmental clearance guidance, relevant technical guidelines, circulars and project/development approval conditions.', 'Identify applicable DM guideline/circular and project-specific approval condition; confirm whether environmental clearance or consultant submission is required.'),
  EmpApplicability('Other Emirate / Free Zone', 'VERIFY COMPETENT AUTHORITY', 'Identify the emirate-level authority, free-zone regulator and project-specific permit/contract requirements.', 'Do not reuse Abu Dhabi or Dubai rules without confirming jurisdiction.'),
];

const environmentalManagementPlanSections = <EmpSection>[
  EmpSection(id:'01', title:'Document Control, Review & Approval',
    purpose:'Establish document identity, ownership, controlled revision, review, approval and distribution before site implementation.',
    guidance:'Complete project and contract identifiers. Identify author, technical reviewer, approver and controlled recipients. Record revision history and changes. Do not mark approved until the named approver has signed or formally approved it.',
    requiredEvidence:'Document register entry; revision history; signed approval page; distribution/transmittal record.',
    editableFields:['Project name','Project number','Site/location/emirate','Client','Consultant','Main contractor','Subcontractor(s)','Document number','Revision','Issue date','Prepared by/name/role','Reviewed by/name/role','Approved by/name/role','Distribution list','Revision description'],
    sourceIds:['EAD-SEA','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'02', title:'Purpose, Objectives & Performance Commitments',
    purpose:'State the environmental outcomes the project will manage and how performance will be measured.',
    guidance:'Set project-specific objectives for preventing pollution, protecting receptors, legal/permit compliance, resource efficiency, competence and continual improvement. Each objective should have an owner, indicator, target, method and review period. Targets are project commitments, not automatically statutory limits.',
    requiredEvidence:'Approved objectives/KPI register; baseline and target rationale; management review record.',
    editableFields:['Objective','Environmental outcome','KPI/indicator','Baseline','Project target','Owner','Measurement method','Review frequency','Escalation trigger'],
    sourceIds:['EAD-SEA','EAD-SMR-2024'], applicability:empApplicabilityGuide),
  EmpSection(id:'03', title:'Project Description, Location & Activities',
    purpose:'Define the work scope and environmental context so controls match actual activities and receptors.',
    guidance:'Describe phases, work boundaries, temporary facilities, plant, access, utilities, material flows, working hours and interfaces. Attach site layout and identify nearby homes, water bodies, drainage, coastal/marine areas, protected habitat or other sensitive receptors where present.',
    requiredEvidence:'Approved site layout; method statements; activity schedule; receptor map/site walkdown.',
    editableFields:['Project type','Coordinates/address','Project phases','Work scope','Site area','Working hours','Plant/equipment','Temporary facilities','Nearby receptors','Adjacent land uses','Site drawing reference'],
    sourceIds:['DM-ES-TG','EAD-SEA'], applicability:empApplicabilityGuide),
  EmpSection(id:'04', title:'Scope, Boundaries & Interfaces',
    purpose:'Clarify which contractor activities, subcontractors, suppliers and off-site interfaces are controlled by this EMP.',
    guidance:'Define included and excluded works with reasons. Cover mobilization, construction, testing, commissioning, demobilization and handover as applicable. Identify interfaces with client operations, utility providers, waste contractors and neighboring projects.',
    requiredEvidence:'Scope matrix; contract requirements review; interface responsibility matrix.',
    editableFields:['Included activities','Excluded activities and reason','Project phase coverage','Subcontractor list','Off-site activities','Client/operations interfaces','Waste service providers','Interface owner'],
    sourceIds:['EAD-SEA','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'05', title:'Regulatory, Permit & Other Requirements Register',
    purpose:'Identify and track only those legal, authority, permit, consent, client and contractual requirements that apply to this project.',
    guidance:'For every entry record jurisdiction, issuing authority, exact instrument/guideline/permit condition, version/date, applicability rationale, responsible person, evidence, due date and status. Separate law, permit condition, contract/client requirement and recommended practice. If applicability is unknown, mark OPEN—VERIFY; do not convert it into a confirmed legal obligation.',
    requiredEvidence:'Reviewed legal register; permit/clearance copies; authority correspondence; compliance evaluation records.',
    editableFields:['Requirement category (law/permit/client/recommended)','Jurisdiction','Authority/issuer','Instrument or condition title/number','Version/date checked','Applicability (yes/no/conditional/open)','Reason/evidence','Action/owner','Due date','Compliance evidence','Next review date'],
    sourceIds:['DM-ES-TG','DM-LAWS','EAD-SMR-PROGRAM'], applicability:empApplicabilityGuide),
  EmpSection(id:'06', title:'Environmental Aspects, Impacts & Risk Evaluation',
    purpose:'Identify routine, non-routine and emergency aspects; evaluate impacts and prioritize controls.',
    guidance:'Assess each activity separately: aspect, pathway, receptor, potential impact, existing controls, likelihood, consequence, significance, additional action, owner and residual risk. Include abnormal conditions and credible emergencies. Use the project/client-approved scoring matrix; do not invent universal scoring thresholds.',
    requiredEvidence:'Aspect-impact register; approved risk matrix; review/sign-off; action tracker.',
    editableFields:['Activity/task','Environmental aspect','Impact/pathway','Receptor','Routine/non-routine/emergency','Existing controls','Likelihood score','Severity score','Significance/risk rating','Additional controls','Action owner','Residual rating','Review trigger'],
    sourceIds:['EAD-SEA','DM-ES-TG'], applicability:empApplicabilityGuide),
  EmpSection(id:'07', title:'Roles, Responsibilities & Competence',
    purpose:'Assign accountability for implementing, supervising, monitoring and approving environmental controls.',
    guidance:'Define project manager, environmental officer, construction/supervision team, subcontractors, emergency team, waste vendors and management responsibilities. State competence/induction needs and deputizing arrangements.',
    requiredEvidence:'Responsibility matrix; organization chart; competence and training records; induction attendance.',
    editableFields:['Role','Named person','Responsibilities','Authority/stop-work escalation','Required competence','Training/induction','Deputy','Record owner'],
    sourceIds:['EAD-SEA','EAD-SMR-2024'], applicability:empApplicabilityGuide),
  EmpSection(id:'08', title:'Operational Environmental Controls',
    purpose:'Translate assessed impacts and permit conditions into worksite controls and verifiable acceptance checks.',
    guidance:'Create activity-specific controls for dust/air emissions, noise/vibration, soil and groundwater, surface water/stormwater, concrete washout, chemicals/fuels, waste, sewage, ecology, traffic and resource use only where relevant. State responsible party, pre-start checks, containment, inspection, evidence and stop/escalation criteria. Insert numeric limits only from verified applicable sources or approved project conditions.',
    requiredEvidence:'Task control plans; permits/consents; inspection sheets; photographs; maintenance and service records.',
    editableFields:['Activity/impact','Control measure','Location','Responsible person','Pre-start verification','Inspection method/frequency','Applicable limit/source (if any)','Evidence record','Failure/escalation action'],
    sourceIds:['DM-ES-TG','DM-LAWS','EAD-SMR-2024'], applicability:empApplicabilityGuide),
  EmpSection(id:'09', title:'Waste & Resource Management',
    purpose:'Prevent waste and ensure waste streams are identified, segregated, stored, transferred and disposed/recovered through approved routes.',
    guidance:'List expected waste streams and classification basis, estimated quantities, storage locations, segregation, labeling, secondary containment where needed, approved transporter/receiver verification, transfer records and reconciliation. Confirm hazardous waste classification and destination acceptance with applicable authority/project requirements.',
    requiredEvidence:'Waste register; vendor/receiver approvals as applicable; transfer notes/receipts; reconciliation and housekeeping inspections.',
    editableFields:['Waste stream','Classification basis','Estimated quantity/unit','Segregation/storage method','Storage location','Transporter','Receiving facility','Approval/permit evidence','Transfer document number','Date/quantity','Final receipt/evidence'],
    sourceIds:['DM-ES-TG','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'10', title:'Environmental Monitoring & Measurement Plan',
    purpose:'Define what will be monitored, where, how, by whom, against which approved criteria, and how results are acted upon.',
    guidance:'Build a project-specific schedule from environmental assessment, permit conditions, authority direction and EAD programme applicability. For each parameter define receptor/location, method, instrument/lab, competence, schedule, criterion and source, reporting route, exceedance response and record. Do not assume EAD programme participation or universal frequencies.',
    requiredEvidence:'Approved monitoring schedule; calibration certificates; laboratory accreditation/scope where relevant; raw data; reports; exceedance/CAPA records.',
    editableFields:['Parameter','Activity/source','Monitoring location/receptor','Method/standard','Instrument/lab','Competent person','Frequency (with basis)','Applicable criterion and exact source','Permit/authority condition','Report recipient/deadline','Action if exceedance','Record reference'],
    sourceIds:['EAD-SMR-2024','EAD-SMR-PROGRAM','DM-ES-TG'], applicability:empApplicabilityGuide),
  EmpSection(id:'11', title:'Inspection, Audit & Compliance Evaluation',
    purpose:'Check implementation and compliance, record findings, assign actions and verify closure.',
    guidance:'Set risk-based inspection and audit schedules, responsible inspectors, checklists, finding classification under the project procedure, corrective action owner, due date, evidence and independent closure verification. Distinguish internal checks from authority/client inspections.',
    requiredEvidence:'Inspection/audit schedule; completed checklists; NCR/CAPA log; closure evidence; trend review.',
    editableFields:['Inspection/audit type','Area/activity','Planned date/frequency and basis','Inspector','Checklist/reference','Finding','Risk/priority','Action owner','Due date','Closure evidence','Verified by/date'],
    sourceIds:['EAD-SEA','EAD-SMR-2024','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'12', title:'Emergency Preparedness & Environmental Incident Response',
    purpose:'Prepare for spills, uncontrolled releases, firewater/runoff contamination, sewage release, wildlife impact and other credible environmental emergencies.',
    guidance:'Link to the project emergency plan. Identify scenarios, immediate safe actions, source isolation, drain protection, containment, notification/escalation route, cleanup contractor, waste handling, sampling if directed, incident investigation and restoration. Use authority/client notification timelines only when verified from applicable law, permit or contract.',
    requiredEvidence:'Scenario response cards; contact list; spill kit inspections; drills; incident reports; waste disposal/cleanup records.',
    editableFields:['Scenario','Potential receptor','Initial action','Isolation/containment equipment','Incident controller','Internal notification route','External authority/client trigger and verified source','Cleanup contractor','Post-event monitoring','Investigation/CAPA reference'],
    sourceIds:['EAD-SEA','DM-ES-TG','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'13', title:'Training, Communication & Stakeholder Interface',
    purpose:'Ensure personnel and affected parties understand environmental risks, controls, reporting routes and their responsibilities.',
    guidance:'Set induction, toolbox talk and task-specific briefing needs. Include languages, attendance evidence, contractor communication, complaints/grievance route and authority/client interface as applicable.',
    requiredEvidence:'Training matrix; attendance; briefing materials; communication and complaint log.',
    editableFields:['Audience/role','Topic','Language','Delivery method','Trainer','Planned date','Attendance/evidence','Competency check','Complaint/interface contact'],
    sourceIds:['EAD-SEA','DM-ES-TG'], applicability:empApplicabilityGuide),
  EmpSection(id:'14', title:'Reporting, Records & Retention Control',
    purpose:'Define required reports, recipients, timing, quality checks, record ownership, storage, access and retention basis.',
    guidance:'List daily/weekly/monthly/client/authority reports only where contract, permit, programme or project procedure requires them. Record source for each deadline and retention period. If no verified period is identified, mark “project retention schedule to be confirmed”; do not invent a statutory period.',
    requiredEvidence:'Reporting calendar; submitted reports/transmittals; monitoring datasets; document register; retention schedule.',
    editableFields:['Record/report name','Purpose','Required by (permit/law/client/internal)','Recipient','Frequency/deadline and source','Preparer','Reviewer','Storage location','Access owner','Retention period and source','Disposal/archival approval'],
    sourceIds:['EAD-SMR-2024','EAD-SMR-PROGRAM','DM-LAWS'], applicability:empApplicabilityGuide),
  EmpSection(id:'15', title:'Nonconformance, Corrective Action & Change Management',
    purpose:'Control deviations, incidents, design/site changes and new information that may alter environmental risk or approvals.',
    guidance:'Require review before changes to scope, method, materials, plant, location, schedule or discharge route. Determine whether risk assessment, EMP revision, client/authority notification or approval is needed by checking applicable conditions. Track cause, correction, corrective action, effectiveness and document revision.',
    requiredEvidence:'Change request; updated aspect/risk assessment; approvals/correspondence where required; NCR/CAPA closure.',
    editableFields:['Change/NCR ID','Description/cause','Affected activity/receptor','Risk reassessment','Permit/approval impact check','Required consultation/approval','Action owner/due date','EMP revision','Effectiveness check'],
    sourceIds:['EAD-SEA','DM-LAWS','DM-ES-TG'], applicability:empApplicabilityGuide),
  EmpSection(id:'16', title:'Appendices, Forms & Project Attachments',
    purpose:'Provide the controlled working tools and evidence needed to implement the EMP.',
    guidance:'Attach only current project-controlled documents: site/environmental receptor plan, legal/permit register, aspect-impact register, monitoring schedule, waste register, inspection checklist, emergency contacts, training matrix, incident form, complaint log and report templates. Assign each appendix a code, revision and owner.',
    requiredEvidence:'Appendix index; current approved forms; drawings; permits; registers; transmittals.',
    editableFields:['Appendix ID/title','Revision','Owner','Approval status','File/reference','Issue date','Review date','Linked EMP section'],
    sourceIds:['EAD-SMR-2024','DM-ES-TG','DM-LAWS'], applicability:empApplicabilityGuide),
];

/// Suggested editable project cover fields for a future Flutter form.
const empProjectFields = <String>[
  'Project title','Project ID','Emirate / jurisdiction','Site address / coordinates',
  'Client','Consultant','Main contractor','Environmental consultant (if appointed)',
  'Project description','Project phase','Start/end dates','Authority / permit reference',
  'Environmental assessment reference','EMP document number','Revision','Prepared by',
  'Reviewed by','Approved by','Issue date','Next review trigger/date',
];

/// Export guidance: PDF = controlled issue copy; DOCX = editable working copy;
/// XLSX = registers/schedules only. Exported drafts must be marked DRAFT until approved.
