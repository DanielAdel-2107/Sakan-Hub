import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/requests/view_models/cubit/owner_requests_cubit.dart';

class ActionButtons extends StatelessWidget {
  final String status;
  final String bookingId;

  const ActionButtons({super.key, 
    required this.status,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status == 'pending';
    final cubit = context.read<OwnerRequestsCubit>();

    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            icon: const Icon(Icons.check_rounded, size: 20),
            label: const Text('Approve', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.kSuccessColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: AppColors.kSuccessColor.withOpacity(0.5),
            ),
            onPressed: isPending ? () => cubit.changeStatus(bookingId, 'approved') : null,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.close_rounded, size: 20),
            label: const Text('Reject', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.kErrorColor,
              side: BorderSide(color: AppColors.kErrorColor, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledForegroundColor: AppColors.kErrorColor.withOpacity(0.5),
            ),
            onPressed: isPending ? () => cubit.changeStatus(bookingId, 'rejected') : null,
          ),
        ),
      ],
    );
  }
}