// --- الدالة السحرية لبناء العناصر ---
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

Widget buildNavItem(
  int index,
  IconData icon,
  int selectedIndex,
  Function(int) onTap,
) {
  // هل هذا الزر هو المختار حالياً؟
  bool isSelected = selectedIndex == index;

  return GestureDetector(
    onTap: () => onTap(index), // استدعاء دالة التغيير عند الضغط
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300), // سرعة التحول للون الأخضر
      curve: Curves.easeInOut,
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        // يتغير اللون للأخضر فقط إذا كان isSelected = true
        color: isSelected ? AppColors.kPrimaryColor : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        // يتغير لون الأيقونة للأبيض إذا كانت مختارة
        color: isSelected ? Colors.white : Colors.grey,
        size: isSelected ? 28 : 24,
      ),
    ),
  );
}
