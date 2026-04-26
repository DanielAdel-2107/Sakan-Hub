import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';

class AppTextStyles {
  static final TextStyle heading1 = TextStyle(
    fontSize: SizeConfig.width * 0.07,
    fontWeight: FontWeight.w900,
    color: AppColors.kTextPrimaryColor,
    letterSpacing: -0.5,
  );

  static final TextStyle heading2 = TextStyle(
    fontSize: SizeConfig.width * 0.055,
    fontWeight: FontWeight.w700,
    color: AppColors.kTextPrimaryColor,
  );

  static final TextStyle bodyLarge = TextStyle(
    fontSize: SizeConfig.width * 0.045,
    fontWeight: FontWeight.w500,
    color: AppColors.kTextPrimaryColor,
  );

  static final TextStyle bodyMedium = TextStyle(
    fontSize: SizeConfig.width * 0.04,
    fontWeight: FontWeight.normal,
    color: AppColors.kTextPrimaryColor,
  );

  static final TextStyle bodySmall = TextStyle(
    fontSize: SizeConfig.width * 0.035,
    fontWeight: FontWeight.normal,
    color: AppColors.kTextSecondaryColor,
  );

  static final TextStyle labelLarge = TextStyle(
    fontSize: SizeConfig.width * 0.04,
    fontWeight: FontWeight.w600,
    color: AppColors.kWhiteColor,
  );
}
