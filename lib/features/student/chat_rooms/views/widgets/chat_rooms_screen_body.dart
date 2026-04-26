import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/chat/views/screens/chat_screen.dart';
import 'package:sakan/features/student/chat_rooms/view_models/chat_rooms_cubit.dart';
import 'package:sakan/features/student/chat_rooms/views/widgets/chat_card.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/search_bar_widget.dart';

class ChatRoomsScreenBody extends StatelessWidget {
  const ChatRoomsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SearchAndFilterBar(),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<ChatRoomsCubit, ChatRoomsState>(
                builder: (context, state) {
                  if (state is ChatRoomsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ),
                    );
                  }

                  if (state is ChatRoomsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text('حدث خطأ: ${state.message}'),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<ChatRoomsCubit>().fetchChatRooms(),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is ChatRoomsLoaded) {
                    if (state.chatRooms.isEmpty) {
                      return Center(
                        child: Text(
                          'No Chat rooms yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.kTextSecondaryColor,
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async =>
                          context.read<ChatRoomsCubit>().fetchChatRooms(),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        itemCount: state.chatRooms.length,
                        itemBuilder: (context, index) {
                          final room = state.chatRooms[index];
                          return ChatCard(
                            chatRoom: room,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) {
                                    return ChatScreen(
                                      chatModel: ChatModel(
                                        roomId: room.id,
                                        userImage: room.ownerAvatarUrl!,
                                        userName: room.ownerFullName!,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
