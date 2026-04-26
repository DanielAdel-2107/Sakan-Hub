import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            color: AppColors.kErrorColor,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

