import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/amenity_icon.dart';

class AmenityBody extends StatelessWidget {
  const AmenityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AmenityIcon(icon: Icons.wifi, label: "Wi-Fi"),
        AmenityIcon(icon: Icons.directions_car, label: "Free Parking"),
        AmenityIcon(icon: Icons.flatware, label: "Tableware"),
      ],
    );
  }
}
