import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sakan/features/custom_bottom_navBar/widgets/buildNavItem.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex; // رقم الصفحة النشطة
  final Function(int) onTap; // دالة للتنقل عند الضغط

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 40, right: 40),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: const Offset(0, 0.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // استدعاء الدالة لكل زر مع تمرير الـ index الخاص به
          buildNavItem(0, Icons.home_filled, selectedIndex, onTap),
          buildNavItem(1, Iconsax.heart5, selectedIndex, onTap),
          buildNavItem(2, Iconsax.messages_35, selectedIndex, onTap),
          buildNavItem(3, Icons.person, selectedIndex, onTap),
        ],
      ),
    );
  }
}
