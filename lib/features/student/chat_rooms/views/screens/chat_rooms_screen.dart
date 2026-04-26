import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/chat_rooms/view_models/chat_rooms_cubit.dart';
import 'package:sakan/features/student/chat_rooms/views/widgets/chat_rooms_screen_body.dart';

class ChatRoomsScreen extends StatelessWidget {
  const ChatRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatRoomsCubit()..fetchChatRooms(),
      child: const ChatRoomsScreenBody(),
    );
  }
}