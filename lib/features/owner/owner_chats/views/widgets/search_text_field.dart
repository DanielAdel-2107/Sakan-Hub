import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 16, color: AppColors.kTextPrimaryColor),
      decoration: InputDecoration(
        hintText: 'Search by tenant name or property...',
        hintStyle: TextStyle(
          color: AppColors.kTextSecondaryColor.withOpacity(0.7),
          fontSize: 15,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.kPrimaryColor,
          size: 26,
        ),
        filled: true,
        fillColor: AppColors.kWhiteColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.kPrimaryColor, width: 1.8),
        ),
      ),
    );
  }
}

