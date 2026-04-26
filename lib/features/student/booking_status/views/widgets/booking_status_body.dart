import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_cubit.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_state.dart';
import 'package:sakan/features/student/my_bookings/models/my_booking_model.dart';
import 'package:sakan/features/student/booking_status/views/widgets/status_stepper.dart';
import 'package:sakan/features/student/home/apartment_details/views/screens/apartment_details_screen.dart';

class BookingStatusBody extends StatelessWidget {
  final MyBookingModel booking;

  const BookingStatusBody({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeader(context),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * 0.03),
                _buildStatusSection()
                    .animate()
                    .fade(duration: 400.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: SizeConfig.height * 0.03),
                _buildApartmentSummary(context)
                    .animate()
                    .fade(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: SizeConfig.height * 0.04),
                _buildActionButtons(context),
                SizedBox(height: SizeConfig.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: SizeConfig.height * 0.35,
          width: double.infinity,
          child: booking.apartment.imageUrls.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: booking.apartment.imageUrls[0],
                  fit: BoxFit.cover,
                )
              : Container(color: Colors.grey[200]),
        ),
        Container(
          height: SizeConfig.height * 0.35,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.height * 0.06,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking ID: #${booking.id.substring(0, 8)}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                booking.apartment.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Request Status',
                style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800),
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 24),
          StatusStepper(status: booking.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    String text = booking.status.toUpperCase();
    
    switch (booking.status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'approved':
        color = AppColors.kSuccessColor;
        break;
      case 'rejected':
        color = AppColors.kErrorColor;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildApartmentSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apartment Summary',
          style: AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ApartmentDetailsScreen(apartment: booking.apartment),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.kCardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: booking.apartment.imageUrls.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: booking.apartment.imageUrls[0],
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      )
                    : Container(width: 70, height: 70, color: Colors.grey[200]),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.apartment.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '${booking.apartment.price} / month',
                        style: TextStyle(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              booking.apartment.description,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MyBookingsCubit, MyBookingsState>(
          builder: (context, state) {
            return CustomButton(
              text: 'Message Owner',
              onTap: () {
                context.read<MyBookingsCubit>().openChat(booking);
              },
              color: AppColors.kPrimaryColor,
              isLoading: state.status == MyBookingsStatus.chatLoading,
            );
          },
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            side: BorderSide(color: Colors.grey.withOpacity(0.3)),
          ),
          child: const Text('Cancel Request', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}
