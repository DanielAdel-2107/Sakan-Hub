import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.kTextPrimaryColor,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Last updated: April 26, 2026",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              "At Sakan Hub, we take your privacy seriously. This policy describes how we collect, use, and handle your personal information when you use our services.",
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              "1. Information Collection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We collect information you provide directly to us, such as your name, email address, phone number, and any other information you choose to provide.",
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              "2. Use of Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "We use the information we collect to provide, maintain, and improve our services, to communicate with you, and to protect Sakan Hub and our users.",
              style: TextStyle(height: 1.6),
            ),
            // Add more sections as needed
          ],
        ),
      ),
    );
  }
}
