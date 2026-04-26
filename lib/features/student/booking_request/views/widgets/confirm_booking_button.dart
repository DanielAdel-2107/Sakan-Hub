import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_cubit.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_state.dart';

class ConfirmBookingButton extends StatelessWidget {
  final String bookingId;

  const ConfirmBookingButton({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingRequestCubit, BookingRequestState>(
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            context.read<BookingRequestCubit>().confirmBooking(bookingId);
          },
          text: 'Confirm Booking',
          color: AppColors.kPrimaryColor,
          isLoading: state is BookingRequestLoading,
        );
      },
    );
  }
}
