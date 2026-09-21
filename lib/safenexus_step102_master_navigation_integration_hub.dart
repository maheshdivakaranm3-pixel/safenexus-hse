import 'package:flutter/material.dart';
import 'abu_dhabi_gold_root_page.dart';

/// SafeNexus HSE — Step 102 Master Navigation Integration Hub.
/// Connects the main dashboard modules to the new Abu Dhabi Gold Root page.
class SafenexusStep102MasterNavigationIntegrationHub extends StatelessWidget {
  const SafenexusStep102MasterNavigationIntegrationHub({super.key});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Navigation Hub (Step 102)'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Enterprise HSE Modules Hub',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              leading: CircleAvatar(
                backgroundColor: primaryGreen.withValues(alpha: 0.10),
                child: const Icon(
                  Icons.location_city_rounded,
                  color: primaryGreen,
                ),
              ),
              title: const Text(
                'Abu Dhabi HSE Gold Standard',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: darkGreen,
                  fontSize: 16,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Access verified ADPHC Code of Practice & Gold Standard field references.',
                ),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                // Navigates strictly to the new Abu Dhabi Gold Root Page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AbuDhabiGoldRootPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
