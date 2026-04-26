import 'package:flutter/material.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/chat_room_tile.dart';

class ChatRoomsList extends StatelessWidget {
  final List<Map<String, dynamic>> rooms;

  const ChatRoomsList({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return ChatRoomTile(roomData: rooms[index]);
      },
    );
  }
}

