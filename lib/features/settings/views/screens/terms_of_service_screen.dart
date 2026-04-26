import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Service"),
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
              "Terms of Service",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Last updated: April 26, 2026",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              "By using Sakan Hub, you agree to these terms. Please read them carefully.",
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              "1. Acceptance of Terms",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "By accessing or using our services, you agree to be bound by these Terms of Service and all applicable laws and regulations.",
              style: TextStyle(height: 1.6),
            ),
            SizedBox(height: 24),
            Text(
              "2. User Responsibilities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer or mobile device.",
              style: TextStyle(height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
