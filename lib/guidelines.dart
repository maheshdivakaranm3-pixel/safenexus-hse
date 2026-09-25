import 'package:flutter/material.dart';

/// SafeNexus HSE — Reference screen
///
/// This file intentionally contains NO dependency on the old UAE / Abu Dhabi /
/// Dubai reference models, data files, topic routers, or detail pages.
///
/// The existing SafeNexus application shell can continue to open [GuidelinesPage].
/// The reference content itself is being rebuilt from zero, while preserving the
/// current Reference-screen concept and sector cards.
///
/// When the new reference modules are implemented, each card can be connected
/// to its dedicated page without changing the SafeNexus shell.

class GuidelinesPage extends StatelessWidget {
  const GuidelinesPage({super.key});

  static const Color _navy = Color(0xFF123047);
  static const Color _green = Color(0xFF138A5B);
  static const Color _lightGreen = Color(0xFFEAF7F0);
  static const Color _pageBackground = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    final sections = <_ReferenceSection>[
      const _ReferenceSection(
        title: 'UAE HSE',
        subtitle: 'UAE-wide HSE reference',
        icon: Icons.account_balance,
        color: _green,
        kind: _ReferenceKind.uae,
      ),
      const _ReferenceSection(
        title: 'Abu Dhabi HSE',
        subtitle: 'Abu Dhabi HSE reference',
        icon: Icons.location_city,
        color: Color(0xFF1B8A63),
        kind: _ReferenceKind.abuDhabi,
      ),
      const _ReferenceSection(
        title: 'Dubai HSE',
        subtitle: 'Dubai HSE reference',
        icon: Icons.apartment,
        color: Color(0xFF1976A8),
        kind: _ReferenceKind.dubai,
      ),
      const _ReferenceSection(
        title: 'Construction',
        subtitle: 'Construction safety',
        icon: Icons.construction,
        color: Color(0xFFB86B00),
        kind: _ReferenceKind.construction,
      ),
      const _ReferenceSection(
        title: 'Oil & Gas',
        subtitle: 'Oil & Gas HSE',
        icon: Icons.local_gas_station,
        color: Color(0xFF7A4E00),
        kind: _ReferenceKind.oilGas,
      ),
      const _ReferenceSection(
        title: 'Offshore',
        subtitle: 'Offshore operations',
        icon: Icons.sailing,
        color: Color(0xFF176B87),
        kind: _ReferenceKind.offshore,
      ),
      const _ReferenceSection(
        title: 'Industrial',
        subtitle: 'Industrial HSE',
        icon: Icons.factory,
        color: Color(0xFF555F6D),
        kind: _ReferenceKind.industrial,
      ),
      const _ReferenceSection(
        title: 'Occupational Health',
        subtitle: 'Worker health & wellbeing',
        icon: Icons.health_and_safety,
        color: Color(0xFF8B4F8E),
        kind: _ReferenceKind.occupationalHealth,
      ),
      const _ReferenceSection(
        title: 'Environmental',
        subtitle: 'Environmental HSE',
        icon: Icons.eco,
        color: Color(0xFF3C7D45),
        kind: _ReferenceKind.environmental,
      ),
      const _ReferenceSection(
        title: 'Emergency & Rescue',
        subtitle: 'Emergency response',
        icon: Icons.emergency,
        color: Color(0xFFB3261E),
        kind: _ReferenceKind.emergency,
      ),
      const _ReferenceSection(
        title: 'Fire & Life Safety',
        subtitle: 'Fire and life safety',
        icon: Icons.local_fire_department,
        color: Color(0xFFC44B16),
        kind: _ReferenceKind.fireLifeSafety,
      ),
      const _ReferenceSection(
        title: 'Specialist / Cross-Sector',
        subtitle: 'Specialist HSE topics',
        icon: Icons.engineering,
        color: Color(0xFF5B4B8A),
        kind: _ReferenceKind.specialist,
      ),
      const _ReferenceSection(
        title: 'Learning + Interview',
        subtitle: 'Learning and interview preparation',
        icon: Icons.school,
        color: Color(0xFF1565C0),
        kind: _ReferenceKind.learning,
      ),
    ];

    return Scaffold(
      backgroundColor: _pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'HSE Reference',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _ReferenceHeader(),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 28),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final section = sections[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ReferenceCard(
                        section: section,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => _ReferencePlaceholderPage(
                                section: section,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: sections.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferenceHeader extends StatelessWidget {
  const _ReferenceHeader();

  static const Color _navy = Color(0xFF123047);
  static const Color _green = Color(0xFF138A5B);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF123047),
            Color(0xFF185D4A),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: const Offset(0, 7),
            color: Colors.black.withOpacity(0.10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 29,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SafeNexus HSE Reference',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Professional field reference for UAE HSE, '
                  'jurisdictional requirements and specialist sectors.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.verified_rounded,
            color: _green.withOpacity(0.95),
            size: 25,
          ),
        ],
      ),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({
    required this.section,
    required this.onTap,
  });

  final _ReferenceSection section;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 86),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE3EAE7)),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.045),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: section.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  section.icon,
                  color: section.color,
                  size: 27,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        color: Color(0xFF18313E),
                        fontSize: 16,
                        fontWeight: FontWeight.w750,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section.subtitle,
                      style: const TextStyle(
                        color: Color(0xFF6D7B82),
                        fontSize: 12.5,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: section.color,
                size: 27,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReferencePlaceholderPage extends StatelessWidget {
  const _ReferencePlaceholderPage({
    required this.section,
  });

  final _ReferenceSection section;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF123047),
        foregroundColor: Colors.white,
        title: Text(
          section.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE0E8E4)),
            ),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: section.color.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    section.icon,
                    color: section.color,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  section.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF123047),
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'New SafeNexus HSE reference content is being built '
                  'from a clean architecture.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF66757C),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF7F0),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Color(0xFF138A5B),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Old UAE, Abu Dhabi and Dubai reference data '
                          'is intentionally not connected here. '
                          'The new reference modules will be added separately.',
                          style: TextStyle(
                            color: Color(0xFF245B46),
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _ReferenceKind {
  uae,
  abuDhabi,
  dubai,
  construction,
  oilGas,
  offshore,
  industrial,
  occupationalHealth,
  environmental,
  emergency,
  fireLifeSafety,
  specialist,
  learning,
}

class _ReferenceSection {
  const _ReferenceSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.kind,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final _ReferenceKind kind;
}
