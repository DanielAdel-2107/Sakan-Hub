import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_cubit.dart';
import 'package:sakan/features/student/my_bookings/views/widgets/my_bookings_screen_body.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBookingsCubit()..fetchMyBookings(),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: _buildAppBar(),
        body: const MyBookingsScreenBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'My Bookings',
        style: TextStyle(
          color: AppColors.kTextPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
    );
  }
}
