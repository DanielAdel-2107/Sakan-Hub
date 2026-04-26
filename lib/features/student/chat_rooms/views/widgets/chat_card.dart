import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import '../../models/chat_room_model.dart';

class ChatCard extends StatelessWidget {
  final ChatRoomModel chatRoom;
  final VoidCallback onTap;

  const ChatCard({super.key, required this.chatRoom, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 30,
              backgroundImage: chatRoom.ownerAvatarUrl != null
                  ? NetworkImage(chatRoom.ownerAvatarUrl!)
                  : null,
              backgroundColor: AppColors.kPrimaryColor.withOpacity(0.1),
              child: chatRoom.ownerAvatarUrl == null
                  ? Icon(Icons.person, color: AppColors.kPrimaryColor)
                  : null,
            ),
            const SizedBox(width: 16),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoom.displayName,
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kTextPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    chatRoom.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: AppColors.kTextSecondaryColor,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            // Icon
            Icon(
              CupertinoIcons.chat_bubble_2_fill,
              color: AppColors.kPrimaryColor,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}