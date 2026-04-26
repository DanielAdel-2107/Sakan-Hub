import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/app_text_form_field.dart';

class ApartmentFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;
  final TextEditingController latController;
  final TextEditingController lngController;
  final bool isAvailable;
  final ValueChanged<bool> onAvailabilityChanged;

  const ApartmentFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.priceController,
    required this.latController,
    required this.lngController,
    required this.isAvailable,
    required this.onAvailabilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextFormField(
          controller: titleController,
          label: 'Title',
          icon: Icons.apartment_rounded,
          validator: (v) => v?.trim().isEmpty ?? true ? 'مطلوب' : null,
        ),
        const SizedBox(height: 20),
        AppTextFormField(
          controller: descriptionController,
          label: 'Description',
          icon: Icons.description_rounded,
          maxLines: 5,
          validator: (v) => v?.trim().isEmpty ?? true ? 'مطلوب' : null,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextFormField(
                controller: priceController,
                label: 'Price (EGP)',
                icon: Icons.attach_money_rounded,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final num = double.tryParse(v);
                  if (num == null) return 'Please enter a valid number';
                  if (num <= 0) return 'Please enter a positive number';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SwitchListTile(
                title: const Text('Available', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                value: isAvailable,
                activeThumbColor: AppColors.kSuccessColor,
                contentPadding: EdgeInsets.zero,
                onChanged: onAvailabilityChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  String? _validateCoord(String? v, String label, double min, double max) {
    if (v == null || v.isEmpty) return 'مطلوب';
    final val = double.tryParse(v);
    if (val == null) return 'رقم صحيح';
    if (val < min || val > max) return 'النطاق: $min إلى $max';
    return null;
  }
}

