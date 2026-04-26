import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/profile/views/widgets/profile_menu_item.dart';
import 'package:sakan/features/settings/views/screens/about_screen.dart';
import 'package:sakan/features/settings/views/screens/contact_us_screen.dart';
import 'package:sakan/features/settings/views/screens/help_center_screen.dart';
import 'package:sakan/features/settings/views/screens/privacy_policy_screen.dart';
import 'package:sakan/features/settings/views/screens/terms_of_service_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.kTextPrimaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            _buildSectionHeader("Account & App"),
            ProfileMenuItem(
              text: "Help Center",
              icon: Icons.help_outline_rounded,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpCenterScreen(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              text: "Contact Us",
              icon: Icons.support_agent_rounded,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsScreen(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              text: "About Us",
              icon: Icons.info_outline_rounded,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildSectionHeader("Legal"),
            ProfileMenuItem(
              text: "Privacy Policy",
              icon: Icons.privacy_tip_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              text: "Terms of Service",
              icon: Icons.description_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TermsOfServiceScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
