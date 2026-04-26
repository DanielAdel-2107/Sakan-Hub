import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class HaveAccount extends StatelessWidget {
  final String text;
  final String textButton;
  final void Function()? onTap;

  const HaveAccount({
    super.key,
    required this.text,
    required this.textButton,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 12.5,
            color: AppColors.kTextSecondaryColor,
          ),
        ),

        GestureDetector(
          onTap: onTap,
          child: Text(
            textButton,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
