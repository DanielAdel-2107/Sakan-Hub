
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class EmptyChatsView extends StatelessWidget {
  const EmptyChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 100,
            color: AppColors.kPrimaryColor.withOpacity(0.35),
          ),
          const SizedBox(height: 32),
          Text(
            'No chats yet',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.kTextPrimaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'When a tenant contacts you about an apartment, the chat will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.kTextSecondaryColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

