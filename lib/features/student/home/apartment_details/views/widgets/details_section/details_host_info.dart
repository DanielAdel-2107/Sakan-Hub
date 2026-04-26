import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment/models/owner_model.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/amenity_body.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/details_description.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/details_map_section.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/details_title.dart';

import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/person_info.dart';

class DetailsHostInfo extends StatelessWidget {
  final String description;
  final String title;
  final double rating;
  final int reviews;
  final double distance;
  final Owner owner;
  final String apartmentId;
  const DetailsHostInfo({
    super.key,
    required this.apartmentId,
    required this.owner,
    required this.description,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              DetailsTitle(
                title: title,
                rating: rating,
                reviews: reviews,
                distance: distance,
              ),
              Divider(),
              const SizedBox(height: 5),
              PersonInfo(
                owner: owner,
                apartmentId: apartmentId,
              ),
              const SizedBox(height: 5),
              Divider(),
              const SizedBox(height: 18),
              AmenityBody(),
              const SizedBox(height: 18),
              Divider(),
              DetailsDescription(description: description),
            ],
          ),
        ),
        const DetailsMapSection(),
      ],
    );
  }
}
