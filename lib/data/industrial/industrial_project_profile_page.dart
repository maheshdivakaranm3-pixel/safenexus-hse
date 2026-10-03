import 'package:flutter/material.dart';
import 'industrial_document_storage.dart';

class IndustrialProjectProfilePage extends StatefulWidget {
  const IndustrialProjectProfilePage({super.key});
  @override State<IndustrialProjectProfilePage> createState() => _IndustrialProjectProfilePageState();
}
class _IndustrialProjectProfilePageState extends State<IndustrialProjectProfilePage> {
  static const labels = ['Company / Contractor Name','Client Name','Consultant Name','Project Name','Project / Contract Number','Project Location','Default Prepared By','Default HSE Reviewer'];
  final c = <String,TextEditingController>{}; bool loading = true;
  @override void initState(){super.initState(); _load();}
  Future<void> _load() async { final p=await IndustrialDocumentStorage.loadProfile(); for(final l in labels){c[l]=TextEditingController(text:p[l]??'');} if(mounted)setState(()=>loading=false); }
  Future<void> _save() async { await IndustrialDocumentStorage.saveProfile({for(final e in c.entries)e.key:e.value.text}); if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Project profile saved. New documents will use this profile. Existing document snapshots remain unchanged.'))); }
  @override void dispose(){for(final x in c.values){x.dispose();}super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Industrial Project Profile'),backgroundColor:const Color(0xFF0B6B4B),foregroundColor:Colors.white,actions:[IconButton(onPressed:loading?null:_save,icon:const Icon(Icons.save))]),body:loading?const Center(child:CircularProgressIndicator()):ListView(padding:const EdgeInsets.all(16),children:[const Text('Enter project identity once. Each new document stores a snapshot; editing this profile will not rewrite saved records.',style:TextStyle(height:1.4)),const SizedBox(height:16),...labels.map((l)=>Padding(padding:const EdgeInsets.only(bottom:12),child:TextField(controller:c[l],decoration:InputDecoration(labelText:l,border:const OutlineInputBorder())))),FilledButton.icon(onPressed:_save,icon:const Icon(Icons.save),label:const Text('Save Project Profile'))]));
}
