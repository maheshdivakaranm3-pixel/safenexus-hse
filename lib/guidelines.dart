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

class _GuidelinesPageState
    extends State<GuidelinesPage> {
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
  // ALL TOPICS
  //
  // IMPORTANT:
  // Guideline content remains in separate data files.
  //
  // UAE General
  // Abu Dhabi
  // Dubai
  //
  // Future emirates can be added without rewriting the
  // guideline detail UI.
  // ============================================================

  List<ReferenceTopic> get _topics {
    return [
      ...uaeGeneralGuidelines,
      ...abuDhabiGuidelines,
      ...dubaiGuidelines,
    ];
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

    return _topics.where(
      (topic) {
        // ------------------------------------------------------
        // CATEGORY
        // ------------------------------------------------------

        final matchesCategory =
            _selectedCategory ==
                    GuidelineCategory.all ||
                topic.guidelineCategory ==
                    _selectedCategory;

        // ------------------------------------------------------
        // SEARCH
        // ------------------------------------------------------

        final matchesSearch =
            query.isEmpty ||
                topic.title
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

        return matchesCategory &&
            matchesSearch;
      },
    ).toList();
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
        builder: (_) =>
            GuidelineDetailPage(
          topic: topic,
        ),
      ),
    );
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
    String category,
  ) {
    switch (category
        .trim()
        .toLowerCase()) {
      case 'abu dhabi':
        return Icons.location_city;

      case 'dubai':
        return Icons.apartment;

      case 'uae':
      case 'uae general':
        return Icons.flag_outlined;

      default:
        return Icons.security_outlined;
    }
  }

  // ============================================================
  // CATEGORY SELECTOR
  // ============================================================

  Widget _buildCategorySelector() {
    final categories =
        GuidelineCategory.values;

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection:
            Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        physics:
            const BouncingScrollPhysics(),
        itemCount:
            categories.length,
        separatorBuilder:
            (_, __) =>
                const SizedBox(
          width: 8,
        ),
        itemBuilder:
            (context, index) {
          return _buildCategoryButton(
            categories[index],
          );
        },
      ),
    );
  }

  // ============================================================
  // CATEGORY BUTTON
  // ============================================================

  Widget _buildCategoryButton(
    GuidelineCategory category,
  ) {
    final selected =
        _selectedCategory ==
            category;

    return Material(
      color:
          Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        onTap: () {
          setState(() {
            _selectedCategory =
                category;
          });
        },
        child: AnimatedContainer(
          duration:
              const Duration(
            milliseconds: 180,
          ),
          height: 46,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration:
              BoxDecoration(
            color: selected
                ? primaryGreen
                : Colors.white,
            borderRadius:
                BorderRadius.circular(
              14,
            ),
            border:
                Border.all(
              color: selected
                  ? primaryGreen
                  : Colors.grey.shade300,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                if (selected) ...[
                  const Icon(
                    Icons.check,
                    size: 18,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
                Text(
                  _categoryLabel(
                    category,
                  ),
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      TextStyle(
                    color: selected
                        ? Colors.white
                        : darkGreen,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    final topics =
        _filteredTopics;

    final bottomSafeSpace =
        MediaQuery.of(context)
            .viewPadding
            .bottom;

    return Scaffold(
      backgroundColor:
          pageBackground,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            primaryGreen,
        foregroundColor:
            Colors.white,
        title:
            const Text(
          'UAE HSE Guidelines',
          style:
              TextStyle(
            fontWeight:
                FontWeight.bold,
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
            width:
                double.infinity,
            padding:
                const EdgeInsets.fromLTRB(
              16,
              18,
              16,
              18,
            ),
            decoration:
                const BoxDecoration(
              color:
                  primaryGreen,
              borderRadius:
                  BorderRadius.only(
                bottomLeft:
                    Radius.circular(
                  24,
                ),
                bottomRight:
                    Radius.circular(
                  24,
                ),
              ),
            ),
            child:
                Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                const Text(
                  'Professional HSE Reference',
                  style:
                      TextStyle(
                    color:
                        Colors.white,
                    fontSize:
                        22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 6,
                ),

                const Text(
                  'UAE-wide safety guidance and emirate-specific references',
                  style:
                      TextStyle(
                    color:
                        Colors.white70,
                    fontSize:
                        14,
                    height:
                        1.4,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                // ==============================================
                // SEARCH
                // ==============================================

                TextField(
                  controller:
                      _searchController,
                  onChanged:
                      (value) {
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
                    hintStyle:
                        TextStyle(
                      color:
                          Colors.grey.shade600,
                    ),
                    prefixIcon:
                        const Icon(
                      Icons.search,
                      size:
                          28,
                    ),
                    suffixIcon:
                        _searchQuery
                                .isNotEmpty
                            ? IconButton(
                                tooltip:
                                    'Clear search',
                                icon:
                                    const Icon(
                                  Icons.clear,
                                ),
                                onPressed:
                                    () {
                                  _searchController
                                      .clear();

                                  setState(
                                    () {
                                      _searchQuery =
                                          '';
                                    },
                                  );
                                },
                              )
                            : null,
                    filled:
                        true,
                    fillColor:
                        Colors.white,
                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      vertical:
                          16,
                      horizontal:
                          16,
                    ),
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                        16,
                      ),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          // ======================================================
          // CATEGORY FILTER
          // ======================================================

          _buildCategorySelector(),

          const SizedBox(
            height: 10,
          ),

          // ======================================================
          // LIST HEADER
          // ======================================================

          Padding(
            padding:
                const EdgeInsets
                    .symmetric(
              horizontal: 16,
            ),
            child:
                Row(
              children: [
                const Text(
                  'Guidelines',
                  style:
                      TextStyle(
                    fontSize:
                        19,
                    fontWeight:
                        FontWeight.bold,
                    color:
                        darkGreen,
                  ),
                ),

                const Spacer(),

                Text(
                  '${topics.length} topics',
                  style:
                      TextStyle(
                    color:
                        Colors.grey.shade700,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          // ======================================================
          // GUIDELINE LIST
          // ======================================================

          Expanded(
            child:
                topics.isEmpty
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
                          bottomSafeSpace +
                              40,
                        ),
                        itemCount:
                            topics.length,
                        itemBuilder:
                            (
                          context,
                          index,
                        ) {
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
      color:
          Colors.white,
      shadowColor:
          Colors.black12,
      shape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),
      child:
          InkWell(
        borderRadius:
            BorderRadius.circular(
          18,
        ),
        onTap:
            () => _openTopic(
          topic,
        ),
        child:
            Padding(
          padding:
              const EdgeInsets.all(
            16,
          ),
          child:
              Row(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              // ==================================================
              // ICON
              // ==================================================

              Container(
                width:
                    52,
                height:
                    52,
                decoration:
                    BoxDecoration(
                  color:
                      primaryGreen
                          .withValues(
                    alpha:
                        0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child:
                    Icon(
                  _categoryIcon(
                    topic.category,
                  ),
                  color:
                      primaryGreen,
                  size:
                      27,
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              // ==================================================
              // CONTENT
              // ==================================================

              Expanded(
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      topic.title,
                      maxLines:
                          2,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          const TextStyle(
                        fontSize:
                            16,
                        height:
                            1.25,
                        fontWeight:
                            FontWeight
                                .bold,
                        color:
                            darkGreen,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      topic.description,
                      maxLines:
                          3,
                      overflow:
                          TextOverflow
                              .ellipsis,
                      style:
                          TextStyle(
                        fontSize:
                            13,
                        height:
                            1.35,
                        color:
                            Colors
                                .grey
                                .shade700,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // ==========================================
                    // TAGS
                    // ==========================================

                    Wrap(
                      spacing:
                          7,
                      runSpacing:
                          5,
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

              const SizedBox(
                width: 6,
              ),

              // ==================================================
              // ARROW
              // ==================================================

              const Padding(
                padding:
                    EdgeInsets.only(
                  top: 2,
                ),
                child:
                    Icon(
                  Icons
                      .arrow_forward_ios,
                  size:
                      16,
                  color:
                      Colors.grey,
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
      child:
          Text(
        text,
        maxLines:
            1,
        overflow:
            TextOverflow.ellipsis,
        style:
            TextStyle(
          color:
              color,
          fontSize:
              11,
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
    return Center(
      child:
          Padding(
        padding:
            const EdgeInsets.all(
          30,
        ),
        child:
            Column(
          mainAxisAlignment:
              MainAxisAlignment
                  .center,
          children: [
            Icon(
              Icons.search_off,
              size:
                  64,
              color:
                  Colors.grey
                      .shade400,
            ),

            const SizedBox(
              height: 14,
            ),

            const Text(
              'No guidelines found',
              style:
                  TextStyle(
                fontSize:
                    19,
                fontWeight:
                    FontWeight.bold,
                color:
                    darkGreen,
              ),
            ),

            const SizedBox(
              height: 7,
            ),

            Text(
              'Try another search term or category.',
              textAlign:
                  TextAlign.center,
              style:
                  TextStyle(
                color:
                    Colors.grey
                        .shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
