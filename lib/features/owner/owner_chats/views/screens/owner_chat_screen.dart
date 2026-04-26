import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/owner_chats/cubit/chat_rooms_cubit.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/chat_rooms_list.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/empty_chats_view.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/error_message.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/loading_indicator.dart';
import 'package:sakan/features/owner/owner_chats/views/widgets/search_text_field.dart';
import 'package:timeago/timeago.dart' as timeago;

class OwnerChatScreen extends StatefulWidget {
  const OwnerChatScreen({super.key});

  @override
  State<OwnerChatScreen> createState() => _OwnerChatScreenState();
}

class _OwnerChatScreenState extends State<OwnerChatScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatRoomsCubit>().fetchChatRooms();

    _searchController.addListener(() {
      final query = _searchController.text.trim();
      context.read<ChatRoomsCubit>().filterRooms(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.kTextPrimaryColor,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SearchTextField(controller: _searchController),
          ),
        ),
      ),
      body: BlocBuilder<ChatRoomsCubit, ChatRoomsState>(
        builder: (context, state) {
          if (state is ChatRoomsLoading) {
            return const Center(child: LoadingIndicator());
          }

          if (state is ChatRoomsError) {
            return ErrorMessage(message: state.message);
          }

          if (state is ChatRoomsEmpty || (state is ChatRoomsLoaded && state.filteredRooms.isEmpty)) {
            return const EmptyChatsView();
          }

          if (state is ChatRoomsLoaded) {
            return ChatRoomsList(rooms: state.filteredRooms);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

