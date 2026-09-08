import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'models/guideline_category.dart';
import 'guideline_detail_page.dart';

import 'data/uae_general_guidelines.dart';
import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';

class GuidelinesPage extends StatefulWidget {
  final GuidelineCategory initialCategory;

  const GuidelinesPage({
    super.key,
    this.initialCategory = GuidelineCategory.all,
  });

  @override
  State<GuidelinesPage> createState() => _GuidelinesPageState();
}

class _GuidelinesPageState extends State<GuidelinesPage> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController _searchController =
      TextEditingController();

  // ============================================================
  // STATE
  // ============================================================

  late GuidelineCategory _selectedCategory;

  String _searchQuery = '';

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _selectedCategory = widget.initialCategory;
  }

  // ============================================================
  // ALL HSE TOPICS
  // ============================================================

  List<ReferenceTopic> get _topics {
    return [
      ...uaeGeneralGuidelines,
      ...abuDhabiGuidelines,
      ...dubaiGuidelines,
      ...hseSafetyReferences,
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
        return 'UAE General';

      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';

      case GuidelineCategory.dubai:
        return 'Dubai';

      case GuidelineCategory.hseReference:
        return 'HSE Reference';
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
    final query = _searchQuery.trim().toLowerCase();

    Iterable<ReferenceTopic> result = _topics;

    // ----------------------------------------------------------
    // CATEGORY FILTER
    // ----------------------------------------------------------

    if (_selectedCategory != GuidelineCategory.all) {
      result = result.where(
        (topic) =>
            topic.guidelineCategory == _selectedCategory,
      );
    }

    // ----------------------------------------------------------
    // SEARCH FILTER
    // ----------------------------------------------------------

    if (query.isNotEmpty) {
      result = result.where((topic) {
        return topic.title.toLowerCase().contains(query) ||
            topic.shortTitle.toLowerCase().contains(query) ||
            topic.description.toLowerCase().contains(query) ||
            topic.category.toLowerCase().contains(query) ||
            topic.authority.toLowerCase().contains(query) ||
            topic.jurisdiction.toLowerCase().contains(query);
      });
    }

    return result.toList();
  }

  // ============================================================
  // OPEN TOPIC
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
        MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: pageBackground,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        toolbarHeight: 42,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleSpacing: 0,
        title: const Text(
          'HSE Safety Reference',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            height: 1.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: Column(
        children: [
          // ======================================================
          // MAIN HEADER
          // ======================================================

          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              16,
              5,
              16,
              8,
            ),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 22,
                  child: Center(
                    child: Text(
                      'Professional HSE Reference',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                const SizedBox(
                  width: double.infinity,
                  height: 16,
                  child: Center(
                    child: Text(
                      'UAE-wide safety guidance and professional HSE references',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                        height: 1.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                // ==================================================
                // SEARCH
                // ==================================================

                SizedBox(
                  height: 54,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    textInputAction: TextInputAction.search,
                    textAlignVertical:
                        TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.0,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Search HSE guidelines...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        height: 1.0,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.black54,
                      ),
                      suffixIcon:
                          _searchQuery.isNotEmpty
                              ? IconButton(
                                  tooltip: 'Clear search',
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();

                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // ======================================================
          // CATEGORY TABS
          // ======================================================

          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              children: [
                _buildCategoryChip(
                  GuidelineCategory.all,
                ),
                _buildCategoryChip(
                  GuidelineCategory.uaeGeneral,
                ),
                _buildCategoryChip(
                  GuidelineCategory.abuDhabi,
                ),
                _buildCategoryChip(
                  GuidelineCategory.dubai,
                ),
                _buildCategoryChip(
                  GuidelineCategory.hseReference,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // ACTIVE CATEGORY HEADER
          // ======================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SizedBox(
              height: 52,
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryGreen.withAlpha(25),
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _categoryIcon(
                        _selectedCategory,
                      ),
                      color: primaryGreen,
                      size: 23,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _categoryLabel(
                          _selectedCategory,
                        ),
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.0,
                          fontWeight: FontWeight.w700,
                          color: darkGreen,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${topics.length} topics',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // TOPIC LIST
          // ======================================================

          Expanded(
            child: topics.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior
                            .onDrag,
                    padding: EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      bottomSafeSpace + 40,
                    ),
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
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

  Widget _buildCategoryChip(
    GuidelineCategory category,
  ) {
    final isSelected =
        _selectedCategory == category;

    final count =
        _categoryCount(category);

    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: ChoiceChip(
        selected: isSelected,
        onSelected: (_) {
          _selectCategory(category);
        },
        avatar: Icon(
          _categoryIcon(category),
          size: 18,
          color: isSelected
              ? Colors.white
              : primaryGreen,
        ),
        label: Text(
          '${_categoryLabel(category)} ($count)',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : darkGreen,
          fontSize: 12,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.white,
        selectedColor: primaryGreen,
        side: BorderSide(
          color: isSelected
              ? primaryGreen
              : Colors.grey.shade300,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 4,
        ),
        showCheckmark: false,
      ),
    );
  }

  // ============================================================
  // TOPIC CARD
  // ============================================================

  Widget _buildTopicCard(
    ReferenceTopic topic,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _openTopic(topic),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withAlpha(25),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  _categoryIcon(
                    topic.guidelineCategory,
                  ),
                  color: primaryGreen,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      topic.description,
                      maxLines: 3,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 7,
                      runSpacing: 5,
                      children: [
                        _buildTag(
                          topic.category,
                          primaryGreen,
                        ),
                        _buildTag(
                          topic.jurisdiction,
                          Colors.blueGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 6),

              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TAG
  // ============================================================

  Widget _buildTag(
    String text,
    Color color,
  ) {
    final cleanText = text.trim();

    if (cleanText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints: const BoxConstraints(
        maxWidth: 150,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(23),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        cleanText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          height: 1.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    final hasSearch =
        _searchQuery.trim().isNotEmpty;

    final isHseReference =
        _selectedCategory ==
            GuidelineCategory.hseReference;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              hasSearch
                  ? Icons.search_off
                  : Icons.menu_book_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 14),

            Text(
              hasSearch
                  ? 'No guidelines found'
                  : isHseReference
                      ? 'No HSE Reference topics yet'
                      : 'No guidelines found',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                height: 1.1,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              hasSearch
                  ? 'Try another search term.'
                  : isHseReference
                      ? 'HSE Reference topics can be added here later without changing the other guideline sections.'
                      : 'No guidelines are available in this category.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),

            if (hasSearch) ...[
              const SizedBox(height: 16),

              OutlinedButton.icon(
                onPressed: () {
                  _searchController.clear();

                  setState(() {
                    _searchQuery = '';
                  });
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear Search'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
