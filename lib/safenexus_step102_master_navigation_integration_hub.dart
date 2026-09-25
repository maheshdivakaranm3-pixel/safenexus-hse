import 'package:flutter/material.dart';

/// SafeNexus HSE — Step 102 Master Navigation Integration Hub.
/// Preserved as part of the existing WorkHub integration layer.
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
                  Icons.menu_book_rounded,
                  color: primaryGreen,
                ),
              ),
              title: const Text(
                'HSE Reference Modules',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: darkGreen,
                  fontSize: 16,
                ),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  'Jurisdiction reference modules are being rebuilt from a clean baseline.',
                ),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('New HSE Reference modules will be added here.'),
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
