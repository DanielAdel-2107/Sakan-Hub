import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/apartment_info_row.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/timestamp_text.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/user_avatar.dart';
import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/chat/views/screens/chat_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatRoomTile extends StatelessWidget {
  final Map<String, dynamic> roomData;

  const ChatRoomTile({super.key, required this.roomData});

  @override
  Widget build(BuildContext context) {
    final student = roomData['profiles'] as Map? ?? {};
    final apartment = roomData['apartments!apartment_id'] as Map? ?? {};
    final studentName =
        (student['full_name'] as String?)?.trim() ?? 'Unknown Tenant';
    final avatarUrl = student['image_url'] as String?;
    final aptTitle = (apartment['title'] as String?)?.trim() ?? 'Apartment';
    final createdAt = DateTime.parse(roomData['created_at'] as String);
    final timeAgoStr = timeago.format(createdAt, locale: 'ar_short');
    log(student.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.kPrimaryColor.withOpacity(0.14),
          highlightColor: AppColors.kPrimaryColor.withOpacity(0.06),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  chatModel: ChatModel(
                    roomId: roomData['id'] as String,
                    userImage: avatarUrl ?? '',
                    userName: studentName,
                  ),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAvatar(name: studentName, imageUrl: avatarUrl),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          studentName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kTextPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ApartmentInfoRow(title: aptTitle),
                      ],
                    ),
                  ),
                  TimestampText(timeAgo: timeAgoStr),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
