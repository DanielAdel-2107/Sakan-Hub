import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.kPrimaryColor,
      strokeWidth: 3,
    );
  }
}

