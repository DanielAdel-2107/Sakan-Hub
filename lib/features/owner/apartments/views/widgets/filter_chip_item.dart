import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class FilterChipItem extends StatelessWidget {
  final String label;
  final String? value;
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  const FilterChipItem({super.key, 
    required this.label,
    required this.value,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == value;
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: isSelected ? Colors.white : AppColors.kTextPrimaryColor,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(value),
      selectedColor: AppColors.kPrimaryColor,
      backgroundColor: AppColors.kWhiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(
          color: isSelected ? Colors.transparent : AppColors.kPrimaryColor.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      elevation: isSelected ? 6 : 2,
      shadowColor: AppColors.kPrimaryColor.withOpacity(0.25),
    );
  }
}

