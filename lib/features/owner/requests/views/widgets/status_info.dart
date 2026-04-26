import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class StatusInfo {
  final Color color;
  final IconData icon;
  final String label;

  StatusInfo(this.color, this.icon, this.label);

  factory StatusInfo.fromString(String status) {
    switch (status) {
      case 'pending':
        return StatusInfo(AppColors.kAccentColor, Icons.hourglass_top_rounded, 'Pending');
      case 'approved':
        return StatusInfo(AppColors.kSuccessColor, Icons.check_circle, 'Approved');
      case 'rejected':
        return StatusInfo(AppColors.kErrorColor, Icons.cancel, 'Rejected');
      default:
        return StatusInfo(AppColors.kTextSecondaryColor, Icons.help_outline_rounded, status.toUpperCase());
    }
  }
}

