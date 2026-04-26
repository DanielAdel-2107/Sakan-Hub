import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/chat/view_models/cubit/chat_cubit.dart';
import 'package:sakan/features/student/chat/views/widgets/custom_loading.dart';
import 'package:sakan/features/student/chat/views/widgets/messages_list_view.dart';
import 'package:sakan/features/student/chat/views/widgets/send_message.dart';

class ChatScrrenBody extends StatelessWidget {
  const ChatScrrenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          final cubit = context.read<ChatCubit>();
          if (state is ChatLoading) {
            CustomLoading();
          }
          if (state is ChatLoaded) {
            return Column(
              children: [
                MessagesListView(
                  messages: state.messages,
                ),
                SendMessage(
                  onPressed: () {
                    cubit.addMessage(text: cubit.messageController.text);
                  },
                  controller: cubit.messageController,
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

