import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';

class StatusStepper extends StatelessWidget {
  final String status;

  const StatusStepper({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildStep(
          title: 'Booking Submitted',
          subtitle: 'Your request has been sent to the owner.',
          icon: Icons.send_rounded,
          isCompleted: true,
          isActive: status == 'pending',
          isLast: false,
        ),
        _buildStep(
          title: 'Owner Reviewing',
          subtitle: 'The owner is checking your profile and request.',
          icon: Icons.rate_review_rounded,
          isCompleted: status == 'approved' || status == 'rejected',
          isActive: status == 'pending',
          isLast: false,
        ),
        _buildStep(
          title: status == 'rejected' ? 'Request Rejected' : 'Final Decision',
          subtitle: status == 'approved' 
            ? 'Congratulations! Your booking is approved.' 
            : status == 'rejected' 
              ? 'Unfortunately, your request was declined.' 
              : 'Waiting for final confirmation.',
          icon: status == 'approved' ? Icons.check_circle_rounded : status == 'rejected' ? Icons.cancel_rounded : Icons.pending_rounded,
          isCompleted: status == 'approved' || status == 'rejected',
          isActive: status == 'approved' || status == 'rejected',
          isLast: true,
          color: status == 'approved' ? AppColors.kSuccessColor : status == 'rejected' ? AppColors.kErrorColor : null,
        ),
      ],
    );
  }

  Widget _buildStep({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isCompleted,
    required bool isActive,
    required bool isLast,
    Color? color,
  }) {
    final stepColor = color ?? (isCompleted ? AppColors.kPrimaryColor : Colors.grey.withOpacity(0.3));
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: stepColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? stepColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Icon(icon, color: stepColor, size: 20),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: isCompleted ? AppColors.kPrimaryColor : Colors.grey.withOpacity(0.2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isActive ? Colors.black : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.kTextSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
