import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/my_bookings/models/my_booking_model.dart';
import 'package:sakan/features/student/booking_status/views/widgets/booking_status_body.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_cubit.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_state.dart';
import 'package:sakan/features/student/chat/views/screens/chat_screen.dart';

class BookingStatusScreen extends StatelessWidget {
  final MyBookingModel booking;

  const BookingStatusScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyBookingsCubit, MyBookingsState>(
      listener: (context, state) {
        if (state.status == MyBookingsStatus.chatNavigate && state.chatModel != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chatModel: state.chatModel!),
            ),
          );
        } else if (state.status == MyBookingsStatus.error) {
          // You could show an alert here if the chat fails
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FB),
        body: BookingStatusBody(booking: booking),
      ),
    );
  }
}
