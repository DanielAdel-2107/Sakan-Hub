import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/chat/view_models/cubit/chat_cubit.dart';
import 'package:sakan/features/student/chat/views/widgets/chat_screen_body.dart';
import 'package:sakan/features/student/chat/views/widgets/custom_failure_message.dart';
import 'package:sakan/features/student/chat/views/widgets/custom_loading.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    // final chatId = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
      create: (context) => ChatCubit(id: chatModel.roomId),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatFailed) {
            return Scaffold(
              body: CustomFailureMesage(errorMessage: state.error),
            );
          }
          if (state is ChatLoading) {
            return Scaffold(body: CustomLoading());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.kPrimaryColor,
              foregroundColor: Colors.white,
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: SizeConfig.width * 0.05,
                    backgroundImage: NetworkImage(chatModel.userImage),
                  ),
                  SizedBox(width: SizeConfig.width * 0.02),
                  Expanded(
                    child: Text(
                      chatModel.userName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.call),
                  iconSize: SizeConfig.width * 0.06,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.video_call),
                  iconSize: SizeConfig.width * 0.08,
                  onPressed: () {},
                ),
                SizedBox(width: SizeConfig.width * 0.02),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.04,
                vertical: SizeConfig.height * 0.01,
              ),
              decoration: const BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(AppImages.chatBackgroundImage),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: ChatScrrenBody(),
            ),
          );
        },
      ),
    );
  }
}
