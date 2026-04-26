import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';

class ProfileMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPress;
  final Color? textColor;

  const ProfileMenuItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onPress,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 0.005,
        horizontal: SizeConfig.width * 0.02,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
          splashColor: (textColor ?? AppColors.kPrimaryColor).withOpacity(0.08),
          highlightColor: (textColor ?? AppColors.kPrimaryColor).withOpacity(0.05),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.05,
              vertical: SizeConfig.height * 0.02,
            ),
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
              border: Border.all(
                color: Colors.grey.withOpacity(0.08),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.width * 0.02),
                  decoration: BoxDecoration(
                    color: (textColor ?? AppColors.kPrimaryColor).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
                  ),
                  child: Icon(
                    icon,
                    color: textColor ?? AppColors.kPrimaryColor,
                    size: SizeConfig.width * 0.065,
                  ),
                ),
                SizedBox(width: SizeConfig.width * 0.045),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? AppColors.kTextPrimaryColor,
                      fontSize: SizeConfig.width * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.kTextSecondaryColor,
                  size: SizeConfig.width * 0.045,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
