import 'package:flutter/material.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/select_account/views/screens/select_account.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'START',
      textColor: AppColors.kPrimaryColor,
      color: AppColors.kBackgroundColor,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelectAccount()),
        );
      },
    );
  }
}
