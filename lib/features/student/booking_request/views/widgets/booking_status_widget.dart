import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';

class BookingStatusWidget extends StatelessWidget {
  final String status;

  const BookingStatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = AppColors.kSuccessColor;
        statusIcon = Icons.check_circle_rounded;
        statusText = 'Approved';
        break;
      case 'rejected':
        statusColor = AppColors.kErrorColor;
        statusIcon = Icons.cancel_rounded;
        statusText = 'Rejected';
        break;
      case 'pending':
      default:
        statusColor = AppColors.kAccentColor;
        statusIcon = Icons.hourglass_empty_rounded;
        statusText = 'Pending Approval';
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(SizeConfig.width * 0.05),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: statusColor.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, size: 48, color: statusColor),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1500.ms),
          SizedBox(height: SizeConfig.height * 0.02),
          Text(
            statusText,
            style: AppTextStyles.heading2.copyWith(color: statusColor),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          SizedBox(height: SizeConfig.height * 0.01),
          Text(
            _getStatusDescription(status),
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(height: 1.5),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return 'Congratulations! Your booking request has been approved by the owner. You can now proceed with the next steps.';
      case 'rejected':
        return 'We are sorry, but your booking request was not accepted at this time. You can try searching for other apartments.';
      case 'pending':
      default:
        return 'Your request is currently being reviewed by the apartment owner. We will notify you once there is an update.';
    }
  }
}
