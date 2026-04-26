import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class LocationRow extends StatelessWidget {
  final String location;

  const LocationRow({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_rounded, size: 18, color: AppColors.kTextSecondaryColor),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            location,
            style: TextStyle(fontSize: 15, color: AppColors.kTextSecondaryColor, height: 1.3),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

