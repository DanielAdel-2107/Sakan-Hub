import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class TenantInfoRow extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final DateTime? createdAt;
  final VoidCallback onMessage;

  const TenantInfoRow({super.key, 
    required this.name,
    this.avatarUrl,
    this.createdAt,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.kPrimaryColor.withOpacity(0.15),
          backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty ? NetworkImage(avatarUrl!) : null,
          child: avatarUrl == null || avatarUrl!.isEmpty
              ? Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(fontSize: 22, color: AppColors.kPrimaryColor),
                )
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.kTextPrimaryColor,
                ),
              ),
              if (createdAt != null)
                Text(
                  timeago.format(createdAt!, locale: 'en_short'),
                  style:  TextStyle(fontSize: 13.5, color: AppColors.kTextSecondaryColor),
                ),
            ],
          ),
        ),
        IconButton(
          icon:  Icon(CupertinoIcons.chat_bubble_2, color: AppColors.kPrimaryColor, size: 28),
          tooltip: 'Message tenant',
          onPressed: onMessage,
        ),
      ],
    );
  }
}

