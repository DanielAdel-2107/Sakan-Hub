import 'package:flutter/material.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/app_text_field.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/status_dropdown.dart';

class ApartmentFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final TextEditingController priceController;
  final String? selectedStatus;
  final List<String> statusOptions;
  final ValueChanged<String?> onStatusChanged;

  const ApartmentFormFields({
    super.key,
    required this.titleController,
    required this.descController,
    required this.priceController,
    required this.selectedStatus,
    required this.statusOptions,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          label: 'Title',
          controller: titleController,
          hint: 'Modern 2-Bedroom Apartment',
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Description',
          controller: descController,
          hint: 'Bright, spacious, fully furnished...',
          maxLines: 4,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                label: 'Monthly Price (EGP)',
                controller: priceController,
                hint: '6500',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(Icons.attach_money_rounded),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: StatusDropdown(
                value: selectedStatus,
                items: statusOptions,
                onChanged: onStatusChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

