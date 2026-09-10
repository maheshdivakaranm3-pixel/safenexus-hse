import 'package:flutter/material.dart';

import 'data/tbt_data.dart';

class TbtHomePage extends StatefulWidget {
  const TbtHomePage({super.key});

  @override
  State<TbtHomePage> createState() => _TbtHomePageState();
}

class _TbtHomePageState extends State<TbtHomePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  String _query = '';
  String _category = 'All';

  List<String> get _categories {
    final values =
        tbtTopics.map((e) => e.category).toSet().toList()..sort();

    return [
      'All',
      ...values,
    ];
  }

  List<TbtTopic> get _filteredTopics {
    final q = _query.trim().toLowerCase();

    return tbtTopics.where((topic) {
      final categoryMatch =
          _category == 'All' || topic.category == _category;

      final textMatch =
          q.isEmpty ||
          topic.title.toLowerCase().contains(q) ||
          topic.category.toLowerCase().contains(q);

      return categoryMatch && textMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),

      appBar: AppBar(
        title: const Text(
          'TBT - Toolbox Talk',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),

      body: Column(
        children: [
          _buildHeader(),
          _buildSearch(),
          _buildCategoryFilter(),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        10,
      ),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            darkGreen,
            primaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),

      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,

            decoration: BoxDecoration(
              color: Colors.white.withAlpha(35),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.handyman_rounded,
              color: Colors.white,
              size: 29,
            ),
          ),

          const SizedBox(width: 13),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  '100 TBT Topics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Ready-to-use safety briefing content for UAE worksites.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: TextField(
        onChanged: (value) {
          setState(() {
            _query = value;
          });
        },

        decoration: InputDecoration(
          hintText: 'Search TBT topic...',

          prefixIcon: const Icon(
            Icons.search_rounded,
          ),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTER
  // ============================================================

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 56,

      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          8,
        ),

        scrollDirection: Axis.horizontal,

        itemCount: _categories.length,

        separatorBuilder: (_, __) {
          return const SizedBox(width: 8);
        },

        itemBuilder: (context, index) {
          final category =
              _categories[index];

          final selected =
              category == _category;

          return ChoiceChip(
            label: Text(category),

            selected: selected,

            onSelected: (_) {
              setState(() {
                _category = category;
              });
            },

            selectedColor:
                primaryGreen.withAlpha(35),

            labelStyle: TextStyle(
              color: selected
                  ? darkGreen
                  : navy,

              fontWeight:
                  FontWeight.w700,

              fontSize: 12,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // TBT LIST
  // ============================================================

  Widget _buildList() {
    final topics =
        _filteredTopics;

    if (topics.isEmpty) {
      return const Center(
        child: Text(
          'No TBT topic found.',
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        24,
      ),

      itemCount: topics.length,

      separatorBuilder: (_, __) {
        return const SizedBox(height: 10);
      },

      itemBuilder: (context, index) {
        return _topicCard(
          topics[index],
        );
      },
    );
  }

  // ============================================================
  // TOPIC CARD
  // ============================================================

  Widget _topicCard(TbtTopic topic) {
    return Material(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(19),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(19),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TbtDetailPage(
                topic: topic,
              ),
            ),
          );
        },

        child: Padding(
          padding:
              const EdgeInsets.all(15),

          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,

                decoration:
                    BoxDecoration(
                  color: primaryGreen
                      .withAlpha(20),

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),

                child: const Icon(
                  Icons
                      .health_and_safety_rounded,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'TBT ${topic.id}',
                      style:
                          const TextStyle(
                        fontSize: 10,
                        color:
                            primaryGreen,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      topic.title,
                      style:
                          const TextStyle(
                        fontSize: 15,
                        color: navy,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      topic.category,
                      style:
                          const TextStyle(
                        fontSize: 11,
                        color:
                            Color(
                          0xFF607D8B,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TBT DETAIL PAGE
// ================================================================

class TbtDetailPage extends StatelessWidget {
  final TbtTopic topic;

  const TbtDetailPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF075B45);

  static const Color navy =
      Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F8FB),

      appBar: AppBar(
        title: Text(
          'TBT ${topic.id}',
          style: const TextStyle(
            fontWeight:
                FontWeight.w800,
            color: navy,
          ),
        ),

        backgroundColor:
            Colors.white,

        foregroundColor:
            navy,

        elevation: 0,
      ),

      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),

        children: [
          _titleCard(),

          _section(
            'Objective',
            Icons.flag_rounded,
            [
              topic.objective,
            ],
          ),

          _section(
            'Key Hazards',
            Icons.warning_amber_rounded,
            topic.keyHazards,
          ),

          _section(
            'Required Controls',
            Icons.verified_user_rounded,
            topic.requiredControls,
          ),

          _section(
            'PPE',
            Icons.engineering_rounded,
            topic.ppe,
          ),

          _section(
            'Before Starting Work',
            Icons.play_circle_outline_rounded,
            topic.beforeStarting,
          ),

          _section(
            'Safe Work Practices',
            Icons.check_circle_outline_rounded,
            topic.safeWorkPractices,
          ),

          _section(
            'Emergency Response',
            Icons.emergency_rounded,
            topic.emergencyResponse,
          ),

          _section(
            'Supervisor Discussion Points',
            Icons.groups_rounded,
            topic.supervisorPoints,
          ),

          // NEW
          _codeOfPractice(),

          _confirmation(),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE CARD
  // ============================================================

  Widget _titleCard() {
    return Container(
      padding:
          const EdgeInsets.all(19),

      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            darkGreen,
            primaryGreen,
          ],
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            'TBT ${topic.id}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            topic.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.w900,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            topic.category,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMON SECTION
  // ============================================================

  Widget _section(
    String title,
    IconData icon,
    List<String> items,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        13,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(19),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color:
                    primaryGreen,
                size: 21,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...items.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(
                      top: 6,
                    ),

                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Text(
                      item,
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF455A64,
                        ),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CODE OF PRACTICE / REFERENCE
  // ============================================================

  Widget _codeOfPractice() {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        13,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFFF7FAFF),

        borderRadius:
            BorderRadius.circular(19),

        border: Border.all(
          color:
              const Color(0xFFD8E4F0),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: primaryGreen,
                size: 21,
              ),

              SizedBox(width: 8),

              Expanded(
                child: Text(
                  'Code of Practice / Reference',
                  style:
                      TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...topic.codeOfPractice.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(
                      top: 6,
                    ),

                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Text(
                      item,
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF455A64,
                        ),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Reference note: Always verify the current applicable authority requirements, project specifications and approved HSE documents before work starts.',
            style: TextStyle(
              color:
                  Color(0xFF607D8B),
              fontSize: 11,
              height: 1.4,
              fontStyle:
                  FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WORKER CONFIRMATION
  // ============================================================

  Widget _confirmation() {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color:
            const Color(0xFFEAF8F0),

        borderRadius:
            BorderRadius.circular(19),

        border: Border.all(
          color:
              primaryGreen.withAlpha(40),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: primaryGreen,
            size: 25,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              topic.workerConfirmation,
              style:
                  const TextStyle(
                color: darkGreen,
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
