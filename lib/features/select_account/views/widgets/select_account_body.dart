import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/select_account/views/widgets/bottom_section.dart';
import 'package:sakan/features/select_account/views/widgets/top_section.dart';

class SelectAccountBody extends StatelessWidget {
  const SelectAccountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white,
              Colors.white, // الشمال
              AppColors.kPrimaryColor, // اليمين
              AppColors.kPrimaryColor,
            ],
          ),
        ),
        child: Column(children: [TopSection(), BottomSection()]),
      ),
    );
  }
}
