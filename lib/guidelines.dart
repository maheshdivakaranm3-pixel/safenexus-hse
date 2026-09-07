import 'package:flutter/material.dart';

import 'models/reference_topic.dart';
import 'guideline_detail_page.dart';

import 'data/uae_general_guidelines.dart';
import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';

class GuidelinesPage extends StatefulWidget {
  const GuidelinesPage({
    super.key,
  });

  @override
  State<GuidelinesPage> createState() =>
      _GuidelinesPageState();
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

  String _searchQuery = '';

  GuidelineCategory _selectedCategory =
      GuidelineCategory.all;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color pageBackground =
      Color(0xFFF6F8F7);

  // ============================================================
  // ALL HSE TOPICS
  //
  // UAE General + Abu Dhabi + Dubai
  //
  // Existing data files are intentionally kept separate.
  // ============================================================

  List<ReferenceTopic> get _topics {
    return [
      ...uaeGeneralGuidelines,
      ...abuDhabiGuidelines,
      ...dubaiGuidelines,
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
  //
  // Category filter + search filter
  // work together.
  // ============================================================

  List<ReferenceTopic> get _filteredTopics {
    final query =
        _searchQuery.trim().toLowerCase();

    Iterable<ReferenceTopic> result = _topics;

    // ----------------------------------------------------------
    // CATEGORY FILTER
    // ----------------------------------------------------------

    if (_selectedCategory !=
        GuidelineCategory.all) {
      result = result.where(
        (topic) =>
            topic.guidelineCategory ==
            _selectedCategory,
      );
    }

    // ----------------------------------------------------------
    // SEARCH FILTER
    // ----------------------------------------------------------

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

      // ========================================================
      // APP BAR
      // ========================================================

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

      // ========================================================
      // BODY
      // ========================================================

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
                // ------------------------------------------------
                // TITLE
                // ------------------------------------------------

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

                // ------------------------------------------------
                // SUBTITLE
                // ------------------------------------------------

                const Text(
                  'UAE-wide safety guidance and professional HSE references',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 10),

                // ------------------------------------------------
                // SEARCH
                // ------------------------------------------------

                TextField(
                  controller:
                      _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery =
                          value;
                    });
                  },
                  textInputAction:
                      TextInputAction.search,
                  decoration:
                      InputDecoration(
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
                              .circular(
                        14,
                      ),
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
                    style:
                        const TextStyle(
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

    return Padding(
      padding:
          const EdgeInsets.only(
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
        ),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : darkGreen,
          fontSize: 12,
          fontWeight:
              FontWeight.w700,
        ),
        backgroundColor:
            Colors.white,
        selectedColor:
            primaryGreen,
        side: BorderSide(
          color: isSelected
              ? primaryGreen
              : Colors.grey.shade300,
        ),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(22),
        ),
        padding:
            const EdgeInsets.symmetric(
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
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 1.5,
      color: Colors.white,
      shadowColor: Colors.black12,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: () =>
            _openTopic(topic),
        child: Padding(
          padding:
              const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // ==================================================
              // ICON
              // ==================================================

              Container(
                width: 52,
                height: 52,
                decoration:
                    BoxDecoration(
                  color:
                      primaryGreen.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
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

              // ==================================================
              // CONTENT
              // ==================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      topic.title,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight:
                            FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      topic.description,
                      maxLines: 3,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        color:
                            Colors.grey.shade700,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

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
                padding:
                    EdgeInsets.only(
                  top: 2,
                ),
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
    final cleanText =
        text.trim();

    if (cleanText.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      constraints:
          const BoxConstraints(
        maxWidth: 150,
      ),
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration:
          BoxDecoration(
        color:
            color.withValues(
          alpha: 0.09,
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        cleanText,
        maxLines: 1,
        overflow:
            TextOverflow.ellipsis,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight:
              FontWeight.w700,
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

    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              hasSearch
                  ? Icons.search_off
                  : Icons.menu_book_outlined,
              size: 64,
              color:
                  Colors.grey.shade400,
            ),

            const SizedBox(height: 14),

            const Text(
              'No guidelines found',
              style: TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              hasSearch
                  ? 'Try another search term.'
                  : 'No guidelines are available in this category.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
              ),
            ),

            if (hasSearch) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  _searchController
                      .clear();

                  setState(() {
                    _searchQuery = '';
                  });
                },
                icon: const Icon(
                  Icons.clear,
                ),
                label: const Text(
                  'Clear Search',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
