import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/chat/models/chat_model.dart';
import 'package:sakan/features/student/chat/views/screens/chat_screen.dart';
import 'package:sakan/features/student/home/apartment/models/owner_model.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_cubit.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonInfo extends StatelessWidget {
  const PersonInfo({super.key, required this.owner, this.apartmentId});

  final Owner owner;
  final String? apartmentId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is ChatSuccess) {
          // روح لشاشة الشات
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(
                  chatModel: ChatModel(
                    roomId: state.roomId,
                    userImage: owner.imageUrl ?? '',
                    userName: owner.fullName,
                  ),
                );
              },
            ),
          );
        } else if (state is ChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                owner.imageUrl ??
                    'https://via.placeholder.com/150?text=No+Image',
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  owner.fullName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Text("2h ago", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const Spacer(),
            if (state is ChatLoading)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              )
            else
              TextButton(
                onPressed: () {
                  final studentId =
                      Supabase.instance.client.auth.currentUser?.id;

                  if (studentId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("يرجى تسجيل الدخول أولاً")),
                    );
                    return;
                  }

                  context.read<BookingCubit>().startOrOpenChat(
                    studentId: studentId,
                    ownerId: owner.id,
                    ownerName: owner.fullName,
                    ownerImage: owner.imageUrl,
                    apartmentId: apartmentId,
                    initialMessage: "مرحبا، أنا مهتم بالشقة، ممكن نتواصل؟",
                  );
                },
                child: const Text(
                  "Contact",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
