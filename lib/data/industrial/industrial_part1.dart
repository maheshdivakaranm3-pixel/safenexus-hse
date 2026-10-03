/// Industrial HSE Part 1 — Topics 1–30.
/// Detailed field-use content. Part files are implementation-only; do not show part labels in UI.
class IndustrialTopic {
  final int id;
  final String title;
  final String image;
  final List<String> permitsDocumentsRecords;
  final List<String> emergencyRescueAbnormal;
  final List<String> practicalSiteExample;
  final List<String> commonNonComplianceCorrectiveActions;
  final List<String> interviewPreparation;
  final List<String> siteVerificationChecklist;
  // Compatibility getters used by the existing handbook detail page.
  List<String> get documents => permitsDocumentsRecords;
  String get emergency => emergencyRescueAbnormal.join('\n');
  String get siteExample => practicalSiteExample.join('\n');
  List<String> get controls => commonNonComplianceCorrectiveActions;

  const IndustrialTopic({
    required this.id, required this.title, required this.image,
    required this.permitsDocumentsRecords, required this.emergencyRescueAbnormal,
    required this.practicalSiteExample, required this.commonNonComplianceCorrectiveActions,
    required this.interviewPreparation, required this.siteVerificationChecklist,
  });
}

const String _base = 'assets/images/industrial';
const List<IndustrialTopic> industrialPart1 = [
  IndustrialTopic(
    id: 1, title: 'Industrial HSE Management System', image: '$_base/management/industrial_hse_management.png',
    permitsDocumentsRecords: [
      'Before industrial hse management system, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Approved audit/inspection schedule, criteria, checklists, reports, evidence references and risk-ranked findings register.',
      'Corrective-action tracker showing owner, due date, interim controls, root cause, closure evidence and independent verification.',
      'Management review minutes, KPI definitions/source data, training and competency matrix, document revision history and retention index.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial hse management system during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial hse management system without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial hse management system? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 2, title: 'UAE Industrial HSE Legal & Regulatory Compliance', image: '$_base/management/industrial_legal_compliance.png',
    permitsDocumentsRecords: [
      'Before uae industrial hse legal & regulatory compliance, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Approved audit/inspection schedule, criteria, checklists, reports, evidence references and risk-ranked findings register.',
      'Corrective-action tracker showing owner, due date, interim controls, root cause, closure evidence and independent verification.',
      'Management review minutes, KPI definitions/source data, training and competency matrix, document revision history and retention index.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans uae industrial hse legal & regulatory compliance during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on uae industrial hse legal & regulatory compliance without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before uae industrial hse legal & regulatory compliance? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 3, title: 'Industrial Hazard Identification & Risk Assessment', image: '$_base/management/industrial_risk_assessment.png',
    permitsDocumentsRecords: [
      'Before industrial hazard identification & risk assessment, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial hazard identification & risk assessment during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial hazard identification & risk assessment without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial hazard identification & risk assessment? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 4, title: 'JSA & Safe Work Method Statements', image: '$_base/management/industrial_jsa_swms.png',
    permitsDocumentsRecords: [
      'Before jsa & safe work method statements, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans jsa & safe work method statements during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on jsa & safe work method statements without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before jsa & safe work method statements? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 5, title: 'Industrial PTW System', image: '$_base/management/industrial_ptw.png',
    permitsDocumentsRecords: [
      'Before industrial ptw system, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial ptw system during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial ptw system without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial ptw system? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 6, title: 'Management of Change', image: '$_base/management/industrial_moc.png',
    permitsDocumentsRecords: [
      'Before management of change, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans management of change during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on management of change without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before management of change? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 7, title: 'Contractor & Subcontractor HSE Management', image: '$_base/management/industrial_contractor_hse.png',
    permitsDocumentsRecords: [
      'Before contractor & subcontractor hse management, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans contractor & subcontractor hse management during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on contractor & subcontractor hse management without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before contractor & subcontractor hse management? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 8, title: 'Industrial HSE Inspection & Audit', image: '$_base/management/industrial_hse_inspection.png',
    permitsDocumentsRecords: [
      'Before industrial hse inspection & audit, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Approved audit/inspection schedule, criteria, checklists, reports, evidence references and risk-ranked findings register.',
      'Corrective-action tracker showing owner, due date, interim controls, root cause, closure evidence and independent verification.',
      'Management review minutes, KPI definitions/source data, training and competency matrix, document revision history and retention index.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial hse inspection & audit during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial hse inspection & audit without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial hse inspection & audit? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 9, title: 'Incident/Near-Miss Investigation & Reporting', image: '$_base/management/industrial_incident_investigation.png',
    permitsDocumentsRecords: [
      'Before incident/near-miss investigation & reporting, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans incident/near-miss investigation & reporting during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on incident/near-miss investigation & reporting without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before incident/near-miss investigation & reporting? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 10, title: 'HSE Performance Monitoring, KPI & Continuous Improvement', image: '$_base/management/industrial_hse_kpi.png',
    permitsDocumentsRecords: [
      'Before hse performance monitoring, kpi & continuous improvement, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Approved audit/inspection schedule, criteria, checklists, reports, evidence references and risk-ranked findings register.',
      'Corrective-action tracker showing owner, due date, interim controls, root cause, closure evidence and independent verification.',
      'Management review minutes, KPI definitions/source data, training and competency matrix, document revision history and retention index.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans hse performance monitoring, kpi & continuous improvement during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on hse performance monitoring, kpi & continuous improvement without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before hse performance monitoring, kpi & continuous improvement? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 11, title: 'Industrial Machinery Guarding', image: '$_base/machinery/industrial_machine_guarding.png',
    permitsDocumentsRecords: [
      'Before industrial machinery guarding, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial machinery guarding during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial machinery guarding without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial machinery guarding? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 12, title: 'Machine Operation & Safe Operating Procedures', image: '$_base/machinery/industrial_machine_sop.png',
    permitsDocumentsRecords: [
      'Before machine operation & safe operating procedures, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans machine operation & safe operating procedures during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on machine operation & safe operating procedures without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before machine operation & safe operating procedures? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 13, title: 'CNC, Lathe, Milling & Drilling Machine Safety', image: '$_base/machinery/industrial_cnc_safety.png',
    permitsDocumentsRecords: [
      'Before cnc, lathe, milling & drilling machine safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans cnc, lathe, milling & drilling machine safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on cnc, lathe, milling & drilling machine safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before cnc, lathe, milling & drilling machine safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 14, title: 'Press, Punching & Shearing Machine Safety', image: '$_base/machinery/industrial_press_safety.png',
    permitsDocumentsRecords: [
      'Before press, punching & shearing machine safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans press, punching & shearing machine safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on press, punching & shearing machine safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before press, punching & shearing machine safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 15, title: 'Grinding, Cutting & Abrasive Wheel Safety', image: '$_base/machinery/industrial_grinding_safety.png',
    permitsDocumentsRecords: [
      'Before grinding, cutting & abrasive wheel safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans grinding, cutting & abrasive wheel safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on grinding, cutting & abrasive wheel safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before grinding, cutting & abrasive wheel safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 16, title: 'Conveyor Systems & Nip-Point Protection', image: '$_base/machinery/industrial_conveyor_safety.png',
    permitsDocumentsRecords: [
      'Before conveyor systems & nip-point protection, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans conveyor systems & nip-point protection during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on conveyor systems & nip-point protection without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before conveyor systems & nip-point protection? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 17, title: 'Robotics, Automation & Industrial Control Safety', image: '$_base/machinery/industrial_robot_safety.png',
    permitsDocumentsRecords: [
      'Before robotics, automation & industrial control safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans robotics, automation & industrial control safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on robotics, automation & industrial control safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before robotics, automation & industrial control safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 18, title: 'Mechanical Workshop Safety', image: '$_base/machinery/industrial_mechanical_workshop.png',
    permitsDocumentsRecords: [
      'Before mechanical workshop safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans mechanical workshop safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on mechanical workshop safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before mechanical workshop safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 19, title: 'Hand Tools & Portable Power Tools', image: '$_base/machinery/industrial_power_tools.png',
    permitsDocumentsRecords: [
      'Before hand tools & portable power tools, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Use the emergency stop if safe, warn nearby workers and prevent access to moving or trapped machinery.',
      'Isolate all energy sources and apply the site\'s LOTO/rescue procedure; never reach into a machine or reverse equipment unless the approved rescue plan directs a competent person.',
      'Call site emergency response and trained first aid. Control bleeding/crush injuries and arrange prompt medical care.',
      'Secure the scene and equipment; preserve evidence and require a competent inspection, corrective actions and authorized restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans hand tools & portable power tools during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on hand tools & portable power tools without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before hand tools & portable power tools? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 20, title: 'Industrial Equipment Inspection & Maintenance', image: '$_base/machinery/industrial_equipment_inspection.png',
    permitsDocumentsRecords: [
      'Before industrial equipment inspection & maintenance, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Approved audit/inspection schedule, criteria, checklists, reports, evidence references and risk-ranked findings register.',
      'Corrective-action tracker showing owner, due date, interim controls, root cause, closure evidence and independent verification.',
      'Management review minutes, KPI definitions/source data, training and competency matrix, document revision history and retention index.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial equipment inspection & maintenance during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial equipment inspection & maintenance without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial equipment inspection & maintenance? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 21, title: 'Industrial Electrical Safety', image: '$_base/electrical/industrial_electrical_safety.png',
    permitsDocumentsRecords: [
      'Before industrial electrical safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop work without approaching exposed conductors; raise alarm and keep others outside the electrical danger zone.',
      'Only an authorized person may isolate at a safe upstream point; treat equipment as energized until tested and formally confirmed dead.',
      'Do not touch a casualty until electrical contact is safely interrupted. Call site emergency response, provide trained first aid/AED when safe, and arrange medical assessment for shock or burns.',
      'Preserve the scene, report the event, investigate protection/isolation failures and permit restart only after competent technical clearance.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial electrical safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial electrical safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial electrical safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 22, title: 'Electrical Panels, Switchgear & Distribution', image: '$_base/electrical/industrial_switchgear.png',
    permitsDocumentsRecords: [
      'Before electrical panels, switchgear & distribution, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop work without approaching exposed conductors; raise alarm and keep others outside the electrical danger zone.',
      'Only an authorized person may isolate at a safe upstream point; treat equipment as energized until tested and formally confirmed dead.',
      'Do not touch a casualty until electrical contact is safely interrupted. Call site emergency response, provide trained first aid/AED when safe, and arrange medical assessment for shock or burns.',
      'Preserve the scene, report the event, investigate protection/isolation failures and permit restart only after competent technical clearance.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans electrical panels, switchgear & distribution during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on electrical panels, switchgear & distribution without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before electrical panels, switchgear & distribution? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 23, title: 'Electrical Arc Flash & Arc Blast', image: '$_base/electrical/industrial_arc_flash.png',
    permitsDocumentsRecords: [
      'Before electrical arc flash & arc blast, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop work without approaching exposed conductors; raise alarm and keep others outside the electrical danger zone.',
      'Only an authorized person may isolate at a safe upstream point; treat equipment as energized until tested and formally confirmed dead.',
      'Do not touch a casualty until electrical contact is safely interrupted. Call site emergency response, provide trained first aid/AED when safe, and arrange medical assessment for shock or burns.',
      'Preserve the scene, report the event, investigate protection/isolation failures and permit restart only after competent technical clearance.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans electrical arc flash & arc blast during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on electrical arc flash & arc blast without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before electrical arc flash & arc blast? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 24, title: 'LOTO & Energy Isolation', image: '$_base/electrical/industrial_loto.png',
    permitsDocumentsRecords: [
      'Before loto & energy isolation, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit-to-work where the site permit matrix requires it; attach isolation certificate, lock register, line-break certificate or electrical work authorization as applicable.',
      'Current equipment drawings, operating procedure, competency/authorization records, inspection certificates and pre-use checklist relevant to the task.',
      'Shift handover, permit suspension/revalidation, gas-test records where applicable, close-out and controlled return-to-service record.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans loto & energy isolation during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on loto & energy isolation without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before loto & energy isolation? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 25, title: 'Stored Energy & Zero-Energy Verification', image: '$_base/electrical/industrial_zero_energy.png',
    permitsDocumentsRecords: [
      'Before stored energy & zero-energy verification, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans stored energy & zero-energy verification during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on stored energy & zero-energy verification without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before stored energy & zero-energy verification? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 26, title: 'Hydraulic & Pneumatic System Safety', image: '$_base/electrical/industrial_hydraulic_pneumatic.png',
    permitsDocumentsRecords: [
      'Before hydraulic & pneumatic system safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop the activity and keep personnel clear of the pressure/line-of-fire zone; do not tighten, strike or disconnect a pressurized component.',
      'Use designated remote or safe isolation and depressurization points; verify zero pressure and stored energy before approach.',
      'For rupture, leak, burn or injection injury, activate alarm, evacuate/cordon the area and summon trained responders; treat high-pressure injection as an urgent medical emergency.',
      'Do not restart until competent inspection identifies the cause, defective parts are repaired and required testing/authorization is documented.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans hydraulic & pneumatic system safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on hydraulic & pneumatic system safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before hydraulic & pneumatic system safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 27, title: 'Compressed Air System Safety', image: '$_base/electrical/industrial_compressed_air.png',
    permitsDocumentsRecords: [
      'Before compressed air system safety, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop the activity and keep personnel clear of the pressure/line-of-fire zone; do not tighten, strike or disconnect a pressurized component.',
      'Use designated remote or safe isolation and depressurization points; verify zero pressure and stored energy before approach.',
      'For rupture, leak, burn or injection injury, activate alarm, evacuate/cordon the area and summon trained responders; treat high-pressure injection as an urgent medical emergency.',
      'Do not restart until competent inspection identifies the cause, defective parts are repaired and required testing/authorization is documented.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans compressed air system safety during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on compressed air system safety without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before compressed air system safety? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 28, title: 'Pressure Vessels & Pressure Systems', image: '$_base/electrical/industrial_pressure_vessel.png',
    permitsDocumentsRecords: [
      'Before pressure vessels & pressure systems, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit and authorizations required by the site PTW matrix; include isolation, equipment certification, inspection or specialist approval when applicable.',
      'Current manufacturer instructions, operating procedure, drawings, inspection/pre-use records, competency evidence and toolbox-talk attendance.',
      'Shift handover, inspection findings, maintenance/defect reports, incident/near-miss records and signed close-out/return-to-service evidence.',
    ],
    emergencyRescueAbnormal: [
      'Stop the activity and keep personnel clear of the pressure/line-of-fire zone; do not tighten, strike or disconnect a pressurized component.',
      'Use designated remote or safe isolation and depressurization points; verify zero pressure and stored energy before approach.',
      'For rupture, leak, burn or injection injury, activate alarm, evacuate/cordon the area and summon trained responders; treat high-pressure injection as an urgent medical emergency.',
      'Do not restart until competent inspection identifies the cause, defective parts are repaired and required testing/authorization is documented.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans pressure vessels & pressure systems during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on pressure vessels & pressure systems without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before pressure vessels & pressure systems? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
  IndustrialTopic(
    id: 29,
    title: 'Boiler, Steam & Thermal System Safety',
    image: '$_base/electrical/industrial_boiler_steam.png',
    permitsDocumentsRecords: [
      'Boiler registration/asset identity and current statutory or third-party examination certificates required by the applicable UAE emirate, authority, insurer and site compliance register; retain inspection scope, defects, recommendations and closure evidence. Do not assume one certificate or interval applies to every boiler.',
      'Approved boiler operating procedure and manufacturer manual covering start-up, normal operation, controlled shutdown, emergency shutdown, water-quality limits, burner management, alarms, trips, pressure limits and permitted operating envelope; current P&ID and isolation drawings available at the work location.',
      'Boiler logbook: operating pressure and temperature, drum level, feedwater condition, blowdown, water-treatment results, burner/flame status, alarm/trip events, operator rounds, shift handover and abnormal readings with action taken.',
      'For maintenance, cleaning, inspection or entry: task-specific risk assessment/JSA, permit(s) required by site PTW matrix, equipment-specific isolation certificate/LOTO register, verified depressurization and drain/vent plan, line-break or confined-space controls where applicable, gas test and rescue plan where required.',
      'Competency/authorization records for boiler operators, burner technicians, inspectors and maintenance personnel; calibration and functional-test records for pressure gauges, safety valves, low-water cut-out, flame safeguard, trips, interlocks and alarm devices; water-treatment chemical SDS and handling controls.',
      'Pressure-part repair, alteration, welding or return to service: approved repair method, qualified personnel/procedure where required, material traceability, NDT/pressure-test records and written acceptance by the designated competent authority before operation.'
    ],
    emergencyRescueAbnormal: [
      'Low-low water level, suspected dry firing, rapid pressure rise, flame failure, furnace puff/backfire, abnormal vibration, water hammer or repeated safety-device activation: initiate the approved emergency shutdown from a safe position, alert the control room/supervisor and keep personnel clear. Do not defeat, reset repeatedly or bypass a trip to keep production running.',
      'Steam leak or suspected pressure-boundary failure: do not approach, touch, tighten, clamp or cross the plume. Raise alarm, evacuate upwind/away from the release, isolate remotely only if the approved procedure permits, establish a barricaded exclusion zone and call the site emergency team.',
      'For suspected boiler overpressure, bulging, unusual structural noise or imminent rupture: activate the site emergency response, evacuate the defined danger area and prevent re-entry until competent inspection and clearance. Never manually restrain a safety valve or block its discharge.',
      'For steam scald, hot-water burn or chemical-treatment exposure: summon trained first aid/medical response, use emergency shower/eyewash for chemical exposure where safe, cool thermal burns with clean cool running water according to site first-aid protocol, do not remove stuck clothing and arrange urgent medical assessment.',
      'After any trip, leak, water hammer, dry-fire suspicion or safety-valve lift: keep the boiler out of service, preserve alarm/log data, have a competent person determine cause and inspect affected pressure parts and protective devices; restart only after documented authorization and required tests.'
    ],
    practicalSiteExample: [
      'At a UAE manufacturing plant, the day-shift operator observes boiler drum level fluctuating and a low-water alarm. The operator follows the approved abnormal-operation procedure, informs the control room and supervisor, reduces or stops firing using the designated controls and does not bypass the low-water trip. The area is kept clear while the authorized boiler technician checks feedwater supply, level indication and control instrumentation.',
      'Before a planned blowdown, the supervisor confirms the written operating procedure, trained operator, correct valve identification, discharge destination, hot-surface protection, restricted access and communication with the control room. The operator uses the specified sequence and observes the level/pressure response; any abnormal vibration, water hammer or leakage means stop and report.',
      'For internal inspection, the boiler is shut down, cooled, drained, vented and isolated from fuel, steam, feedwater, blowdown and connected systems under the site isolation procedure. Zero-energy state is verified at designated points; confined-space entry controls, atmospheric testing, attendant and rescue arrangements are applied if the entry classification requires them. The inspection team records findings and no return to service occurs until covers, guards, instruments and protective devices are restored and the authorized release is signed.'
    ],
    commonNonComplianceCorrectiveActions: [
      'Operator relies on a single faulty level gauge or ignores inconsistent level indications: stop/secure operation under the approved procedure, verify using designated independent indication and have instrumentation inspected before restart.',
      'Low-water, flame-failure, high-pressure trip or burner interlock is bypassed, bridged or repeatedly reset: stop firing, isolate as required, report as a critical safety-system impairment, restore and function-test through authorized personnel, investigate why bypass was attempted and formally authorize return to service.',
      'Safety valve discharge is capped, isolated, obstructed or directed toward an occupied access route: remove the boiler from service where safety is compromised; have a competent person restore the approved discharge arrangement and verify valve condition and capacity before operation.',
      'Steam/condensate leak is treated as minor or workers approach the plume: isolate/cordon the area, brief personnel on invisible steam and line-of-fire risk, repair under approved isolation and verify leak-free condition before reopening.',
      'Blowdown is performed without confirming receiving system capacity, safe discharge route or communication: suspend the task, reassess procedure and receiving-system hazards, define barriers and responsible operator, then rebrief before resuming.',
      'Maintenance starts without positive isolation, trapped-pressure checks or documented handback: stop work, make the system safe, apply equipment-specific LOTO and verify zero pressure/temperature/energy at approved points; complete inspection, reinstatement and authorized handover.'
    ],
    interviewPreparation: [
      'Q: What are the critical boiler protections? A: As designed and specified for that boiler: independent level indication and low-water protection, pressure indication, correctly selected/maintained safety valves, burner flame safeguard, fuel shutoff, alarms, trips and feedwater controls. Verify actual arrangement against manufacturer documentation and applicable code.',
      'Q: What should an operator do on a low-low water trip? A: Follow the boiler emergency procedure, stop firing using designated controls, notify the responsible supervisor and do not add water or restart until the cause and possible overheating/damage have been assessed by competent personnel.',
      'Q: Why is water treatment important? A: To control scale, corrosion, carryover and deposits that can impair heat transfer, damage pressure parts and contribute to unsafe operation. Use the approved treatment program and documented test limits for the specific boiler.',
      'Q: What is water hammer and how is it prevented? A: A pressure surge from rapid flow change or condensate in steam piping. Apply the approved warm-up/drainage procedure, maintain traps and drainage, open valves in the specified controlled manner and investigate abnormal impact/noise.',
      'Q: What is required before opening a boiler for inspection? A: Approved shutdown, cooling, depressurization, draining, positive isolation from all connected energy/material sources, verification of zero energy, permit and confined-space controls where applicable, atmospheric testing, attendant/rescue provisions and authorized entry.',
      'Q: Can a boiler be restarted after a trip just by resetting it? A: No. Identify and correct the initiating cause, check for damage or unsafe conditions, confirm protective devices are functional and obtain the designated authorized release under the site procedure.'
    ],
    siteVerificationChecklist: [
      'OPERATING ENVELOPE: current approved procedure/manual available; operator authorized; pressure, temperature and level within the equipment-specific limits; logbook and shift handover current; no unexplained alarm, trip, leak, vibration or water hammer.',
      'PROTECTIVE DEVICES: level indication credible and cross-checked as prescribed; low-water and high-pressure protection, flame safeguard, fuel shutoff, alarms and interlocks in service; safety valves unisolated with unobstructed safe discharge; calibration/function tests within the applicable approved schedule.',
      'FUEL & COMBUSTION: burner, fuel train, ventilation, purge sequence, flame detection and emergency shutoff maintained as specified; no unauthorized modification, combustible accumulation or ignition source; abnormal flame/combustion readings escalated.',
      'WATER & CHEMICALS: feedwater and treatment parameters within boiler-specific limits; chemical SDS, labelled containers, bunding and eyewash/shower provisions available as required; blowdown discharge route and receiving-system capacity confirmed.',
      'MAINTENANCE / ENTRY: permit and JSA approved; all connected steam, feedwater, fuel, blowdown and electrical/control energy sources identified and isolated; depressurization, cooling and drainage verified; zero-energy checks recorded; confined-space gas test, attendant and rescue arrangements applied where required.',
      'RETURN TO SERVICE: repairs/inspection findings closed; pressure-boundary tests/NDT and statutory or competent-person acceptance completed where required; guards, covers, instruments and interlocks restored; area clear; controlled start-up completed by authorized operator and handback documented.'
    ],
  ),
  IndustrialTopic(
    id: 30, title: 'Industrial Utility Systems & Service Isolation', image: '$_base/electrical/industrial_utility_isolation.png',
    permitsDocumentsRecords: [
      'Before industrial utility systems & service isolation, define the work boundary, equipment/tag numbers, operating state and interfaces in the approved risk assessment and JSA/SWMS; list each step, hazard, control, owner and stop-work trigger.',
      'Permit-to-work where the site permit matrix requires it; attach isolation certificate, lock register, line-break certificate or electrical work authorization as applicable.',
      'Current equipment drawings, operating procedure, competency/authorization records, inspection certificates and pre-use checklist relevant to the task.',
      'Shift handover, permit suspension/revalidation, gas-test records where applicable, close-out and controlled return-to-service record.',
    ],
    emergencyRescueAbnormal: [
      'Stop affected work, raise the site alarm and protect people from immediate exposure; evacuate or establish an exclusion zone as the scenario requires.',
      'Notify the control room/supervisor and activate the site emergency plan. Only trained, equipped responders may perform rescue or isolation.',
      'Provide first aid within competence, account for personnel and arrange emergency medical support.',
      'Report and preserve relevant evidence; investigate causes, close corrective actions and obtain responsible-person authorization before restart.',
    ],
    practicalSiteExample: [
      'At a UAE industrial facility, the supervisor plans industrial utility systems & service isolation during the pre-job briefing. The HSE Officer walks the work area with the task owner, checks the approved method and site permit conditions, verifies worker authorization and equipment condition, confirms barriers and emergency arrangements, then records any gap. Work starts only after responsible persons accept the controls; conditions are rechecked after a change, break or shift handover.',
    ],
    commonNonComplianceCorrectiveActions: [
      'Work begins on industrial utility systems & service isolation without a current task-specific risk assessment or workers cannot explain the critical controls. Stop the affected task, brief the team and approve a corrected JSA before restart.',
      'Required authorization, inspection evidence or competency proof is missing, expired or does not match the actual equipment/task. Quarantine the affected activity/equipment, verify status with the competent person and update controlled records.',
      'A safeguard, exclusion zone, isolation or housekeeping control is bypassed or deteriorated. Make the area safe immediately, assign a named owner and due date, investigate why the control failed, then verify effectiveness on site before closure.',
    ],
    interviewPreparation: [
      'Q: What are your first HSE checks before industrial utility systems & service isolation? A: Confirm scope and worksite conditions, review risk assessment/JSA and permit triggers, verify competent/authorized people, inspect safeguards, brief the crew and confirm emergency arrangements.',
      'Q: What would you do if the job differs from the approved method? A: Stop the affected work, make the area safe, reassess the changed hazards, revise approvals and brief the team before authorized restart.',
      'Q: How do you prove corrective action is effective? A: Check physical implementation at the worksite, interview affected workers, review records and monitor recurrence; do not close on a promise or photograph alone.',
    ],
    siteVerificationChecklist: [
      'Before: confirm scope/location, approved JSA/SWMS, permit and isolations; check drawings/instructions, competency, fitness, toolbox talk, equipment certification, pre-use inspection, barriers and emergency access.',
      'During: verify controls remain in place, monitor changing conditions and simultaneous operations, maintain communication and supervision, stop work for deviation, defect, alarm or changed risk; record inspections and handovers.',
      'After: leave equipment/area safe, account for tools and personnel, remove temporary controls only under authorization, close permit, report defects and lessons, attach evidence and obtain competent return-to-service/area handback.',
    ],
  ),
];
