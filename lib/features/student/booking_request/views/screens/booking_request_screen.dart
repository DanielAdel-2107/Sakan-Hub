import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_cubit.dart';
import 'package:sakan/features/student/booking_request/views/widgets/booking_request_screen_body.dart';

class BookingRequestScreen extends StatelessWidget {
  final String bookingId;

  const BookingRequestScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingRequestCubit()..loadBookingRequest(bookingId),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: _buildAppBar(context),
        body: const BookingRequestScreenBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.kTextPrimaryColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Booking Details',
        style: TextStyle(
          color: AppColors.kTextPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}
