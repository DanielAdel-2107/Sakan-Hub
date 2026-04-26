import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/assets/images/app_images.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.logoImage,
        fit: BoxFit.contain,
        height: SizeConfig.width * 0.55,
      ),
    );
  }
}
