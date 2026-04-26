import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class TitleAuth extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleAuth({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            letterSpacing: -0.5,
            fontSize: 32,
            color: AppColors.kTextPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(fontSize: 14, color: AppColors.kTextSecondaryColor),
        ),
      ],
    );
  }
}
