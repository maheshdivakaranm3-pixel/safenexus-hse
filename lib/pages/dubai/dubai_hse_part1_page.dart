import 'package:flutter/material.dart';
import 'dubai_hse_part1_advanced_learning_page.dart';

// SAFE NEXUS HSE — Dubai HSE Part 1 / Topics 1–10
// Same structure and interaction pattern as Lifting Operations.
// Main topic → section → small > → Advanced Learning.

class DubaiPart1Item {
  final String title; final String detail;
  const DubaiPart1Item({required this.title, required this.detail});
}

class DubaiPart1Section {
  final String title; final String content; final List<DubaiPart1Item> items; final bool initiallyExpanded;
  const DubaiPart1Section({required this.title, required this.content, this.items = const [], this.initiallyExpanded = false});
}

class DubaiHsePart1TopicPage extends StatelessWidget {
  final String topicId;
  const DubaiHsePart1TopicPage({super.key, required this.topicId});
  DubaiPart1Topic get topic => DubaiPart1Data.topic(topicId);
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF5F8F7),
    appBar: AppBar(backgroundColor: const Color(0xFFEAF4F0), foregroundColor: const Color(0xFF17231F), elevation: 0, title: Text(topic.title, maxLines: 1, overflow: TextOverflow.ellipsis)),
    body: ListView(padding: const EdgeInsets.fromLTRB(16,16,16,32), children:[_HeaderCard(title:topic.title,subtitle:topic.subtitle,description:topic.description,icon:topic.icon),const SizedBox(height:14),...topic.sections.map((s)=>_SectionCard(section:s,topicId:topic.id,topicTitle:topic.title))]),
  );
}

class _HeaderCard extends StatelessWidget {
  final String title, subtitle, description; final IconData icon;
  const _HeaderCard({required this.title,required this.subtitle,required this.description,required this.icon});
  @override Widget build(BuildContext context)=>Card(elevation:2,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(22)),child:Container(padding:const EdgeInsets.all(20),decoration:BoxDecoration(borderRadius:BorderRadius.circular(22),gradient:const LinearGradient(colors:[Color(0xFFE8F6F0),Color(0xFFF8FBFA)])),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[Container(width:58,height:58,decoration:BoxDecoration(color:const Color(0xFF0B7653),borderRadius:BorderRadius.circular(17)),child:Icon(icon,color:Colors.white,size:31)),const SizedBox(width:14),Expanded(child:Text(title,style:const TextStyle(fontSize:27,height:1.12,fontWeight:FontWeight.w800,color:Color(0xFF10231D))))]),
    const SizedBox(height:14),Text(subtitle.toUpperCase(),style:const TextStyle(fontSize:13,fontWeight:FontWeight.w800,letterSpacing:.5,color:Color(0xFF075C45))),const SizedBox(height:10),Text(description,style:const TextStyle(fontSize:16,height:1.5)),
  ])));
}

class _SectionCard extends StatelessWidget {
  final DubaiPart1Section section; final String topicId, topicTitle;
  const _SectionCard({required this.section,required this.topicId,required this.topicTitle});
  @override Widget build(BuildContext context)=>Card(margin:const EdgeInsets.only(bottom:12),elevation:1.5,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(19)),clipBehavior:Clip.antiAlias,child:ExpansionTile(initiallyExpanded:section.initiallyExpanded,tilePadding:const EdgeInsets.symmetric(horizontal:18,vertical:5),childrenPadding:const EdgeInsets.fromLTRB(16,0,16,17),iconColor:const Color(0xFF237A5C),title:Text(section.title,style:const TextStyle(fontSize:19,fontWeight:FontWeight.w800)),children:[
    if(section.content.trim().isNotEmpty) Padding(padding:const EdgeInsets.fromLTRB(4,0,4,12),child:Text(section.content,style:const TextStyle(fontSize:15.5,height:1.5))),
    ...section.items.map((item)=>_ItemTile(topicId:topicId,topicTitle:topicTitle,item:item)),
  ]));
}

class _ItemTile extends StatelessWidget {
  final String topicId, topicTitle; final DubaiPart1Item item;
  const _ItemTile({required this.topicId,required this.topicTitle,required this.item});
  @override Widget build(BuildContext context)=>Card(margin:const EdgeInsets.only(bottom:8),elevation:0,color:const Color(0xFFF4F8F6),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(14),side:const BorderSide(color:Color(0xFFD7E7E0))),child:InkWell(borderRadius:BorderRadius.circular(14),onTap:()=>Navigator.of(context).push(MaterialPageRoute(builder:(_)=>DubaiHsePart1AdvancedLearningPage(topicId:topicId,title:item.title,summary:item.detail,topicTitle:topicTitle))),child:Padding(padding:const EdgeInsets.fromLTRB(18,15,12,15),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(item.title,style:const TextStyle(fontSize:16.5,fontWeight:FontWeight.w800,color:Color(0xFF17332A))),const SizedBox(height:6),Text(item.detail,style:const TextStyle(fontSize:14.5,height:1.45,color:Color(0xFF465650)))])),const SizedBox(width:8),const Icon(Icons.chevron_right_rounded,size:25,color:Color(0xFF4D5A55))]))));
}

class DubaiPart1Topic {
  final String id,title,subtitle,description,introTitle,introText; final IconData icon; final List<DubaiPart1Section> sections;
  const DubaiPart1Topic({required this.id,required this.title,required this.subtitle,required this.description,required this.introTitle,required this.introText,required this.icon,required this.sections});
}

class DubaiPart1Data {
  static DubaiPart1Topic topic(String id)=>_topics[id]??_topics.values.first;
  static final Map<String,DubaiPart1Topic> _topics={
    "dubai_construction_safety_framework": DubaiPart1Topic(id:"dubai_construction_safety_framework",title:"Dubai Construction Safety Framework",subtitle:"BUILD SAFE \u2022 CONTROL RISK \u2022 VERIFY EVERY WORKFACE",description:"A practical framework for controlling construction HSE through clear responsibilities, planning, risk controls, field verification, contractor coordination and corrective action.",introTitle:"What the framework is",introText:"The construction safety framework establishes how project leadership, consultants, contractors, supervisors and workers coordinate to prevent harm and control high-risk construction activities.",icon:Icons.account_balance_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What the framework is",content:"The construction safety framework establishes how project leadership, consultants, contractors, supervisors and workers coordinate to prevent harm and control high-risk construction activities.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Project HSE governance",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Roles and accountability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Work planning and RAMS",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Work planning and RAMS",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Contractor interface control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Field verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Field verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Corrective action",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Project HSE governance",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Project HSE governance",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Roles and accountability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Work planning and RAMS",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Work planning and RAMS",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Contractor interface control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Field verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Field verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Corrective action",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Project HSE governance",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_hse_management_system": DubaiPart1Topic(id:"dubai_hse_management_system",title:"HSE Management System",subtitle:"PLAN \u2022 IMPLEMENT \u2022 ASSURE \u2022 IMPROVE",description:"A practical management-system reference covering HSE leadership, planning, implementation, monitoring, audit, reporting and continual improvement.",introTitle:"What an HSE Management System is",introText:"An HSE management system connects leadership commitments with risk-based planning, competent people, controlled documents, field implementation, assurance and improvement.",icon:Icons.manage_accounts_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What an HSE Management System is",content:"An HSE management system connects leadership commitments with risk-based planning, competent people, controlled documents, field implementation, assurance and improvement.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Leadership & commitment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"HSE planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Competence & communication",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Competence & communication",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Operational control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Monitoring & audit",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Monitoring & audit",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Continual improvement",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Leadership & commitment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Leadership & commitment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"HSE planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Competence & communication",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Competence & communication",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Operational control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Monitoring & audit",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Monitoring & audit",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Continual improvement",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Leadership & commitment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_health_safety_risk_assessment": DubaiPart1Topic(id:"dubai_health_safety_risk_assessment",title:"Health & Safety Risk Assessment",subtitle:"IDENTIFY \u2022 ASSESS \u2022 CONTROL \u2022 VERIFY",description:"A practical risk-assessment reference covering hazard identification, risk evaluation, hierarchy of controls, dynamic assessment and critical-control verification.",introTitle:"What Risk Assessment is",introText:"Risk assessment is a structured process used to identify hazards, evaluate risk, select effective controls and verify that those controls remain suitable as work conditions change.",icon:Icons.assessment_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Risk Assessment is",content:"Risk assessment is a structured process used to identify hazards, evaluate risk, select effective controls and verify that those controls remain suitable as work conditions change.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Hazard identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Risk evaluation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Hierarchy of controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Hierarchy of controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Dynamic assessment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Critical controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Critical controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Change management",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Hazard identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Hazard identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Risk evaluation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Hierarchy of controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Hierarchy of controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Dynamic assessment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Critical controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Critical controls",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Change management",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Hazard identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_construction_hse_plan": DubaiPart1Topic(id:"dubai_construction_hse_plan",title:"Construction HSE Plan",subtitle:"PLAN THE PROJECT \u2022 CONTROL THE WORK \u2022 ASSURE DELIVERY",description:"A project-level HSE planning reference covering organization, RAMS, permits, competence, emergency preparedness, welfare, contractor control and performance monitoring.",introTitle:"What a Construction HSE Plan is",introText:"A construction HSE plan defines how HSE will be organized and implemented throughout the project and how task-level controls connect to the project management system.",icon:Icons.description_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What a Construction HSE Plan is",content:"A construction HSE plan defines how HSE will be organized and implemented throughout the project and how task-level controls connect to the project management system.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Project scope & organization",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"RAMS & permit integration",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Competence & training",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Competence & training",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Emergency preparedness",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Welfare arrangements",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Welfare arrangements",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Performance monitoring",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Project scope & organization",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Project scope & organization",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"RAMS & permit integration",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Competence & training",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Competence & training",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Emergency preparedness",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Welfare arrangements",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Welfare arrangements",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Performance monitoring",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Project scope & organization",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_work_at_height": DubaiPart1Topic(id:"dubai_work_at_height",title:"Work at Height",subtitle:"PREVENT THE FALL \u2022 PROTECT PEOPLE \u2022 CONTROL OBJECTS",description:"A professional work-at-height reference covering access selection, fall prevention, fall protection, falling-object control, rescue planning and inspection.",introTitle:"What Work at Height is",introText:"Work at height is any work where a person could fall a distance liable to cause injury. The preferred approach is to prevent falls using suitable access and collective protection.",icon:Icons.height_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Work at Height is",content:"Work at height is any work where a person could fall a distance liable to cause injury. The preferred approach is to prevent falls using suitable access and collective protection.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Access system selection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Fall prevention",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Fall protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Fall protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Falling-object control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Inspection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Inspection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rescue planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Access system selection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Access system selection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Fall prevention",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Fall protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Fall protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Falling-object control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Inspection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Inspection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rescue planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Access system selection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_scaffolding_safety": DubaiPart1Topic(id:"dubai_scaffolding_safety",title:"Scaffolding Safety",subtitle:"BUILD STABLE \u2022 ACCESS SAFE \u2022 INSPECT BEFORE USE",description:"A practical scaffolding reference covering scaffold types, components, stability, access, inspection, tagging, modification and dismantling controls.",introTitle:"What Scaffolding Safety is",introText:"Scaffolding provides temporary access and working platforms. Safe use depends on suitable design or configuration, stable support, competent erection, inspection and controlled modification.",icon:Icons.construction_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Scaffolding Safety is",content:"Scaffolding provides temporary access and working platforms. Safe use depends on suitable design or configuration, stable support, competent erection, inspection and controlled modification.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Scaffold types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Scaffold components",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Foundation & stability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Foundation & stability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Platforms & edge protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Inspection & tagging",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Inspection & tagging",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Modification & dismantling",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Scaffold types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Scaffold types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Scaffold components",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Foundation & stability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Foundation & stability",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Platforms & edge protection",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Inspection & tagging",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Inspection & tagging",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Modification & dismantling",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Scaffold types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_lifting_operations": DubaiPart1Topic(id:"dubai_lifting_operations",title:"Lifting Operations",subtitle:"PLAN SAFE \u2022 LIFT SAFE \u2022 CONTROL EVERY MOVEMENT",description:"A professional practical reference covering lifting planning, equipment, rigging, competent roles, hazards, controls, inspection, execution, emergency response and HSE responsibilities.",introTitle:"What Lifting Operations are",introText:"A lifting operation raises, lowers, moves or positions a load using a crane, hoist or other lifting appliance. Safe lifting depends on planning, suitable equipment, competent personnel and load-path control.",icon:Icons.engineering_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Lifting Operations are",content:"A lifting operation raises, lowers, moves or positions a load using a crane, hoist or other lifting appliance. Safe lifting depends on planning, suitable equipment, competent personnel and load-path control.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Lift planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Lifting equipment & accessories",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rigging & load control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Rigging & load control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Crane setup",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Communication & exclusion",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Communication & exclusion",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Pre-lift verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Lift planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Lift planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Lifting equipment & accessories",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rigging & load control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Rigging & load control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Crane setup",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Communication & exclusion",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Communication & exclusion",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Pre-lift verification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Lift planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_excavation_trenching": DubaiPart1Topic(id:"dubai_excavation_trenching",title:"Excavation & Trenching",subtitle:"PROTECT THE EXCAVATION \u2022 CONTROL THE EDGE \u2022 VERIFY BEFORE ENTRY",description:"A practical excavation reference covering excavation types, protective systems, underground services, access, water, spoil, plant interaction, inspection and emergency response.",introTitle:"What Excavation & Trenching is",introText:"Excavation work creates ground openings and temporary changes in ground stability. Safe work requires suitable planning, protection, access, service identification and competent inspection.",icon:Icons.terrain_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Excavation & Trenching is",content:"Excavation work creates ground openings and temporary changes in ground stability. Safe work requires suitable planning, protection, access, service identification and competent inspection.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Excavation types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Shoring / trench box",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Benching / sloping",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Benching / sloping",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Underground services",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Water & dewatering",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Water & dewatering",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Plant and spoil control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Excavation types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Excavation types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Shoring / trench box",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Benching / sloping",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Benching / sloping",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Underground services",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Water & dewatering",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Water & dewatering",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Plant and spoil control",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Excavation types",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_confined_space_entry": DubaiPart1Topic(id:"dubai_confined_space_entry",title:"Confined Space Entry",subtitle:"ASSESS \u2022 ISOLATE \u2022 TEST \u2022 CONTROL \u2022 RESCUE",description:"A practical confined-space reference covering entry decisions, permits, isolation, atmospheric testing, ventilation, communication, attendants and rescue.",introTitle:"What Confined Space Entry is",introText:"Confined-space entry involves entering an enclosed or partially enclosed space where serious hazards may arise from atmosphere, engulfment, energy, access or other conditions.",icon:Icons.airline_seat_flat_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Confined Space Entry is",content:"Confined-space entry involves entering an enclosed or partially enclosed space where serious hazards may arise from atmosphere, engulfment, energy, access or other conditions.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Entry decision",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Permit & isolation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Atmospheric testing",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Atmospheric testing",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Ventilation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Communication & attendant",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Communication & attendant",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rescue planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Entry decision",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Entry decision",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Permit & isolation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Atmospheric testing",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Atmospheric testing",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Ventilation",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Communication & attendant",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Communication & attendant",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Rescue planning",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Entry decision",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
    "dubai_electrical_safety": DubaiPart1Topic(id:"dubai_electrical_safety",title:"Electrical Safety",subtitle:"ISOLATE \u2022 VERIFY \u2022 PROTECT \u2022 CONTROL",description:"A practical electrical-safety reference covering energy identification, isolation and LOTO, temporary power, equipment inspection, work controls and emergency response.",introTitle:"What Electrical Safety is",introText:"Electrical safety controls exposure to electrical energy through identification, isolation, verification, suitable equipment, controlled access and competent work practices.",icon:Icons.electrical_services_rounded,sections:[
      DubaiPart1Section(title:"1. Introduction \u2014 What Electrical Safety is",content:"Electrical safety controls exposure to electrical energy through identification, isolation, verification, suitable equipment, controlled access and competent work practices.",items:[
        DubaiPart1Item(title:'Purpose & Scope',detail:'Understand the purpose, scope and practical application of this HSE topic before work begins.'),
        DubaiPart1Item(title:'Safe Work Principle',detail:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.'),
      ],initiallyExpanded:true),
      DubaiPart1Section(title:"2. Types / Systems",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Energy identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Isolation & LOTO",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Temporary power",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"3. Components / Key Elements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Temporary power",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Electrical equipment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Work near electrical systems",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"4. Technical Requirements",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Work near electrical systems",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Emergency response",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Energy identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"5. Planning & Risk Control",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Energy identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Isolation & LOTO",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Temporary power",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"6. Main Hazards",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Temporary power",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Electrical equipment",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Work near electrical systems",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"7. Safety Controls",content:'Select the appropriate arrangement and verify that it matches the task, site conditions, approved controls and competent-person requirements.',items:[
        DubaiPart1Item(title:"Work near electrical systems",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Emergency response",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
        DubaiPart1Item(title:"Energy identification",detail:'Tap for advanced learning: application, hazards, controls, field verification and professional HSE guidance.'),
      ]),
      DubaiPart1Section(title:"8. Inspection & Verification",content:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity.",items:[DubaiPart1Item(title:"Inspection & Verification",detail:"Verify the condition, status, implementation and effectiveness of critical controls before and during the activity. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"9. Stop-Work Conditions",content:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method.",items:[DubaiPart1Item(title:"Stop-Work Conditions",detail:"Stop when a critical control is missing, ineffective, misunderstood or materially different from the approved method. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"10. Competent Person / Operational Responsibilities",content:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities.",items:[DubaiPart1Item(title:"Competent Person / Operational Responsibilities",detail:"Confirm the correct competent and authorized personnel are assigned and understand their responsibilities. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"11. Emergency Response",content:"Emergency arrangements must be practical, communicated and available before the activity starts.",items:[DubaiPart1Item(title:"Emergency Response",detail:"Emergency arrangements must be practical, communicated and available before the activity starts. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:"12. Practical Site Example",content:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions.",items:[DubaiPart1Item(title:"Practical Site Example",detail:"Use the topic controls on a realistic workface scenario and compare the planned method with actual site conditions. Tap for advanced topic-specific guidance.")]),
      DubaiPart1Section(title:'13. Quick Learning Formula',content:'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',items:[DubaiPart1Item(title:'Field Learning Formula',detail:'Use the sequence to test whether the work is genuinely controlled, not merely documented.')]),
      DubaiPart1Section(title:'🦺 HSE Roles — Topic-wise Responsibilities',content:'Responsibilities are consolidated at the end, following the Lifting Operations pattern.',items:[
        DubaiPart1Item(title:"HSE Officer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Supervisor",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"Senior HSE",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Coordinator",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Engineer",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
        DubaiPart1Item(title:"HSE Manager",detail:'Topic-specific responsibility for this HSE subject. Tap for advanced role guidance.'),
      ]),
    ]),
  };
}
