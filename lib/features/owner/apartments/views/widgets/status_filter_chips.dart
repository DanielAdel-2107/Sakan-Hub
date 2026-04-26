import 'package:flutter/material.dart';
import 'package:sakan/features/owner/apartments/views/widgets/filter_chip_item.dart';

class StatusFilterChips extends StatelessWidget {
  final String? selectedStatus;
  final ValueChanged<String?> onStatusSelected;

  const StatusFilterChips({super.key, 
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChipItem(label: 'All', value: null, selectedValue: selectedStatus, onSelected: onStatusSelected),
            const SizedBox(width: 12),
            FilterChipItem(label: 'Available', value: 'available', selectedValue: selectedStatus, onSelected: onStatusSelected),
            const SizedBox(width: 12),
            FilterChipItem(label: 'Rented', value: 'rented', selectedValue: selectedStatus, onSelected: onStatusSelected),
          ],
        ),
      ),
    );
  }
}

