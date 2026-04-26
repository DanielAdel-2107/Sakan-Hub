import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class Conditions extends StatelessWidget {
  const Conditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'By continuing Sign up you agree to the following',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 13, color: AppColors.kPrimaryColor),
            ),
            Text(
              ' without reservation',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
