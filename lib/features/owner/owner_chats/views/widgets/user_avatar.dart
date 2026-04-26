
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;

  const UserAvatar({super.key, required this.name, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty ? NetworkImage(imageUrl!) : null,
      backgroundColor: AppColors.kPrimaryColor.withOpacity(0.12),
      child: imageUrl == null || imageUrl!.isEmpty
          ? Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.kPrimaryColor,
              ),
            )
          : null,
    );
  }
}

