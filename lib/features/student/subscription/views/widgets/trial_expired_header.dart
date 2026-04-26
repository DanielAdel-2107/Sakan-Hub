import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sakan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';

class TrialExpiredHeader extends StatelessWidget {
  const TrialExpiredHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Premium Curved Background
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: SizeConfig.height * 0.45,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.kPrimaryColor,
                  AppColors.kPrimaryColor.withOpacity(0.8),
                  AppColors.kPrimaryColor.withOpacity(0.6),
                ],
              ),
            ),
          ),
        ),
        
        // Content
        Positioned.fill(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.height * 0.08),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Lottie.asset(
                  AppLotties.verificationLottie,
                  height: SizeConfig.height * 0.15,
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.03),
              Text(
                'Trial expired',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: SizeConfig.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.12),
                child: Text(
                  'Your free usage period has ended. Unlock full access to find your perfect home.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.85),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Back Button
        Positioned(
          top: SizeConfig.height * 0.06,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.2),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
