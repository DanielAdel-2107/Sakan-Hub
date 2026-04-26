import 'package:flutter/material.dart';

import 'package:sakan/features/on_boarding/views/widgets/on_boarding_screen_body.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controllerOnBoarding = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return OnboardingScreenBody(currentIndex: currentIndex);
  }
}
