import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';

class ImagNameSection extends StatelessWidget {
  const ImagNameSection({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    this.onEditPressed,
  });

  final String name;
  final String email;
  final String imageUrl;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: SizeConfig.width * 0.35,
                height: SizeConfig.width * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.kPrimaryColor.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
              Container(
                width: SizeConfig.width * 0.31,
                height: SizeConfig.width * 0.31,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.kPrimaryColor, AppColors.kSecondaryColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kPrimaryColor.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.white, child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: InkWell(
                  onTap: onEditPressed,
                  borderRadius: BorderRadius.circular(SizeConfig.width * 0.045),
                  child: Container(
                    height: SizeConfig.width * 0.09,
                    width: SizeConfig.width * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      color: AppColors.kPrimaryColor,
                      size: SizeConfig.width * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.02),
        Text(
          name,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: SizeConfig.width * 0.06,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          email,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.kTextSecondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: SizeConfig.width * 0.035,
          ),
        ),
      ],
    );
  }
}
