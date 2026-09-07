import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'guideline_detail_page.dart';

import 'data/uae_general_guidelines.dart';
import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({
    super.key,
  });

  @override
  State<GuidelinesPage> createState() =>
      _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _searchQuery = '';

  GuidelineCategory _selectedCategory =
      GuidelineCategory.all;

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color pageBackground =
      Color(0xFFF6F8F7);

  // ============================================================
  // ALL HSE TOPICS
  // ============================================================

  List<ReferenceTopic> get _topics {
    return [
      ...uaeGeneralGuidelines,
      ...abuDhabiGuidelines,
      ...dubaiGuidelines,
      ...hseSafetyReference,
    ];
  }

  // ============================================================
  // CATEGORY LABEL
  // ============================================================

  String _categoryLabel(
    GuidelineCategory category,
  ) {
    switch (category) {
      case GuidelineCategory.all:
        return 'All';

      case GuidelineCategory.uaeGeneral:
        return 'UAE Safety Standard';

      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi Safety Standard';

      case GuidelineCategory.dubai:
        return 'Dubai Safety Standard';

      case GuidelineCategory.hseReference:
        return 'HSE Safety Reference';
    }
  }

  // ============================================================
  // CATEGORY ICON
  // ============================================================

  IconData _categoryIcon(
    GuidelineCategory category,
  ) {
    switch (category) {
      case GuidelineCategory.all:
        return Icons.apps_outlined;

      case GuidelineCategory.uaeGeneral:
        return Icons.flag_outlined;

      case GuidelineCategory.abuDhabi:
        return Icons.location_city_outlined;

      case GuidelineCategory.dubai:
        return Icons.apartment_outlined;

      case GuidelineCategory.hseReference:
        return Icons.menu_book_outlined;
    }
  }

  // ============================================================
  // CATEGORY COUNT
  // ============================================================

  int _categoryCount(
    GuidelineCategory category,
  ) {
    if (category == GuidelineCategory.all) {
      return _topics.length;
    }

    return _topics
        .where(
          (topic) =>
              topic.guidelineCategory == category,
        )
        .length;
  }

  // ============================================================
  // SELECT CATEGORY
  // ============================================================

  void _selectCategory(
    GuidelineCategory category,
  ) {
    if (_selectedCategory == category) {
      return;
    }

    setState(() {
      _selectedCategory = category;
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTERED TOPICS
  // ============================================================

  List<ReferenceTopic> get _filteredTopics {
    final query =
        _searchQuery.trim().toLowerCase();

    Iterable<ReferenceTopic> result = _topics;

    if (_selectedCategory !=
        GuidelineCategory.all) {
      result = result.where(
        (topic) =>
            topic.guidelineCategory ==
            _selectedCategory,
      );
    }

    if (query.isNotEmpty) {
      result = result.where((topic) {
        return topic.title
                .toLowerCase()
                .contains(query) ||
            topic.shortTitle
                .toLowerCase()
                .contains(query) ||
            topic.description
                .toLowerCase()
                .contains(query) ||
            topic.category
                .toLowerCase()
                .contains(query) ||
            topic.authority
                .toLowerCase()
                .contains(query) ||
            topic.jurisdiction
                .toLowerCase()
                .contains(query);
      });
    }

    return result.toList();
  }

  // ============================================================
  // OPEN DETAIL PAGE
  // ============================================================

  void _openTopic(
    ReferenceTopic topic,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GuidelineDetailPage(
          topic: topic,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final topics = _filteredTopics;

    final bottomSafeSpace =
        MediaQuery.of(context)
            .viewPadding
            .bottom;

    return Scaffold(
      backgroundColor: pageBackground,

      appBar: AppBar(
        toolbarHeight: 48,
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'UAE HSE Guidelines',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: Column(
        children: [
          // ======================================================
          // HEADER
          // ======================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              16,
              10,
              16,
              14,
            ),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(22),
                bottomRight:
                    Radius.circular(22),
              ),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Professional HSE Reference',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'UAE-wide safety guidance and professional HSE references',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller:
                      _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  textInputAction:
                      TextInputAction.search,
                  decoration: InputDecoration(
                    hintText:
                        'Search HSE guidelines...',
                    hintStyle: TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                    prefixIcon:
                        const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    suffixIcon:
                        _searchQuery.isNotEmpty
                            ? IconButton(
                                tooltip:
                                    'Clear search',
                                icon:
                                    const Icon(
                                  Icons.clear,
                                ),
                                onPressed: () {
                                  _searchController
                                      .clear();

                                  setState(() {
                                    _searchQuery =
                                        '';
                                  });
                                },
                              )
                            : null,
                    filled: true,
                    fillColor:
                        Colors.white,
                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 12,
                      horizontal: 14,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(14),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ======================================================
          // CATEGORY SELECTOR
          // ======================================================

          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection:
                  Axis.horizontal,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              children: [
                _buildCategoryChip(
                  category:
                      GuidelineCategory.all,
                ),

                _buildCategoryChip(
                  category:
                      GuidelineCategory.uaeGeneral,
                ),

                _buildCategoryChip(
                  category:
                      GuidelineCategory.abuDhabi,
                ),

                _buildCategoryChip(
                  category:
                      GuidelineCategory.dubai,
                ),

                _buildCategoryChip(
                  category:
                      GuidelineCategory.hseReference,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ======================================================
          // ACTIVE CATEGORY HEADER
          // ======================================================

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: primaryGreen
                        .withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      11,
                    ),
                  ),
                  child: Icon(
                    _categoryIcon(
                      _selectedCategory,
                    ),
                    color: primaryGreen,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    _categoryLabel(
                      _selectedCategory,
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),

                Text(
                  '${topics.length} topics',
                  style: TextStyle(
                    color:
                        Colors.grey.shade700,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // GUIDELINE LIST
          // ======================================================

          Expanded(
            child: topics.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,
                    padding:
                        EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      bottomSafeSpace + 40,
                    ),
                    itemCount:
                        topics.length,
                    itemBuilder:
                        (context, index) {
                      return _buildTopicCard(
                        topics[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY CHIP
  // ============================================================

  Widget _buildCategoryChip({
    required GuidelineCategory category,
  }) {
    final isSelected =
        _selectedCategory == category;

    final count =
        _categoryCount(category);

    return
