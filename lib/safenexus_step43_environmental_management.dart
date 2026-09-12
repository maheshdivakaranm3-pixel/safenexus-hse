import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 43
/// HSE Environmental Management Center
///
/// Workflow:
/// Identify → Assess → Control → Monitor → Inspect → Correct → Verify → Comply → Analyze
///
/// Integration:
/// Step 9 Daily HSE → Step 31 Smart Checklists → Step 32 Field Operations
/// → Step 34 Documents & Records → Step 35 Action Center → Step 36 Risk & Control
/// → Step 37 RAMS → Step 38 PTW → Step 39 Workforce & Competency
/// → Step 40 Equipment & Assets → Step 41 Inspection & Certification
/// → Step 42 Emergency Preparedness & Response
///
/// No new dependency beyond SharedPreferences.

class SafeNexusStep43EnvironmentalManagementPage extends StatefulWidget {
  const SafeNexusStep43EnvironmentalManagementPage({super.key, this.sourceOpener});
  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep43EnvironmentalManagementPage> createState() =>
      _SafeNexusStep43EnvironmentalManagementPageState();
}

class _SafeNexusStep43EnvironmentalManagementPageState
    extends State<SafeNexusStep43EnvironmentalManagementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_step43_environmental_management';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _environmentalTypes = const [
    'Environmental Aspect / Impact','Waste Management','Hazardous Waste',
    'Air / Emission Monitoring','Noise Monitoring','Water Management',
    'Effluent / Discharge','Spill Prevention','Spill Response',
    'Environmental Inspection','Environmental Compliance','Environmental Permit',
    'Energy / Resource Efficiency','Biodiversity / Ecology',
    'Marine / Coastal Environment','Other',
  ];
  final List<String> _statuses = const [
    'Planned','Active','Monitoring','Inspection Required','Non-Compliant',
    'Corrective Action Required','Verified','Compliant','Closed',
  ];
  final List<String> _severityOptions = const ['Low','Medium','High','Critical'];
  final List<String> _complianceOptions = const [
    'Not Assessed','Compliant','Partially Compliant','Non-Compliant','Not Applicable',
  ];
  final List<String> _wasteOptions = const [
    'Not Applicable','General Waste','Recyclable Waste','Hazardous Waste',
    'Chemical Waste','Oil / Used Oil','Contaminated Material','E-Waste',
    'Construction Waste','Other',
  ];
  final List<String> _monitoringOptions = const [
    'Not Required','Pending','Within Limit','Action Required','Over Limit',
  ];

  List<Map<String,dynamic>> _records = [];
  List<Map<String,dynamic>> _history = [];
  String _statusFilter='All', _typeFilter='All', _severityFilter='All', _complianceFilter='All';
  bool _loading=true;

  @override
  void initState() { super.initState(); _searchController.addListener(_refreshView); _loadData(); }
  @override
  void dispose() { _searchController..removeListener(_refreshView)..dispose(); super.dispose(); }

  Future<void> _loadData() async {
    final p=await SharedPreferences.getInstance();
    if(!mounted)return;
    setState((){_records=_decode(p.getString(storageKey));_history=_decode(p.getString('${storageKey}_history'));_loading=false;});
  }
  List<Map<String,dynamic>> _decode(String? raw){
    if(raw==null||raw.isEmpty)return [];
    try{final d=jsonDecode(raw);if(d is List)return d.whereType<Map>().map((e)=>Map<String,dynamic>.from(e)).toList();}catch(_){}
    return [];
  }
  Future<void> _save() async {
    final p=await SharedPreferences.getInstance();
    await p.setString(storageKey,jsonEncode(_records));
    await p.setString('${storageKey}_history',jsonEncode(_history));
  }
  void _refreshView(){if(mounted)setState((){});}
  String _v(Map<String,dynamic> r,String k)=>r[k]==null?'':'${r[k]}';
  DateTime? _date(dynamic v)=>v==null?null:DateTime.tryParse('$v');
  String _now()=>DateTime.now().toIso8601String();
  String _id()=>'ENV43-${DateTime.now().millisecondsSinceEpoch}';
  int _count(bool Function(Map<String,dynamic>) f)=>_records.where(f).length;
  int get _total=>_records.length;
  int get _active=>_count((r)=>['Active','Monitoring','Inspection Required'].contains(_v(r,'status')));
  int get _nonCompliant=>_count((r)=>_v(r,'compliance')=='Non-Compliant');
  int get _actions=>_count((r)=>_v(r,'status')=='Corrective Action Required');
  int get _compliant=>_count((r)=>_v(r,'compliance')=='Compliant');
  int get _hazardous=>_count((r)=>_v(r,'wasteType')=='Hazardous Waste');
  int get _monitorAction=>_count((r)=>['Action Required','Over Limit'].contains(_v(r,'monitoringStatus')));
  int get _critical=>_count((r)=>_v(r,'severity')=='Critical');
  int get _overdue=>_count((r)=>_due(r)=='Overdue');

  String _due(Map<String,dynamic> r){
    final d=_date(r['nextReviewDate']);if(d==null)return 'Not Scheduled';
    final n=DateTime.now(),x=DateTime(d.year,d.month,d.day),t=DateTime(n.year,n.month,n.day);
    final days=x.difference(t).inDays;
    if(days<0)return 'Overdue';if(days<=30)return 'Due Soon';return 'Scheduled';
  }

  List<Map<String,dynamic>> get _filtered {
    final q=_searchController.text.trim().toLowerCase();
    return _records.where((r){
      final s=[_v(r,'environmentId'),_v(r,'title'),_v(r,'environmentalType'),_v(r,'site'),
        _v(r,'owner'),_v(r,'permitReference'),_v(r,'wasteType')].join(' ').toLowerCase();
      return (q.isEmpty||s.contains(q))&&(_statusFilter=='All'||_v(r,'status')==_statusFilter)&&
        (_typeFilter=='All'||_v(r,'environmentalType')==_typeFilter)&&
        (_severityFilter=='All'||_v(r,'severity')==_severityFilter)&&
        (_complianceFilter=='All'||_v(r,'compliance')==_complianceFilter);
    }).toList();
  }

  Future<void> _add() async {
    final x=await _dialog();if(x==null)return;
    final r=<String,dynamic>{...x,'environmentId':_id(),'createdAt':_now(),'updatedAt':_now()};
    setState(()=>{_records.insert(0,r),_history.insert(0,{'action':'Created','environmentId':r['environmentId'],'title':r['title'],'timestamp':_now(),'details':'Environmental management record created.'})});
    await _save();
  }
  Future<void> _edit(Map<String,dynamic> r) async {
    final x=await _dialog(existing:r);if(x==null)return;
    final i=_records.indexWhere((e)=>_v(e,'environmentId')==_v(r,'environmentId'));if(i<0)return;
    final u=<String,dynamic>{...r,...x,'updatedAt':_now()};
    setState(()=>{_records[i]=u,_history.insert(0,{'action':'Updated','environmentId':u['environmentId'],'title':u['title'],'timestamp':_now(),'details':'Environmental management record updated.'})});
    await _save();
  }
  Future<void> _delete(Map<String,dynamic> r) async {
    final ok=await showDialog<bool>(context:context,builder:(c)=>AlertDialog(
      title:const Text('Delete Environmental Record'),
      content:Text('Delete ${_v(r,'title')} (${_v(r,'environmentId')})?'),
      actions:[TextButton(onPressed:()=>Navigator.pop(c,false),child:const Text('Cancel')),
        FilledButton(onPressed:()=>Navigator.pop(c,true),child:const Text('Delete'))]));
    if(ok!=true)return;
    setState(()=>{_records.removeWhere((e)=>_v(e,'environmentId')==_v(r,'environmentId')),
      _history.insert(0,{'action':'Deleted','environmentId':r['environmentId'],'title':r['title'],'timestamp':_now(),'details':'Environmental management record deleted.'})});
    await _save();
  }

  Future<Map<String,dynamic>?> _dialog({Map<String,dynamic>? existing}) async {
    final cs=<String,TextEditingController>{
      'title':TextEditingController(text:_v(existing??{},'title')),
      'site':TextEditingController(text:_v(existing??{},'site')),
      'owner':TextEditingController(text:_v(existing??{},'owner')),
      'permitReference':TextEditingController(text:_v(existing??{},'permitReference')),
      'nextReviewDate':TextEditingController(text:_v(existing??{},'nextReviewDate')),
      'aspect':TextEditingController(text:_v(existing??{},'aspect')),
      'impact':TextEditingController(text:_v(existing??{},'impact')),
      'controls':TextEditingController(text:_v(existing??{},'controls')),
      'monitoring':TextEditingController(text:_v(existing??{},'monitoring')),
      'quantity':TextEditingController(text:_v(existing??{},'quantity')),
      'unit':TextEditingController(text:_v(existing??{},'unit')),
      'correctiveAction':TextEditingController(text:_v(existing??{},'correctiveAction')),
      'notes':TextEditingController(text:_v(existing??{},'notes')),
    };
    String type=_v(existing??{},'environmentalType'),status=_v(existing??{},'status'),severity=_v(existing??{},'severity'),
      compliance=_v(existing??{},'compliance'),waste=_v(existing??{},'wasteType'),monitor=_v(existing??{},'monitoringStatus');
    if(!_environmentalTypes.contains(type))type=_environmentalTypes.first;
    if(!_statuses.contains(status))status=_statuses.first;
    if(!_severityOptions.contains(severity))severity='Low';
    if(!_complianceOptions.contains(compliance))compliance='Not Assessed';
    if(!_wasteOptions.contains(waste))waste='Not Applicable';
    if(!_monitoringOptions.contains(monitor))monitor='Not Required';

    final result=await showDialog<Map<String,dynamic>>(context:context,builder:(dc)=>StatefulBuilder(
      builder:(context,setD)=>AlertDialog(
        title:Text(existing==null?'Create Environmental Record':'Edit Environmental Record'),
        content:SizedBox(width:680,child:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[
          _field(cs['title']!,'Environmental Record Title',Icons.eco_outlined,true),
          const SizedBox(height:10),_drop('Environmental Type',type,_environmentalTypes,(v)=>setD(()=>type=v!)),
          const SizedBox(height:10),Row(children:[
            Expanded(child:_field(cs['site']!,'Site / Location',Icons.location_on_outlined,true)),
            const SizedBox(width:10),Expanded(child:_field(cs['owner']!,'Environmental Owner',Icons.person_outline,true))]),
          const SizedBox(height:10),Row(children:[
            Expanded(child:_drop('Status',status,_statuses,(v)=>setD(()=>status=v!))),
            const SizedBox(width:10),Expanded(child:_drop('Severity',severity,_severityOptions,(v)=>setD(()=>severity=v!)))]),
          const SizedBox(height:10),Row(children:[
            Expanded(child:_drop('Compliance',compliance,_complianceOptions,(v)=>setD(()=>compliance=v!))),
            const SizedBox(width:10),Expanded(child:_drop('Monitoring Status',monitor,_monitoringOptions,(v)=>setD(()=>monitor=v!)))]),
          const SizedBox(height:10),_drop('Waste Type',waste,_wasteOptions,(v)=>setD(()=>waste=v!)),
          const SizedBox(height:10),Row(children:[
            Expanded(child:_field(cs['quantity']!,'Quantity / Reading',Icons.scale_outlined)),
            const SizedBox(width:10),Expanded(child:_field(cs['unit']!,'Unit',Icons.straighten_outlined))]),
          const SizedBox(height:10),_field(cs['permitReference']!,'Environmental Permit / Legal Reference',Icons.gavel_outlined),
          const SizedBox(height:10),_field(cs['nextReviewDate']!,'Next Review / Monitoring (YYYY-MM-DD)',Icons.event_available_outlined),
          const SizedBox(height:10),_field(cs['aspect']!,'Environmental Aspect / Source',Icons.category_outlined,false,2),
          const SizedBox(height:10),_field(cs['impact']!,'Environmental Impact / Risk',Icons.warning_amber_outlined,false,3),
          const SizedBox(height:10),_field(cs['controls']!,'Control Measures',Icons.shield_outlined,false,3),
          const SizedBox(height:10),_field(cs['monitoring']!,'Monitoring Details / Results',Icons.monitor_heart_outlined,false,3),
          const SizedBox(height:10),_field(cs['correctiveAction']!,'Corrective / Preventive Action',Icons.build_circle_outlined,false,3),
          const SizedBox(height:10),_field(cs['notes']!,'Environmental / HSE Notes',Icons.notes_outlined,false,3),
        ]))),
        actions:[TextButton(onPressed:()=>Navigator.pop(dc),child:const Text('Cancel')),
          FilledButton.icon(onPressed:(){
            if(cs['title']!.text.trim().isEmpty||cs['site']!.text.trim().isEmpty||cs['owner']!.text.trim().isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Title, Site and Environmental Owner are required.')));return;
            }
            Navigator.pop(dc,{
              'title':cs['title']!.text.trim(),'environmentalType':type,'site':cs['site']!.text.trim(),
              'owner':cs['owner']!.text.trim(),'status':status,'severity':severity,'compliance':compliance,
              'wasteType':waste,'monitoringStatus':monitor,'quantity':cs['quantity']!.text.trim(),'unit':cs['unit']!.text.trim(),
              'permitReference':cs['permitReference']!.text.trim(),'nextReviewDate':cs['nextReviewDate']!.text.trim(),
              'aspect':cs['aspect']!.text.trim(),'impact':cs['impact']!.text.trim(),'controls':cs['controls']!.text.trim(),
              'monitoring':cs['monitoring']!.text.trim(),'correctiveAction':cs['correctiveAction']!.text.trim(),
              'notes':cs['notes']!.text.trim(),
            });
          },icon:const Icon(Icons.save_outlined),label:Text(existing==null?'Create':'Save'))]
      )));
    for(final c in cs.values)c.dispose();
    return result;
  }

  Widget _field(TextEditingController c,String label,IconData icon,[bool required=false,int maxLines=1])=>TextField(
    controller:c,maxLines:maxLines,decoration:InputDecoration(labelText:required?'$label *':label,prefixIcon:Icon(icon),border:const OutlineInputBorder()));
  Widget _drop(String label,String value,List<String> items,ValueChanged<String?> onChanged)=>DropdownButtonFormField<String>(
    initialValue:value,isExpanded:true,decoration:InputDecoration(labelText:label,border:const OutlineInputBorder()),
    items:items.map((x)=>DropdownMenuItem<String>(value:x,child:Text(x,overflow:TextOverflow.ellipsis))).toList(),onChanged:onChanged);

  Widget _chip(String x)=>Chip(label:Text(x.isEmpty?'-':x),visualDensity:VisualDensity.compact);
  Widget _cardMetric(String title,String value,IconData icon)=>Card(elevation:0,child:Padding(padding:const EdgeInsets.all(14),child:Row(children:[
    CircleAvatar(backgroundColor:primaryGreen.withValues(alpha:0.10),child:Icon(icon,color:darkGreen)),const SizedBox(width:12),
    Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Text(value,style:const TextStyle(fontSize:21,fontWeight:FontWeight.w800,color:darkGreen)),
      Text(title,style:const TextStyle(fontSize:12))]))]));
  Widget _dashboard()=>Card(elevation:0,child:Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const Text('43L — Environmental Intelligence Dashboard',style:TextStyle(fontSize:17,fontWeight:FontWeight.w800,color:darkGreen)),
    const SizedBox(height:4),const Text('Identify → Assess → Control → Monitor → Inspect → Correct → Verify'),
    const SizedBox(height:12),LayoutBuilder(builder:(context,c){
      final n=c.maxWidth>850?4:c.maxWidth>560?3:2,w=(c.maxWidth-((n-1)*10))/n;
      final a=<List<dynamic>>[
        ['Total Records','$_total',Icons.eco_outlined],['Active / Monitoring','$_active',Icons.monitor_heart_outlined],
        ['Compliant','$_compliant',Icons.check_circle_outline],['Non-Compliant','$_nonCompliant',Icons.warning_amber_outlined],
        ['Action Required','$_actions',Icons.assignment_late_outlined],['Hazardous Waste','$_hazardous',Icons.delete_sweep_outlined],
        ['Monitoring Action','$_monitorAction',Icons.analytics_outlined],['Critical','$_critical',Icons.priority_high_outlined],
        ['Review Overdue','$_overdue',Icons.event_busy_outlined]];
      return Wrap(spacing:10,runSpacing:10,children:a.map((x)=>SizedBox(width:w,child:_cardMetric(x[0] as String,x[1] as String,x[2] as IconData))).toList());
    })]));

  Widget _section(String title,List<Widget> children)=>Card(elevation:0,child:Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text(title,style:const TextStyle(fontWeight:FontWeight.w800,color:darkGreen)),const SizedBox(height:8),...children])));
  Widget _row(String l,String v)=>Padding(padding:const EdgeInsets.symmetric(vertical:5),child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
    SizedBox(width:155,child:Text(l,style:const TextStyle(fontWeight:FontWeight.w700))),Expanded(child:Text(v.isEmpty?'-':v))]));
  String _fmt(dynamic v){final d=_date(v);if(d==null){final s='$v';return v==null||s=='null'||s.isEmpty?'-':s;}return '${d.day.toString().padLeft(2,'0')}/${d.month.toString().padLeft(2,'0')}/${d.year}';}

  Future<void> _details(Map<String,dynamic> r) async=>showModalBottomSheet<void>(context:context,isScrollControlled:true,showDragHandle:true,builder:(context)=>SafeArea(child:DraggableScrollableSheet(
    expand:false,initialChildSize:.84,minChildSize:.55,maxChildSize:.96,builder:(context,controller)=>ListView(controller:controller,padding:const EdgeInsets.fromLTRB(18,4,18,24),children:[
      Text(_v(r,'title'),style:Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight:FontWeight.w800,color:darkGreen)),
      const SizedBox(height:3),Text(_v(r,'environmentId'),style:const TextStyle(fontWeight:FontWeight.w600)),const SizedBox(height:14),
      Wrap(spacing:8,runSpacing:8,children:[_chip(_v(r,'status')),_chip(_v(r,'severity')),_chip(_v(r,'compliance')),_chip(_v(r,'monitoringStatus')),_chip(_due(r))]),
      const SizedBox(height:16),_section('43A–43L Environmental Management Control',[
        _row('Environmental Type',_v(r,'environmentalType')),_row('Site / Location',_v(r,'site')),_row('Environmental Owner',_v(r,'owner')),
        _row('Status',_v(r,'status')),_row('Severity',_v(r,'severity')),_row('Compliance',_v(r,'compliance')),_row('Waste Type',_v(r,'wasteType')),
        _row('Quantity / Reading','${_v(r,'quantity')} ${_v(r,'unit')}'),_row('Monitoring Status',_v(r,'monitoringStatus')),
        _row('Permit / Legal Ref.',_v(r,'permitReference')),_row('Next Review',_fmt(r['nextReviewDate'])),_row('Review Status',_due(r))]),
      if(_v(r,'aspect').isNotEmpty)...[const SizedBox(height:12),_section('Environmental Aspect / Source',[Text(_v(r,'aspect'))])],
      if(_v(r,'impact').isNotEmpty)...[const SizedBox(height:12),_section('Environmental Impact / Risk',[Text(_v(r,'impact'))])],
      if(_v(r,'controls').isNotEmpty)...[const SizedBox(height:12),_section('Control Measures',[Text(_v(r,'controls'))])],
      if(_v(r,'monitoring').isNotEmpty)...[const SizedBox(height:12),_section('Monitoring Details / Results',[Text(_v(r,'monitoring'))])],
      if(_v(r,'correctiveAction').isNotEmpty)...[const SizedBox(height:12),_section('Corrective / Preventive Action',[Text(_v(r,'correctiveAction'))])],
      if(_v(r,'notes').isNotEmpty)...[const SizedBox(height:12),_section('Environmental / HSE Notes',[Text(_v(r,'notes'))])],
      if(widget.sourceOpener!=null)...[const SizedBox(height:16),OutlinedButton.icon(onPressed:(){Navigator.pop(context);widget.sourceOpener!('environmental_management',_v(r,'environmentId'));},icon:const Icon(Icons.open_in_new_outlined),label:const Text('Open Integration Reference'))]
    ]))));

  Future<void> _historyView() async=>showModalBottomSheet<void>(context:context,isScrollControlled:true,showDragHandle:true,builder:(context)=>SafeArea(child:SizedBox(
    height:MediaQuery.of(context).size.height*.78,child:Column(children:[
      const Padding(padding:EdgeInsets.fromLTRB(18,4,18,12),child:Align(alignment:Alignment.centerLeft,child:Text('Environmental Management History',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800,color:darkGreen)))),
      Expanded(child:_history.isEmpty?const Center(child:Text('No history records yet.')):ListView.separated(
        padding:const EdgeInsets.all(14),itemCount:_history.length,separatorBuilder:(_,__)=>const SizedBox(height:8),
        itemBuilder:(context,i){final x=_history[i];return Card(elevation:0,child:ListTile(leading:const CircleAvatar(child:Icon(Icons.history)),
          title:Text('${_v(x,'action')} — ${_v(x,'title')}'),subtitle:Text('${_v(x,'details')}\n${_fmt(x['timestamp'])}'),isThreeLine:true));})))])));

  Future<void> _guide() async{
    const m=<String,String>{
      '43A — Environmental Management Master':'Central register for environmental activities, aspects, impacts and controls.',
      '43B — Environmental Aspect & Impact':'Identify environmental aspects, sources, impacts and associated risk.',
      '43C — Waste Management':'Track general, recyclable, construction and other waste streams.',
      '43D — Hazardous Waste Tracking':'Record hazardous waste categories, quantities and control requirements.',
      '43E — Air / Noise / Emission Monitoring':'Track environmental monitoring results and action status.',
      '43F — Water & Effluent Management':'Record water, discharge and effluent-related environmental controls.',
      '43G — Spill Prevention & Response':'Link spill prevention and environmental response controls.',
      '43H — Environmental Inspection & Compliance':'Track inspections, findings and compliance outcomes.',
      '43I — Environmental Legal / Permit Tracking':'Record environmental permits and legal reference information.',
      '43J — Environmental Corrective Actions':'Capture corrective and preventive actions arising from environmental issues.',
      '43K — Environmental History / Audit Trail':'Maintain local environmental management history.',
      '43L — Environmental Intelligence Dashboard':'Management view of compliance, monitoring, waste, actions and review status.',
    };
    await showDialog<void>(context:context,builder:(c)=>AlertDialog(title:const Text('Step 43 — Module Guide'),
      content:SizedBox(width:650,child:ListView(shrinkWrap:true,children:m.entries.map((e)=>Padding(padding:const EdgeInsets.only(bottom:10),child:ListTile(
        contentPadding:EdgeInsets.zero,leading:const Icon(Icons.check_circle_outline,color:primaryGreen),
        title:Text(e.key,style:const TextStyle(fontWeight:FontWeight.w700)),subtitle:Text(e.value)))).toList())),
      actions:[TextButton(onPressed:()=>Navigator.pop(c),child:const Text('Close'))]));
  }
  void _reset(){setState(()=>{_statusFilter='All',_typeFilter='All',_severityFilter='All',_complianceFilter='All',_searchController.clear()});}

  Widget _filter(String label,String value,List<String> items,ValueChanged<String?> onChanged)=>SizedBox(width:195,child:DropdownButtonFormField<String>(
    initialValue:value,isExpanded:true,decoration:InputDecoration(labelText:label,filled:true,fillColor:Colors.white,border:const OutlineInputBorder(),isDense:true),
    items:items.map((x)=>DropdownMenuItem<String>(value:x,child:Text(x,overflow:TextOverflow.ellipsis))).toList(),onChanged:onChanged));

  Widget _record(Map<String,dynamic> r)=>Card(elevation:0,margin:const EdgeInsets.only(bottom:10),child:InkWell(
    borderRadius:BorderRadius.circular(12),onTap:()=>_details(r),child:Padding(padding:const EdgeInsets.all(14),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Row(crossAxisAlignment:CrossAxisAlignment.start,children:[const CircleAvatar(child:Icon(Icons.eco_outlined)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(_v(r,'title'),style:const TextStyle(fontWeight:FontWeight.w800,fontSize:16,color:darkGreen)),
        const SizedBox(height:2),Text('${_v(r,'environmentId')} • ${_v(r,'environmentalType')}',style:const TextStyle(fontSize:12))])),
        PopupMenuButton<String>(onSelected:(x){if(x=='view')_details(r);else if(x=='edit')_edit(r);else if(x=='delete')_delete(r);},itemBuilder:(c)=>const[
          PopupMenuItem(value:'view',child:Text('View Details')),PopupMenuItem(value:'edit',child:Text('Edit')),PopupMenuItem(value:'delete',child:Text('Delete'))])]),
      const SizedBox(height:10),Wrap(spacing:6,runSpacing:6,children:[_chip(_v(r,'status')),_chip(_v(r,'severity')),_chip(_v(r,'compliance')),_chip(_v(r,'monitoringStatus')),_chip(_due(r))]),
      const SizedBox(height:10),Row(children:[const Icon(Icons.location_on_outlined,size:17),const SizedBox(width:5),Expanded(child:Text(_v(r,'site'))),const SizedBox(width:8),
        const Icon(Icons.person_outline,size:17),const SizedBox(width:5),Expanded(child:Text(_v(r,'owner').isEmpty?'Unassigned':_v(r,'owner'),textAlign:TextAlign.end))]),
      if(_v(r,'wasteType')!='Not Applicable'&&_v(r,'wasteType').isNotEmpty)...[const SizedBox(height:8),Row(children:[const Icon(Icons.delete_sweep_outlined,size:17),const SizedBox(width:5),Expanded(child:Text(_v(r,'wasteType')))])]
    ])));

  @override
  Widget build(BuildContext context)=>Scaffold(
    backgroundColor:pageBackground,
    appBar:AppBar(title:const Text('Step 43 • Environmental Management',style:TextStyle(fontWeight:FontWeight.w800)),
      backgroundColor:darkGreen,foregroundColor:Colors.white,actions:[
        IconButton(tooltip:'Module Guide',onPressed:_guide,icon:const Icon(Icons.menu_book_outlined)),
        IconButton(tooltip:'History',onPressed:_historyView,icon:const Icon(Icons.history_outlined))]),
    floatingActionButton:FloatingActionButton.extended(onPressed:_loading?null:_add,backgroundColor:primaryGreen,foregroundColor:Colors.white,icon:const Icon(Icons.add),label:const Text('New Environmental Record')),
    body:_loading?const Center(child:CircularProgressIndicator()):RefreshIndicator(onRefresh:_loadData,child:ListView(padding:const EdgeInsets.fromLTRB(12,12,12,100),children:[
      _dashboard(),const SizedBox(height:12),Card(elevation:0,child:Padding(padding:const EdgeInsets.all(12),child:Column(children:[
        TextField(controller:_searchController,decoration:InputDecoration(labelText:'Search environmental record',hintText:'ID, title, site, owner, permit, waste type',
          prefixIcon:const Icon(Icons.search),suffixIcon:_searchController.text.isEmpty?null:IconButton(onPressed:_searchController.clear,icon:const Icon(Icons.clear)),border:const OutlineInputBorder())),
        const SizedBox(height:10),Wrap(spacing:8,runSpacing:8,children:[
          _filter('Status',_statusFilter,['All',..._statuses],(v)=>setState(()=>_statusFilter=v!)),
          _filter('Environmental Type',_typeFilter,['All',..._environmentalTypes],(v)=>setState(()=>_typeFilter=v!)),
          _filter('Severity',_severityFilter,['All',..._severityOptions],(v)=>setState(()=>_severityFilter=v!)),
          _filter('Compliance',_complianceFilter,['All',..._complianceOptions],(v)=>setState(()=>_complianceFilter=v!)),
          OutlinedButton.icon(onPressed:_reset,icon:const Icon(Icons.filter_alt_off),label:const Text('Reset'))])]))),
      const SizedBox(height:12),Row(children:[Expanded(child:Text('${_filtered.length} record(s) found',style:const TextStyle(fontWeight:FontWeight.w800,color:darkGreen))),
        TextButton.icon(onPressed:_guide,icon:const Icon(Icons.info_outline),label:const Text('43A–43L'))]),const SizedBox(height:4),
      if(_filtered.isEmpty)Card(elevation:0,child:Padding(padding:const EdgeInsets.all(30),child:Column(children:[
        const Icon(Icons.eco_outlined,size:48,color:darkGreen),const SizedBox(height:10),const Text('No environmental records found.',style:TextStyle(fontWeight:FontWeight.w700)),
        const SizedBox(height:6),const Text('Create an environmental record to begin Step 43 management.',textAlign:TextAlign.center),const SizedBox(height:14),
        FilledButton.icon(onPressed:_add,icon:const Icon(Icons.add),label:const Text('Create First Record'))]))))
      else ..._filtered.map(_record)
    ])));
}
