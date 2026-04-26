import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:sakan/features/student/booking_status/views/screens/booking_status_screen.dart';
import 'package:sakan/features/student/my_bookings/models/my_booking_model.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookingListItem extends StatelessWidget {
  final MyBookingModel booking;

  const BookingListItem({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;
    switch (booking.status.toLowerCase()) {
      case 'approved':
        statusColor = AppColors.kSuccessColor;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'rejected':
        statusColor = AppColors.kErrorColor;
        statusIcon = Icons.cancel_rounded;
        break;
      case 'pending':
      default:
        statusColor = AppColors.kAccentColor;
        statusIcon = Icons.hourglass_top_rounded;
        break;
    }

    return Animate(
      effects: [
        FadeEffect(duration: 400.ms, curve: Curves.easeOut),
        SlideEffect(begin: const Offset(0.2, 0), duration: 400.ms, curve: Curves.easeOut),
      ],
      child: GestureDetector(
        onTap: () {
          final cubit = context.read<MyBookingsCubit>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: BookingStatusScreen(booking: booking),
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(bottom: SizeConfig.height * 0.015),
          padding: EdgeInsets.all(SizeConfig.width * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.kPrimaryColor.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withOpacity(0.06),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Image Section
              Stack(
                children: [
                  Container(
                    width: SizeConfig.width * 0.22,
                    height: SizeConfig.width * 0.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: booking.apartment.imageUrls.isNotEmpty 
                          ? booking.apartment.imageUrls.first 
                          : '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey[100]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.image_not_supported_rounded),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(statusIcon, size: 14, color: statusColor),
                    ),
                  ),
                ],
              ),
              SizedBox(width: SizeConfig.width * 0.04),
              // Content Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.apartment.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person, size: 12, color: AppColors.kPrimaryColor),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            booking.apartment.owner.fullName,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.kTextSecondaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Status Badge & View Button
                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(statusIcon, size: 12, color: statusColor),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    booking.status.toUpperCase(),
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              final cubit = context.read<MyBookingsCubit>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: cubit,
                                    child: BookingStatusScreen(booking: booking),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'View Details',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Chat Button
              GestureDetector(
                onTap: () => context.read<MyBookingsCubit>().openChat(booking),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.kPrimaryColor, AppColors.kPrimaryColor.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.chat_bubble_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
