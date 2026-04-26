import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_cubit.dart';
import 'apartment_filter_bottom_sheet.dart'; // ← هتعمله في الخطوة 3

class SearchAndFilterBar extends StatelessWidget {
  const SearchAndFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApartmentsCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: cubit.searchApartments,
                decoration: InputDecoration(
                  hintText: 'Search by apartment name...',
                  hintStyle: TextStyle(color: AppColors.kTextSecondaryColor, fontSize: 15),
                  prefixIcon: Icon(Iconsax.search_normal, color: AppColors.kPrimaryColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 🔥 Filter Button (شيك جداً)
          GestureDetector(
            onTap: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => const ApartmentFilterBottomSheet(),
            ),
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(Iconsax.filter, color: AppColors.kPrimaryColor, size: 26),
            ),
          ),
        ],
      ),
    );
  }
}