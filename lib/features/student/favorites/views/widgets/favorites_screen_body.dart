import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/hotel_card/hotel_card_body.dart';
import 'package:sakan/features/student/home/apartment/views/widgets/search_bar_widget.dart';
import 'package:sakan/features/student/home/apartment_details/views/screens/apartment_details_screen.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_cubit.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_state.dart';
import 'package:sakan/features/student/favorites/view_models/cubit/favorites_cubit.dart';
import 'package:sakan/features/student/favorites/view_models/cubit/favorites_state.dart';

class FavoritesScreenBody extends StatelessWidget {
  const FavoritesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SearchAndFilterBar(),
            Expanded(
              child: BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  return BlocBuilder<ApartmentsCubit, ApartmentsState>(
                    builder: (context, aptState) {
                      if (aptState is ApartmentsSuccess) {
                        final favoriteList = aptState.apartments
                            .where((apartment) => favState.favoriteIds.contains(apartment.id))
                            .toList();

                        if (favoriteList.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                                SizedBox(height: 16),
                                Text(
                                  "No favorites added yet.",
                                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: favoriteList.length,
                          itemBuilder: (context, index) {
                            final apartment = favoriteList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ApartmentDetailsScreen(
                                        apartment: apartment,
                                      ),
                                    ),
                                  );
                                },
                                child: ApartmentCard(
                                  key: ValueKey('fav_${apartment.id}'),
                                  id: apartment.id,
                                  imagesUrl: apartment.imageUrls,
                                  title: apartment.title,
                                  description: apartment.description,
                                  price: apartment.price.toInt(),
                                  isAvailable: apartment.isAvailable,
                                  ownerName: apartment.owner.fullName,
                                  distance: apartment.distance,
                                  isFavoriteInitial: true,
                                ),
                              ),
                            );
                          },
                        );
                      } else if (aptState is ApartmentsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (aptState is ApartmentsError) {
                        return const Center(child: Text("Something went wrong"));
                      }
                      return const Center(child: Text("No favorites added yet."));
                    },
                  );
                },
              ),
            ),
            // Add space for bottom nav
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}