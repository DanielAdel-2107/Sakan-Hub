import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_cubit.dart';

class ApartmentFilterBottomSheet extends StatefulWidget {
  const ApartmentFilterBottomSheet({super.key});

  @override
  State<ApartmentFilterBottomSheet> createState() => _ApartmentFilterBottomSheetState();
}

class _ApartmentFilterBottomSheetState extends State<ApartmentFilterBottomSheet> {
  String? selectedUniversityId;
  double currentDistance = 50.0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ApartmentsCubit>();
    selectedUniversityId = cubit.myCollegeId;   // ← default = كليته هو
    currentDistance = cubit.maxDistanceKm;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApartmentsCubit>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Filter Apartments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Iconsax.close_circle, color: AppColors.kTextSecondaryColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 32),

          // University Dropdown (مُصحح الـ overflow)
          const Text("Near University or Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: AppColors.kBackgroundColor, borderRadius: BorderRadius.circular(16)),
            child: DropdownButtonFormField<String?>(
              initialValue: selectedUniversityId,
              isExpanded: true,
              menuMaxHeight: 300,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                prefixIcon: Icon(Iconsax.book_1, color: AppColors.kPrimaryColor),
              ),
              items: [
                const DropdownMenuItem(value: null, child: Text("Near My Location")),
                ...cubit.universities.map((uni) => DropdownMenuItem(
                      value: uni.id,
                      child: Text(uni.name, overflow: TextOverflow.ellipsis),
                    )),
              ],
              onChanged: (value) => setState(() => selectedUniversityId = value),
            ),
          ),

          const SizedBox(height: 32),

          // Distance Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Maximum Distance", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("${currentDistance.toInt()} km", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.kPrimaryColor)),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 7,
              activeTrackColor: AppColors.kPrimaryColor,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: AppColors.kPrimaryColor,
              overlayColor: AppColors.kPrimaryColor.withOpacity(0.2),
            ),
            child: Slider(
              value: currentDistance,
              min: 5,
              max: 50,
              divisions: 9,
              label: "${currentDistance.toInt()} km",
              onChanged: (val) => setState(() => currentDistance = val),
            ),
          ),

          const SizedBox(height: 30),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    cubit.resetFilters();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColors.kTextSecondaryColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text("Reset", style: TextStyle(color: AppColors.kTextSecondaryColor)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedUniversityId == null) {
                      await cubit.fetchApartments(); // Near My Location
                    } else {
                      await cubit.fetchApartmentsNearUniversity(selectedUniversityId!);
                    }
                    cubit.setMaxDistance(currentDistance);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Apply Filters", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}