/// SafeNexus HSE — Oil & Gas Interview
/// Level 5: Supervisor / Engineer Interview
const List<Map<String, String>> oilGasLevel5Questions = [
  {
    'question': 'How do you plan and lead a safe daily work programme?',
    'answer': 'Review the work scope, priorities, manpower, competence, permits, isolations, equipment readiness, SIMOPS, environmental conditions, and emergency arrangements. Conduct a coordination meeting, assign accountable supervisors, verify critical controls in the field, monitor progress, and reassess when conditions or scope change. Close the shift with a documented handover.',
    'technicalExplanation': 'Planning integrates operations, maintenance, contractors, logistics, and HSE. A schedule must not override permit boundaries, critical controls, or legal obligations.',
    'practicalExample': 'For a maintenance campaign, sequence isolation-dependent jobs, prevent conflicting hot work and lifting, confirm access routes, and review high-risk activities at the daily meeting.'
  },
  {
    'question': 'How do you ensure subcontractors meet site HSE requirements?',
    'answer': 'Verify prequalification and scope-specific competence, communicate site rules and performance expectations, review method statements and risk assessments, confirm supervision and equipment readiness, monitor field implementation, and manage deficiencies through coaching and formal escalation. Evaluate performance using evidence and trends.',
    'technicalExplanation': 'Contracting does not transfer away the operator’s responsibility to manage interfaces and verify controls. Requirements should be clear before mobilisation and consistently applied.',
    'practicalExample': 'Before a specialist contractor begins vessel work, verify training, medical or fitness requirements where applicable, rescue capability, calibrated equipment, permit roles, and emergency briefing.'
  },
  {
    'question': 'What would you do when a critical maintenance action is overdue?',
    'answer': 'Confirm the equipment and safety function affected, assess the risk with the responsible technical and operations authorities, determine whether the item is safety-critical, apply the formal defect or impairment process, establish authorised compensating measures or restrictions, and escalate resource or schedule needs. Track restoration and verification to closure.',
    'technicalExplanation': 'An overdue action cannot be accepted solely because the equipment appears to be operating. Risk decisions and extensions require authorised technical justification under the facility system.',
    'practicalExample': 'An overdue test on a protective device is escalated to operations and engineering; affected activities are reviewed and any approved operating restrictions are communicated to shifts.'
  },
  {
    'question': 'How do you manage a serious safety disagreement with a production manager?',
    'answer': 'State the hazard, evidence, applicable control requirement, and potential consequence objectively. Pause affected work if risk is uncontrolled, use the formal escalation and risk review process, involve the authorised technical or operations decision-maker, document the decision, and communicate conditions for safe restart.',
    'technicalExplanation': 'Professional challenge should be respectful, evidence-based, and focused on barrier integrity. HSE advice does not replace the authorised operational decision process.',
    'practicalExample': 'If a required isolation cannot be verified, explain the exposure and stop criteria, request operations verification, and do not release the task based on schedule pressure.'
  },
  {
    'question': 'How do you conduct an effective shift handover for HSE-critical work?',
    'answer': 'Use a structured handover covering active permits, equipment status, isolations, gas test or monitoring status, suspended work, impairments, SIMOPS, personnel accountability, abnormal conditions, open incidents, emergency equipment, and outstanding actions. Confirm the incoming supervisor understands and accepts responsibility under site procedure.',
    'technicalExplanation': 'Critical information should be written, traceable, and verbally confirmed. Ambiguous ownership during shift changes can undermine barriers.',
    'practicalExample': 'A vessel entry is suspended overnight. Handover records entry status, isolation boundaries, atmospheric status, equipment, access security, rescue readiness, and conditions required before re-entry.'
  },
  {
    'question': 'How do you set measurable HSE objectives for a project?',
    'answer': 'Start with significant risks, applicable obligations, project phase, and stakeholder expectations. Define specific leading and lagging indicators, baselines, owners, targets, data sources, review cadence, and corrective triggers. Ensure measures reflect control effectiveness rather than rewarding low reporting.',
    'technicalExplanation': 'Useful indicators may include critical-control verification quality, overdue high-risk actions, competence assurance, permit field compliance, and learning-action effectiveness. Avoid targets that encourage under-reporting.',
    'practicalExample': 'A project tracks completion and field quality of high-risk lift-plan verifications, then reviews recurring defects and corrective action effectiveness weekly.'
  },
  {
    'question': 'How would you manage a major incident investigation as a supervisor?',
    'answer': 'Ensure emergency response and scene safety first, notify the required command and reporting channels, preserve evidence without obstructing rescue, support a competent investigation team, provide accurate records and witness access, and implement immediate safeguards. Track assigned actions and verify effectiveness before normalising the activity.',
    'technicalExplanation': 'Supervisors should avoid altering evidence, coaching witness accounts, or speculating about cause. Investigation independence and reporting requirements follow company and applicable authority rules.',
    'practicalExample': 'After a dropped object, secure the area, preserve the object and tool condition, collect lift and inspection records, and implement temporary controls pending investigation findings.'
  },
  {
    'question': 'How do you verify that workers are competent for a high-risk task?',
    'answer': 'Identify task-specific competence criteria, verify current training and authorisation, assess practical ability where required, confirm familiarity with equipment and procedures, and ensure supervision is appropriate. Reassess after significant changes, poor performance, or a long absence from the task.',
    'technicalExplanation': 'Training attendance alone may not establish competence. Licensing, certification, medical fitness, and refresher requirements are task- and jurisdiction-specific and must be checked against current rules.',
    'practicalExample': 'Before a lifting operation, verify the assigned operator, rigger, and signal person meet the facility’s competence and authorisation requirements for the equipment and lift complexity.'
  },
  {
    'question': 'How do you control fatigue during shutdown or night-shift work?',
    'answer': 'Apply the company fatigue management process, plan realistic shifts and rest, monitor overtime and consecutive duties, assess task criticality, provide suitable welfare and transport arrangements, encourage workers to report fatigue, and adjust staffing or task timing when alertness may be impaired.',
    'technicalExplanation': 'Fatigue is influenced by workload, shift pattern, sleep opportunity, heat, travel, and individual factors. Follow applicable working-time rules and operator standards rather than inventing universal limits.',
    'practicalExample': 'Before a complex night lift, the supervisor checks crew fitness and hours, confirms adequate staffing and lighting, and reschedules if safe performance cannot be assured.'
  },
  {
    'question': 'How do you manage emergency drills and close lessons learned?',
    'answer': 'Select credible scenarios from the risk assessment, define objectives and evaluation criteria, coordinate participants and observers, conduct the drill safely, record actual response times and communication gaps, debrief participants, assign improvement actions, and verify closure through follow-up or repeat exercise.',
    'technicalExplanation': 'A drill is not successful merely because it was completed. Evaluate alarm recognition, command, communication, accountability, access, equipment, and coordination with external responders where relevant.',
    'practicalExample': 'A simulated gas-release drill reveals confusion over muster location. Update signage and induction content, brief shifts, and test understanding in a later exercise.'
  },
  {
    'question': 'What is your approach to environmental compliance on an Oil & Gas project?',
    'answer': 'Identify permits and environmental commitments, assess emissions, discharges, waste, spills, noise, and resource use, establish monitoring and inspection plans, maintain records, train workers, and report deviations promptly. Use approved waste routes and contractors and verify corrective actions.',
    'technicalExplanation': 'Permit conditions and reporting thresholds are site- and authority-specific. Do not discharge, burn, or dispose of materials without the required authorisation and controls.',
    'practicalExample': 'For maintenance waste, classify the waste through the approved process, segregate and label containers, use authorised transport and disposal, and retain manifests or transfer records.'
  },
  {
    'question': 'How do you review a method statement before approving or recommending it?',
    'answer': 'Check that the scope, sequence, resources, competence, equipment, hazards, controls, permits, isolations, interfaces, environmental measures, inspection points, emergency arrangements, and responsibilities are clear and consistent with the risk assessment and site requirements. Resolve gaps with the technical owner before work authorisation.',
    'technicalExplanation': 'A method statement should describe how the work will actually be performed. Generic text, mismatched equipment details, and unclear hold points are warning signs.',
    'practicalExample': 'For pipe removal, verify line identification, isolation and verification steps, residual contents management, lifting method, temporary supports, and reinstatement checks.'
  },
  {
    'question': 'How do you manage change in scope during execution?',
    'answer': 'Pause the affected portion, define the proposed change, assess technical and HSE impacts, review permits and risk assessments, consult relevant authorities and affected teams, obtain required MOC or work-change approval, brief the crew, and verify revised controls before restarting.',
    'technicalExplanation': 'Small field changes can introduce new energy sources, exposures, interfaces, or design assumptions. The site change-control process determines the required level of review.',
    'practicalExample': 'A repair requires a different cutting method than planned. Stop, assess ignition and exposure implications, update the work package and permit conditions, and obtain authorisation.'
  },
  {
    'question': 'How do you coach a supervisor who repeatedly has poor safety observations?',
    'answer': 'Discuss specific observed behaviours and work conditions privately and respectfully, listen for barriers such as unclear planning or inadequate resources, agree practical improvements, provide support or training, and follow up in the field. Escalate repeated deliberate non-compliance through the fair company process.',
    'technicalExplanation': 'Effective coaching distinguishes capability, system, and conduct issues. Avoid relying only on slogans or punitive measures that may discourage reporting.',
    'practicalExample': 'Repeated poor barricading is addressed by reviewing the work-planning process, supplying suitable barriers, assigning ownership, and checking the next jobs for sustained improvement.'
  },
  {
    'question': 'What information should a project HSE dashboard present to leadership?',
    'answer': 'Present a balanced view of exposure, critical-control health, high-potential events, leading and lagging trends, overdue risk actions, audit findings, competence, contractor performance, environmental events, and key decisions needed. Define metrics and explain data limitations so leaders can act on risk rather than chase numbers.',
    'technicalExplanation': 'Dashboard data should be accurate, comparable, and disaggregated where useful by work type, contractor, phase, or exposure. Avoid presenting raw counts without context.',
    'practicalExample': 'A dashboard shows recurring isolation verification gaps by workstream, the affected tasks, action owners, due dates, and whether field rechecks confirm improvement.'
  }
];
