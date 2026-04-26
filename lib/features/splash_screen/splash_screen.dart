import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakan/core/utilies/assets/images/app_images.dart';
import 'package:sakan/features/on_boarding/views/screens/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 247, 247),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Image.asset(AppImages.logoImage, fit: BoxFit.contain)
              .animate()
              .slide(
                duration: 1000.ms,
                begin: const Offset(1, 0),
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: 1000.ms)
              .scale(duration: 1000.ms)
              .then(delay: 300.ms),
        ),
      ),
    );
  }
}
