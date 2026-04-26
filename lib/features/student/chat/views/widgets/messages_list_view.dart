import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/chat/models/message_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});
  final List<ChatMessage> messages;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return BubbleSpecialThree(
            isSender:
                messages[index].id ==
                getIt<SupabaseClient>().auth.currentUser!.id,
            text: messages[index].message,
            color:
                messages[index].id ==
                    getIt<SupabaseClient>().auth.currentUser!.id
                ? AppColors.kPrimaryColor
                : Colors.black12,
            tail: true,
            textStyle:
                messages[index].id ==
                    getIt<SupabaseClient>().auth.currentUser!.id
                ? TextStyle(fontSize: 18, color: Colors.white)
                : TextStyle(fontSize: 18, color: Colors.black54),
          );
        },
      ),
    );
  }
}
