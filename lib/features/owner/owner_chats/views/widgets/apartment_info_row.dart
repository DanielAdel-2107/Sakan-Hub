import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class ApartmentInfoRow extends StatelessWidget {
  final String title;

  const ApartmentInfoRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.apartment_rounded,
          size: 18,
          color: AppColors.kTextSecondaryColor,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
              fontSize: 15,
              color: AppColors.kTextSecondaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

