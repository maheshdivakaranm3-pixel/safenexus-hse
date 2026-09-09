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
  final TextEditingController _searchController =
      TextEditingController();

  late GuidelineCategory _selectedCategory;

  String _searchQuery = '';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
  }

  // ============================================================
  // ALL TOPICS
  // ============================================================

  List<ReferenceTopic> get _topics => [
        ...uaeGeneralGuidelines,
        ...abuDhabiGuidelines,
        ...dubaiGuidelines,
        ...hseSafetyReferences,
      ];

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
  // FILTERED TOPICS
  // ============================================================

  List<ReferenceTopic> get _filteredTopics {
    final query = _searchQuery.trim().toLowerCase();

    Iterable<ReferenceTopic> result = _topics;

    if (_selectedCategory != GuidelineCategory.all) {
      result = result.where(
        (topic) =>
            topic.guidelineCategory ==
            _selectedCategory,
      );
    }

    if (query.isNotEmpty) {
      result = result.where(
        (topic) {
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
        },
      );
    }

    return result.toList();
  }

  // ============================================================
  // OPEN TOPIC
  // ============================================================

  void _openTopic(
    ReferenceTopic topic,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            GuidelineDetailPage(
          topic: topic,
        ),
      ),
    );
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
        scrolledUnderElevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'HSE Safety Reference',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
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
            padding:
                const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              12,
            ),
            decoration: const BoxDecoration(
              color: primaryGreen,
              borderRadius:
                  BorderRadius.only(
                bottomLeft:
                    Radius.circular(18),
                bottomRight:
                    Radius.circular(18),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Professional HSE Reference',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                const Text(
                  'UAE-wide safety guidance and professional HSE references',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                  ),
                ),

                const SizedBox(height: 9),

                _buildSearchField(),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // CATEGORY FILTERS
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

          const SizedBox(height: 6),

          // ======================================================
          // ACTIVE CATEGORY
          // ======================================================

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration:
                      BoxDecoration(
                    color:
                        primaryGreen.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
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
                  child: Text(
                    _categoryLabel(
                      _selectedCategory,
                    ),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.blueGrey
                            .withValues(
                      alpha: 0.08,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    '${topics.length}',
                    style: TextStyle(
                      color:
                          Colors.blueGrey
                              .shade700,
                      fontWeight:
                          FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
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
                    physics:
                        const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      bottomSafeSpace + 32,
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
  // SEARCH FIELD
  // ============================================================

  Widget _buildSearchField() {
    return SizedBox(
      height: 52,
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        textInputAction:
            TextInputAction.search,
        textAlignVertical:
            TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText:
              'Search HSE guidelines...',
          hintStyle: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 24,
            color: Colors.black54,
          ),
          suffixIcon:
              _searchQuery.isNotEmpty
                  ? IconButton(
                      tooltip:
                          'Clear search',
                      onPressed: () {
                        _searchController
                            .clear();

                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color:
                            Colors.black54,
                      ),
                    )
                  : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(13),
            borderSide:
                BorderSide.none,
          ),
          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(13),
            borderSide:
                BorderSide.none,
          ),
          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(13),
            borderSide: BorderSide(
              color:
                  primaryGreen.withValues(
                alpha: 0.35,
              ),
              width: 1.5,
            ),
          ),
        ),
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
      padding:
          const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: isSelected,
        onSelected: (_) {
          _selectCategory(category);
        },
        avatar: Icon(
          _categoryIcon(category),
          size: 17,
          color: isSelected
              ? Colors.white
              : primaryGreen,
        ),
        label: Text(
          '${_categoryLabel(category)} ($count)',
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
        ),
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : darkGreen,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: Colors.white,
        selectedColor: primaryGreen,
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
      elevation: 1,
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
              Container(
                width: 52,
                height: 52,
                alignment:
                    Alignment.center,
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
                    topic
                        .guidelineCategory,
                  ),
                  color: primaryGreen,
                  size: 27,
                ),
              ),

              const SizedBox(width: 13),

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
                      style:
                          const TextStyle(
                        fontSize: 16,
                        height: 1.25,
                        fontWeight:
                            FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(
                        height: 7),

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
                        height: 10),

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

              const SizedBox(width: 5),

              const Padding(
                padding:
                    EdgeInsets.only(
                  top: 2,
                ),
                child: Icon(
                  Icons
                      .arrow_forward_ios_rounded,
                  size: 15,
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
            BorderRadius.circular(
          20,
        ),
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
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              hasSearch
                  ? Icons.search_off_rounded
                  : Icons.menu_book_outlined,
              size: 62,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 14),

            Text(
              hasSearch
                  ? 'No guidelines found'
                  : 'No guidelines available',
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 19,
                fontWeight:
                    FontWeight.w800,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              hasSearch
                  ? 'Try another search term.'
                  : 'No guidelines are available in this category.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                height: 1.4,
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
                  Icons.clear_rounded,
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
