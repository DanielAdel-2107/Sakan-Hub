import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/helper/show_custom_dialog.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/auth/sign_up/models/profile_model.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_cubit.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_state.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/hotel_card/hotel_card_body.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/search_bar_widget.dart';
import 'package:sakan/features/student/home/apartment_details/views/screens/apartment_details_screen.dart';
import 'package:iconsax/iconsax.dart'; // ← أضفته لو مفيش، عشان Iconsax.home في الـ empty state

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.kPrimaryColor.withOpacity(0.95),
                  AppColors.kPrimaryColor.withOpacity(0.85),
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning,',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${profileModel.fullName} 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Find your perfect student apartment in Cairo',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    image: DecorationImage(
                      image: NetworkImage(
                        profileModel.imageUrl ??
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                      ), // صورة بروفايل
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==================== SEARCH BAR المحسن ====================
          const SearchAndFilterBar(),

          // ==================== القائمة ====================
          Expanded(
            child: BlocConsumer<ApartmentsCubit, ApartmentsState>(
              listener: (context, state) {
                if (state is ApartmentsError) {
                  log('Error: ${state.message}');
                  showCustomDialog(
                    title: 'Error',
                    description: 'Something went wrong, please try again',
                    dialogType: DialogType.error,
                    btnOkColor: AppColors.kErrorColor,
                  );
                }
              },
              builder: (context, state) {
                if (state is ApartmentsLoading || state is ApartmentsInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ),
                  );
                } else if (state is ApartmentsSuccess) {
                  if (state.apartments.isEmpty) {
                    return _buildEmptyState(context);
                  }

                  return RefreshIndicator(
                    color: AppColors.kPrimaryColor,
                    onRefresh: () =>
                        context.read<ApartmentsCubit>().fetchApartments(),
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                      itemCount: state.apartments.length,
                      itemBuilder: (context, index) {
                        final apartment = state.apartments[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ApartmentDetailsScreen(
                                  apartment: apartment,
                                ),
                              ),
                            ).then((_) {
                              if (context.mounted) {
                                context
                                    .read<ApartmentsCubit>()
                                    .fetchApartments();
                              }
                            });
                          },
                          child: ApartmentCard(
                            id: apartment.id,
                            imagesUrl: apartment.imageUrls,
                            title: apartment.title,
                            description: apartment.description,
                            ownerName: apartment.owner.fullName,
                            price: apartment.price.toInt(),
                            distance: apartment.distance,
                            isAvailable: apartment.isAvailable,
                          ),
                        );
                      },
                    ),
                  );
                }
                return _buildEmptyState(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.home,
              size: 90,
              color: AppColors.kPrimaryColor.withOpacity(0.4),
            ),
            const SizedBox(height: 24),
            Text(
              "No apartments found",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.kTextPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "It looks like there are no available apartments right now.\nTry changing your filters or come back later!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppColors.kTextSecondaryColor,
                ),
              ),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () {
                context.read<ApartmentsCubit>().fetchApartments();
              },
              icon: const Icon(Iconsax.refresh, size: 20),
              label: const Text("Refresh"),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.kPrimaryColor),
                foregroundColor: AppColors.kPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}