import 'package:flutter/material.dart';
import 'models/reference_topic.dart';
import 'data/abu_dhabi_hse_topic_profiles.dart';

class AbuDhabiHseTopicPage extends StatelessWidget {
  final ReferenceTopic topic;
  const AbuDhabiHseTopicPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final profile=abuDhabiHseTopicProfiles[topic.id];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B5D4B),
        foregroundColor: Colors.white,
        title: Text(topic.shortTitle.isEmpty ? topic.title : topic.shortTitle),
      ),
      body: profile==null
        ? Center(child: Text(topic.title))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(topic.title, style: const TextStyle(fontSize:20,fontWeight:FontWeight.w900,color:Color(0xFF0B5D4B))),
                      const SizedBox(height:8),
                      Text(topic.description, style: const TextStyle(height:1.5)),
                      const SizedBox(height:12),
                      Wrap(spacing:8, children:[
                        _Tag(profile.cop), _Tag(profile.version), _Tag(profile.effectiveDate)
                      ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height:12),
              ...profile.sections.asMap().entries.map((e)=>_Section(number:e.key+1,text:e.value)),
              Card(
                color: const Color(0xFFEAF5EE),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Regulatory source: ADPHC, ADOSH-SF CoP 29.0 – Excavation Work, V4.1, February 2026. Verify the current official CoP and project-specific requirements before relying on a control.',
                    style: TextStyle(height:1.45),
                  ),
                ),
              ),
            ],
          ),
    );
  }
}

class _Section extends StatelessWidget {
  final int number; final String text;
  const _Section({required this.number,required this.text});
  @override Widget build(BuildContext context)=>Card(
    margin: const EdgeInsets.only(bottom:10),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
        CircleAvatar(radius:14,backgroundColor:const Color(0xFFEAF5EE),child:Text('$number',style:const TextStyle(fontSize:11,fontWeight:FontWeight.w800,color:Color(0xFF0B5D4B)))),
        const SizedBox(width:11),
        Expanded(child:Text(text,style:const TextStyle(fontSize:14,height:1.5))),
      ]),
    ),
  );
}

class _Tag extends StatelessWidget {
  final String text; const _Tag(this.text);
  @override Widget build(BuildContext context)=>Chip(label:Text(text,style:const TextStyle(fontSize:11,fontWeight:FontWeight.w700)));
}
