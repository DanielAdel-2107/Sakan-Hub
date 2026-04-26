import 'package:flutter/material.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/constants/app_constants.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/on_boarding/views/widgets/bottom_navigation.dart';
import 'package:sakan/features/on_boarding/views/widgets/on_boarding_page.dart';
import 'package:sakan/features/on_boarding/views/widgets/start_button.dart';

// ignore: must_be_immutable
class OnboardingScreenBody extends StatefulWidget {
  OnboardingScreenBody({super.key, required this.currentIndex});
  int currentIndex;

  @override
  State<OnboardingScreenBody> createState() => _OnboardingScreenBodyState();
}

class _OnboardingScreenBodyState extends State<OnboardingScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// ===== TOP CONTENT =====
          Expanded(
            child: PageView.builder(
              controller: controllerOnBoarding,
              itemCount: AppConstants.onBoardingList.length,
              onPageChanged: (index) {
                setState(() => widget.currentIndex = index);
              },
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: AppConstants.onBoardingList[index].image,
                  title: AppConstants.onBoardingList[index].title,
                  subTitle: AppConstants.onBoardingList[index].subTitle,
                );
              },
            ),
          ),

          /// ===== BOTTOM SECTION =====
          Container(
            color: AppColors.kPrimaryColor,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 18,
              top: 16,
            ),
            child: widget.currentIndex == AppConstants.onBoardingList.length - 1
                ? StartButton()
                : BottomNavigation(
                    currentIndex: widget.currentIndex,
                    onNext: () {
                      controllerOnBoarding.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
