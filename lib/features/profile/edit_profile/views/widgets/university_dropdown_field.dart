import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/profile/edit_profile/models/university_model.dart';

class UniversityDropdownField extends StatelessWidget {
  final List<UniversityModel> universities;
  final String? selectedId;
  final Function(String?) onChanged;

  const UniversityDropdownField({
    super.key,
    required this.universities,
    this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: selectedId,
      items: universities.map((uni) {
        return DropdownMenuItem<String>(
          value: uni.id,
          child: Text(
            uni.name,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: "Select University",
        prefixIcon: Icon(Icons.school_outlined, color: AppColors.kPrimaryColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.kPrimaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "University is required for students";
        return null;
      },
    );
  }
}
