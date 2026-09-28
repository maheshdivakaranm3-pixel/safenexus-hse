// lib/data/abu_dhabi/abu_dhabi_cop_icons.dart
//
// SafeNexus HSE — Abu Dhabi CoP 01–54 single-file index UI.
// Includes topic list, icons, search, zoom/reset, double-tap, pinch and pan.
// Existing handbook pages remain in their current files and are opened through
// onOpenCop, so this file does not duplicate or replace handbook content.

import 'package:flutter/material.dart';

class AbuDhabiCopIconsPage extends StatefulWidget {
  const AbuDhabiCopIconsPage({
    super.key,
    required this.onOpenCop,
  });

  /// Connect this callback to the existing CoP detail-page navigation.
  final ValueChanged<int> onOpenCop;

  @override
  State<AbuDhabiCopIconsPage> createState() => _AbuDhabiCopIconsPageState();
}

class _AbuDhabiCopIconsPageState extends State<AbuDhabiCopIconsPage> {
  static const Color _green = Color(0xFF159447);
  static const Color _navy = Color(0xFF082653);

  final TextEditingController _searchController = TextEditingController();
  final TransformationController _transformController =
      TransformationController();

  String _query = '';
  bool _zoomed = false;

  static const List<_CopMenuItem> _items = [
    _CopMenuItem(1, 'Hazardous Materials', Icons.science_rounded),
    _CopMenuItem(2, 'Personal Protective Equipment', Icons.health_and_safety_rounded),
    _CopMenuItem(3, 'Occupational Noise', Icons.hearing_rounded),
    _CopMenuItem(4, 'First Aid and Medical Emergency Treatment', Icons.medical_services_rounded),
    _CopMenuItem(5, 'Occupational Health Screening and Medical Surveillance', Icons.health_and_safety_rounded),
    _CopMenuItem(6, 'Emergency Management Requirements', Icons.emergency_rounded),
    _CopMenuItem(7, 'Topic not integrated in current source', Icons.menu_book_rounded, pending: true),
    _CopMenuItem(8, 'General Workplace Amenities', Icons.apartment_rounded),
    _CopMenuItem(9, 'Workplace Wellness', Icons.spa_rounded),
    _CopMenuItem(10, 'Rehabilitation and Return to Work', Icons.accessibility_new_rounded),
    _CopMenuItem(11, 'Safety in the Heat', Icons.wb_sunny_rounded),
    _CopMenuItem(12, 'Prevention and Control of Legionnaires Disease', Icons.water_drop_rounded),
    _CopMenuItem(13, 'Violence in the Workplace', Icons.shield_rounded),
    _CopMenuItem(14, 'Manual Handling and Ergonomics', Icons.back_hand_rounded),
    _CopMenuItem(15, 'Electrical Safety', Icons.electrical_services_rounded),
    _CopMenuItem(16, 'OSH Requirements for People of Determination', Icons.accessible_rounded),
    _CopMenuItem(17, 'Safety Signage and Signals', Icons.signpost_rounded),
    _CopMenuItem(18, 'Employer Supplied Accommodation', Icons.home_work_rounded),
    _CopMenuItem(19, 'Occupational Food Handling and Food Preparation Areas', Icons.restaurant_rounded),
    _CopMenuItem(20, 'Safety in Design (Construction)', Icons.design_services_rounded),
    _CopMenuItem(21, 'Permit to Work Systems', Icons.assignment_turned_in_rounded),
    _CopMenuItem(22, 'Barricading of Hazards', Icons.fence_rounded),
    _CopMenuItem(23, 'Working at Height', Icons.vertical_align_top_rounded),
    _CopMenuItem(24, 'Lock-out / Tag-out (Isolation)', Icons.lock_rounded),
    _CopMenuItem(25, 'Driver Fatigue Prevention', Icons.local_shipping_rounded),
    _CopMenuItem(26, 'Scaffolding', Icons.construction_rounded),
    _CopMenuItem(27, 'Confined Spaces', Icons.circle_outlined),
    _CopMenuItem(28, 'Hot Work Operations', Icons.local_fire_department_rounded),
    _CopMenuItem(29, 'Excavation Work', Icons.construction_rounded),
    _CopMenuItem(30, 'Lone Working and/or in Remote Locations', Icons.person_pin_circle_rounded),
    _CopMenuItem(31, 'Working On, Over or Adjacent to Water', Icons.water_drop_rounded),
    _CopMenuItem(32, 'Topic not integrated in current source', Icons.menu_book_rounded, pending: true),
    _CopMenuItem(33, 'Working On or Adjacent to a Road', Icons.add_road_rounded),
    _CopMenuItem(34, 'Safe Use of Lifting Equipment and Lifting Accessories', Icons.precision_manufacturing_rounded),
    _CopMenuItem(35, 'Portable Power Tools', Icons.handyman_rounded),
    _CopMenuItem(36, 'Plant and Equipment', Icons.precision_manufacturing_rounded),
    _CopMenuItem(37, 'Ladders', Icons.stairs_rounded),
    _CopMenuItem(38, 'Concrete Placing Equipment', Icons.foundation_rounded),
    _CopMenuItem(39, 'Overhead and Underground Services', Icons.cable_rounded),
    _CopMenuItem(40, 'False Work (Formwork)', Icons.view_module_rounded),
    _CopMenuItem(41, 'Steel Erection', Icons.domain_rounded),
    _CopMenuItem(42, 'Pre Cast Construction', Icons.apartment_rounded),
    _CopMenuItem(43, 'Temporary Structures', Icons.architecture_rounded),
    _CopMenuItem(44, 'Traffic Management and Logistics', Icons.traffic_rounded),
    _CopMenuItem(45, 'Underwater Activities', Icons.water_drop_rounded),
    _CopMenuItem(46, 'Underground Construction', Icons.trending_down_rounded),
    _CopMenuItem(47, 'Machine Guarding', Icons.precision_manufacturing_rounded),
    _CopMenuItem(48, 'Spray Finishing', Icons.format_paint_rounded),
    _CopMenuItem(49, 'Compressed Gases and Air', Icons.air_rounded),
    _CopMenuItem(50, 'Abrasive Blasting and Associated Protective Coating Work', Icons.grain_rounded),
    _CopMenuItem(51, 'Powered Lift Trucks', Icons.local_shipping_rounded),
    _CopMenuItem(52, 'Local Exhaust Ventilation', Icons.air_rounded),
    _CopMenuItem(53, 'OSH Management During Construction Work', Icons.engineering_rounded),
    _CopMenuItem(54, 'Waste Management', Icons.recycling_rounded),
  ];

  List<_CopMenuItem> get _filteredItems {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return _items;
    return _items.where((item) {
      return 'cop ${item.number} ${item.number} ${item.title}'
          .toLowerCase()
          .contains(query);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  void _toggleZoom() {
    if (_zoomed) {
      _resetZoom();
      return;
    }
    _transformController.value = Matrix4.diagonal3Values(1.45, 1.45, 1);
    setState(() => _zoomed = true);
  }

  void _resetZoom() {
    _transformController.value = Matrix4.identity();
    if (_zoomed) setState(() => _zoomed = false);
  }

  void _onInteractionUpdate(ScaleUpdateDetails details) {
    final nowZoomed = _transformController.value.getMaxScaleOnAxis() > 1.01;
    if (nowZoomed != _zoomed) setState(() => _zoomed = nowZoomed);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        title: const Text('Abu Dhabi CoP Reference'),
        backgroundColor: Colors.white,
        foregroundColor: _navy,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: _zoomed ? 'Reset zoom' : 'Zoom in',
            onPressed: _toggleZoom,
            icon: Icon(_zoomed ? Icons.zoom_out_map : Icons.zoom_in),
          ),
          IconButton(
            tooltip: 'Reset view',
            onPressed: _resetZoom,
            icon: const Icon(Icons.center_focus_strong),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _query = value),
              decoration: InputDecoration(
                hintText: 'Search CoP number or topic...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Clear search',
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _query = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onDoubleTap: _toggleZoom,
              child: InteractiveViewer(
                transformationController: _transformController,
                minScale: 1,
                maxScale: 3,
                panEnabled: true,
                scaleEnabled: true,
                boundaryMargin: const EdgeInsets.all(80),
                onInteractionUpdate: _onInteractionUpdate,
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return _topicCard(item);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _zoomed
          ? FloatingActionButton.small(
              tooltip: 'Reset zoom',
              onPressed: _resetZoom,
              backgroundColor: _green,
              foregroundColor: Colors.white,
              child: const Icon(Icons.center_focus_strong),
            )
          : null,
    );
  }

  Widget _topicCard(_CopMenuItem item) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: item.pending ? null : () => widget.onOpenCop(item.number),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: item.pending
                      ? Colors.orange.withOpacity(0.12)
                      : _green.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.pending ? Colors.orange.shade800 : _green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'CoP ${item.number.toString().padLeft(2, '0')} → ${item.title}',
                  style: const TextStyle(
                    color: Color(0xFF202B36),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (item.pending)
                const Text(
                  'Pending',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                const Icon(Icons.chevron_right_rounded, color: _navy),
            ],
          ),
        ),
      ),
    );
  }
}

class _CopMenuItem {
  const _CopMenuItem(
    this.number,
    this.title,
    this.icon, {
    this.pending = false,
  });

  final int number;
  final String title;
  final IconData icon;
  final bool pending;
}
