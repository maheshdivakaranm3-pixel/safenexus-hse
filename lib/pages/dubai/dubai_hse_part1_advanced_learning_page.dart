import 'package:flutter/material.dart';

/// SAFE NEXUS HSE — Part 1 Advanced Learning, Topics 1–10
/// Same visual structure as lifting_advanced_learning_page.dart.

class DubaiHsePart1AdvancedLearningPage extends StatelessWidget {
  final String topicId,title,summary,topicTitle;
  const DubaiHsePart1AdvancedLearningPage({super.key,required this.topicId,required this.title,required this.summary,required this.topicTitle});
  static const Color primary=Color(0xFF087F5B); static const Color dark=Color(0xFF17352B); static const Color background=Color(0xFFF5F8F7);
  List<String> get points=>DubaiPart1AdvancedData.points(topicId,title,summary);
  @override Widget build(BuildContext context){final p=points;return Scaffold(backgroundColor:background,appBar:AppBar(backgroundColor:const Color(0xFFE8F3EF),foregroundColor:dark,elevation:0,title:const Text('Advanced Learning',maxLines:1,overflow:TextOverflow.ellipsis)),body:ListView(padding:const EdgeInsets.fromLTRB(16,16,16,30),children:[
    Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[Color(0xFFE3F4ED),Color(0xFFF9FBFA)]),boxShadow:const[BoxShadow(blurRadius:8,offset:Offset(0,3),color:Color(0x22000000))]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('ADVANCED HSE LEARNING',style:TextStyle(color:primary,fontSize:14,fontWeight:FontWeight.w800,letterSpacing:.7)),const SizedBox(height:8),Text(title,style:const TextStyle(color:dark,fontSize:27,height:1.18,fontWeight:FontWeight.w800)),const SizedBox(height:12),Text(summary,style:const TextStyle(color:Color(0xFF40514A),fontSize:15.5,height:1.5))])),
    const SizedBox(height:14),
    Card(elevation:1,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),child:Padding(padding:const EdgeInsets.fromLTRB(18,18,18,8),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Detailed Professional Guidance',style:TextStyle(color:dark,fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:14),...List.generate(p.length,(i)=>Container(margin:const EdgeInsets.only(bottom:12),padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:const Color(0xFFF7FAF9),borderRadius:BorderRadius.circular(14),border:Border.all(color:const Color(0xFFDDE9E4))),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[Container(width:32,height:32,alignment:Alignment.center,decoration:BoxDecoration(color:const Color(0xFFE1F3EC),borderRadius:BorderRadius.circular(9)),child:Text('${i+1}',style:const TextStyle(color:primary,fontWeight:FontWeight.w800))),const SizedBox(width:11),Expanded(child:Text(p[i],style:const TextStyle(color:Color(0xFF34443E),fontSize:15.5,height:1.5)))]))),]))),
    const SizedBox(height:12),_stopWorkCard(),
  ]));}
  Widget _stopWorkCard()=>Container(padding:const EdgeInsets.all(17),decoration:BoxDecoration(color:const Color(0xFFFFF8E7),borderRadius:BorderRadius.circular(18),border:Border.all(color:const Color(0xFFE8D8A8))),child:const Text('STOP-WORK PRINCIPLE\nIf the actual workface, equipment, people, method, environment or another critical condition differs from the approved controls, stop the activity and reassess before continuing.',style:TextStyle(color:Color(0xFF4D432A),fontSize:15,height:1.5,fontWeight:FontWeight.w600)));
}

class DubaiPart1AdvancedData {
  static List<String> points(String id,String title,String summary){final specific=_specific[id]??const <String>[];final roles=_roles[id]??const <String>[];return [...specific,..._common(summary),...roles];}
  static List<String> _common(String summary)=>[summary,'Apply this information with the approved project HSE plan, task risk assessment, RAMS, permits where applicable, competent-person arrangements and current site conditions.','Field verification must test the actual workface rather than relying only on documents.','Identify the critical controls for this activity and confirm who owns each control.','Brief the workforce in a format they understand and confirm understanding before exposure begins.','Monitor changes in people, equipment, sequence, environment and interfaces and reassess when significant conditions change.','Record significant findings, assign corrective actions and verify that closure is effective.'];
  static const List<String> _construction_safety_framework=[
    "Advanced explanation: A practical framework for controlling construction HSE through clear responsibilities, planning, risk controls, field verification, contractor coordination and corrective action.",
    "Core elements: Project HSE governance, Roles and accountability, Work planning and RAMS, Contractor interface control, Field verification, Corrective action.",
    "Site application: translate what the framework is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from project hse governance, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _hse_management_system=[
    "Advanced explanation: A practical management-system reference covering HSE leadership, planning, implementation, monitoring, audit, reporting and continual improvement.",
    "Core elements: Leadership & commitment, HSE planning, Competence & communication, Operational control, Monitoring & audit, Continual improvement.",
    "Site application: translate what an hse management system is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from leadership & commitment, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _health_safety_risk_assessment=[
    "Advanced explanation: A practical risk-assessment reference covering hazard identification, risk evaluation, hierarchy of controls, dynamic assessment and critical-control verification.",
    "Core elements: Hazard identification, Risk evaluation, Hierarchy of controls, Dynamic assessment, Critical controls, Change management.",
    "Site application: translate what risk assessment is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from hazard identification, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _construction_hse_plan=[
    "Advanced explanation: A project-level HSE planning reference covering organization, RAMS, permits, competence, emergency preparedness, welfare, contractor control and performance monitoring.",
    "Core elements: Project scope & organization, RAMS & permit integration, Competence & training, Emergency preparedness, Welfare arrangements, Performance monitoring.",
    "Site application: translate what a construction hse plan is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from project scope & organization, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _work_at_height=[
    "Advanced explanation: A professional work-at-height reference covering access selection, fall prevention, fall protection, falling-object control, rescue planning and inspection.",
    "Core elements: Access system selection, Fall prevention, Fall protection, Falling-object control, Inspection, Rescue planning.",
    "Site application: translate what work at height is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from access system selection, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _scaffolding_safety=[
    "Advanced explanation: A practical scaffolding reference covering scaffold types, components, stability, access, inspection, tagging, modification and dismantling controls.",
    "Core elements: Scaffold types, Scaffold components, Foundation & stability, Platforms & edge protection, Inspection & tagging, Modification & dismantling.",
    "Site application: translate what scaffolding safety is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from scaffold types, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _lifting_operations=[
    "Advanced explanation: A professional practical reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution, emergency response and HSE responsibilities.",
    "Core elements: Lift planning, Lifting equipment & accessories, Rigging & load control, Crane setup, Communication & exclusion, Pre-lift verification.",
    "Site application: translate what lifting operations are into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from lift planning, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _excavation_trenching=[
    "Advanced explanation: A practical excavation reference covering excavation types, protective systems, underground services, access, water, spoil, plant interaction, inspection and emergency response.",
    "Core elements: Excavation types, Shoring / trench box, Benching / sloping, Underground services, Water & dewatering, Plant and spoil control.",
    "Site application: translate what excavation & trenching is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from excavation types, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _confined_space_entry=[
    "Advanced explanation: A practical confined-space reference covering entry decisions, permits, isolation, atmospheric testing, ventilation, communication, attendants and rescue.",
    "Core elements: Entry decision, Permit & isolation, Atmospheric testing, Ventilation, Communication & attendant, Rescue planning.",
    "Site application: translate what confined space entry is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from entry decision, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static const List<String> _electrical_safety=[
    "Advanced explanation: A practical electrical-safety reference covering energy identification, isolation and LOTO, temporary power, equipment inspection, work controls and emergency response.",
    "Core elements: Energy identification, Isolation & LOTO, Temporary power, Electrical equipment, Work near electrical systems, Emergency response.",
    "Site application: translate what electrical safety is into workface controls, assigned responsibilities and verification points.",
    "Main risk focus: identify hazards arising from energy identification, changing conditions, interfaces and ineffective controls.",
    "Critical-control verification: physically confirm the controls before exposure begins and continue checking them during the work.",
    "Change control: reassess when the method, location, sequence, personnel, equipment, weather or surrounding activity changes.",
    "Professional HSE approach: challenge assumptions, verify evidence, communicate clearly and escalate significant gaps promptly.",
  ];
  static final Map<String,List<String>> _specific={
    "dubai_construction_safety_framework": _construction_safety_framework,
    "dubai_hse_management_system": _hse_management_system,
    "dubai_health_safety_risk_assessment": _health_safety_risk_assessment,
    "dubai_construction_hse_plan": _construction_hse_plan,
    "dubai_work_at_height": _work_at_height,
    "dubai_scaffolding_safety": _scaffolding_safety,
    "dubai_lifting_operations": _lifting_operations,
    "dubai_excavation_trenching": _excavation_trenching,
    "dubai_confined_space_entry": _confined_space_entry,
    "dubai_electrical_safety": _electrical_safety,
  };
  static final Map<String,List<String>> _roles={
    "dubai_construction_safety_framework":[
      "HSE Officer \u2014 Dubai Construction Safety Framework: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Dubai Construction Safety Framework: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Dubai Construction Safety Framework: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Dubai Construction Safety Framework: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Dubai Construction Safety Framework: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Dubai Construction Safety Framework: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_hse_management_system":[
      "HSE Officer \u2014 HSE Management System: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 HSE Management System: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 HSE Management System: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 HSE Management System: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 HSE Management System: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 HSE Management System: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_health_safety_risk_assessment":[
      "HSE Officer \u2014 Health & Safety Risk Assessment: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Health & Safety Risk Assessment: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Health & Safety Risk Assessment: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Health & Safety Risk Assessment: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Health & Safety Risk Assessment: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Health & Safety Risk Assessment: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_construction_hse_plan":[
      "HSE Officer \u2014 Construction HSE Plan: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Construction HSE Plan: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Construction HSE Plan: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Construction HSE Plan: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Construction HSE Plan: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Construction HSE Plan: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_work_at_height":[
      "HSE Officer \u2014 Work at Height: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Work at Height: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Work at Height: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Work at Height: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Work at Height: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Work at Height: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_scaffolding_safety":[
      "HSE Officer \u2014 Scaffolding Safety: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Scaffolding Safety: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Scaffolding Safety: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Scaffolding Safety: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Scaffolding Safety: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Scaffolding Safety: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_lifting_operations":[
      "HSE Officer \u2014 Lifting Operations: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Lifting Operations: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Lifting Operations: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Lifting Operations: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Lifting Operations: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Lifting Operations: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_excavation_trenching":[
      "HSE Officer \u2014 Excavation & Trenching: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Excavation & Trenching: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Excavation & Trenching: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Excavation & Trenching: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Excavation & Trenching: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Excavation & Trenching: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_confined_space_entry":[
      "HSE Officer \u2014 Confined Space Entry: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Confined Space Entry: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Confined Space Entry: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Confined Space Entry: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Confined Space Entry: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Confined Space Entry: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
    "dubai_electrical_safety":[
      "HSE Officer \u2014 Electrical Safety: conduct field observations, verify critical controls and report unsafe conditions.",
      "HSE Supervisor \u2014 Electrical Safety: coordinate daily HSE supervision, briefings, corrective action and workface intervention.",
      "Senior HSE \u2014 Electrical Safety: provide assurance, challenge weak controls, review trends and escalate significant risks.",
      "HSE Coordinator \u2014 Electrical Safety: coordinate documents, contractor interfaces, actions, meetings and HSE records.",
      "HSE Engineer \u2014 Electrical Safety: review technical risk controls, interfaces, method changes and engineering-related safety concerns.",
      "HSE Manager \u2014 Electrical Safety: provide governance, resources, management assurance, escalation and continual improvement.",
    ],
  };
}
