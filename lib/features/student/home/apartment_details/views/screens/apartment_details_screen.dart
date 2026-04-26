import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/apartment_details_screen_body.dart';

class ApartmentDetailsScreen extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentDetailsScreen({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return ApartmentDetailsScreenBody(apartment: apartment);
  }
}
