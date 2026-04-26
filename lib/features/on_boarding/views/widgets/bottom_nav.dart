import 'package:flutter/material.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/constants/app_constants.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/on_boarding/views/widgets/bottom_navigation.dart';
import 'package:sakan/features/on_boarding/views/widgets/start_button.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.currentt});

  final int currentt;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.kPrimaryColor,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom + 18,
        top: 16,
      ),
      child: currentt == AppConstants.onBoardingList.length - 1
          ? StartButton()
          : BottomNavigation(
              currentIndex: currentt,
              onNext: () {
                controllerOnBoarding.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
    );
  }
}
