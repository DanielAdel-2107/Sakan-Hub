import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class TimestampText extends StatelessWidget {
  final String timeAgo;

  const TimestampText({super.key, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Text(
      timeAgo,
      style: TextStyle(
        fontSize: 13,
        color: AppColors.kTextSecondaryColor.withOpacity(0.9),
      ),
    );
  }
}