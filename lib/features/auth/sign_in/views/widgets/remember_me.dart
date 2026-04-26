import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_box_outlined, color: AppColors.kTextSecondaryColor),
        SizedBox(width: 5),
        Text(
          'Remember me',
          style: TextStyle(fontSize: 13, color: AppColors.kTextSecondaryColor),
        ),
        Spacer(),
        Text(
          'Forgot password',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.kTextPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
