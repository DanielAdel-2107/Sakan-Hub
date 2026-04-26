import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onNext;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Indicators
        Row(
          children: List.generate(3, (index) {
            bool isActive = currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 28 : 12,
              height: 7,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.kBackgroundColor
                    : AppColors.kBackgroundColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          }),
        ),

        /// Next Button
        GestureDetector(
          onTap: onNext,
          child: Container(
            width: 80,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.kBackgroundColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 28,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
