import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_cubit.dart';
import 'package:sakan/features/student/booking_request/view_models/booking_request_cubit/booking_request_state.dart';
import 'package:sakan/features/student/booking_request/views/widgets/apartment_summary_card.dart';
import 'package:sakan/features/student/booking_request/views/widgets/booking_status_widget.dart';
import 'package:sakan/features/student/booking_request/views/widgets/confirm_booking_button.dart';

class BookingRequestScreenBody extends StatelessWidget {
  const BookingRequestScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingRequestCubit, BookingRequestState>(
      listener: (context, state) {
        if (state is BookingRequestSuccess) {
          CustomQuickAlert.showSuccess(context, message: state.message);
        } else if (state is BookingRequestError) {
          CustomQuickAlert.showError(context, message: state.message);
        }
      },
      child: BlocBuilder<BookingRequestCubit, BookingRequestState>(
        builder: (context, state) {
          if (state is BookingRequestLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookingRequestLoaded) {
            final booking = state.bookingRequest;
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.05,
                vertical: SizeConfig.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ApartmentSummaryCard(apartment: booking.apartment),
                  SizedBox(height: SizeConfig.height * 0.03),
                  BookingStatusWidget(status: booking.status),
                  SizedBox(height: SizeConfig.height * 0.04),
                  if (booking.status == 'pending')
                    ConfirmBookingButton(bookingId: booking.id ?? ''),
                  SizedBox(height: SizeConfig.height * 0.05),
                ],
              ),
            );
          } else if (state is BookingRequestError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
