import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/apartments/view_models/cubit/owner_apartments_cubit.dart';
import 'package:sakan/features/owner/apartments/views/widgets/action_button.dart';
import 'package:sakan/features/owner/apartments/views/widgets/apartment_image_carousel.dart';
import 'package:sakan/features/owner/apartments/views/widgets/location_row.dart';
import 'package:sakan/features/owner/apartments/views/widgets/status_badge.dart';
import 'package:sakan/features/owner/edit_apartment/views/screens/edit_apartment_screen.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';

class ApartmentCard extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentCard({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final status = apartment.isAvailable ? 'Available' : 'Rented';
    final statusColor = apartment.isAvailable
        ? AppColors.kSuccessColor
        : AppColors.kErrorColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 24,
            offset: const Offset(0, 10),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            child: Stack(
              children: [
                SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: ApartmentImageCarousel(imageUrls: apartment.imageUrls),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: StatusBadge(status: status, color: statusColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apartment.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: AppColors.kTextPrimaryColor,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                LocationRow(
                  location:
                      '(${apartment.lat.toStringAsFixed(4)}, ${apartment.lng.toStringAsFixed(4)})',
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '\$${apartment.price.toStringAsFixed(0)} / Month',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.kPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Row(
                      children: [
                        ActionButton(
                          icon: Icons.edit_rounded,
                          color: AppColors.kPrimaryColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditApartmentScreen(apartment: apartment),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        ActionButton(
                          icon: Icons.delete_outline_rounded,
                          color: AppColors.kErrorColor,
                          onTap: () => _confirmAndDelete(context, apartment.id),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmAndDelete(
    BuildContext context,
    String apartmentId,
  ) {
    CustomQuickAlert.showConfirmation(
      context,
      message: 'Are you sure you want to delete this apartment?',
      confirmBtnText: 'Delete',
      onConfirm: () {
        context.read<OwnerApartmentsCubit>().deleteApartment(apartmentId);
      },
    );
  }
}