import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/auth/sign_in/views/screens/sign_in_screen.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'owner',
              color: Colors.white,
              textColor: AppColors.kPrimaryColor,
              onTap: () {
                userRole = 'owner';
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
                log(userRole);
              },
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'student',
              color: Colors.white,
              textColor: AppColors.kPrimaryColor,
              onTap: () {
                userRole = 'student';
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
                log(userRole);
              },
            ),
          ],
        ),
      ),
    );
  }
}
