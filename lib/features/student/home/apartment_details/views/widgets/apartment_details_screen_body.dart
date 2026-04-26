import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/Bar_section/details_booking_bar.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/details_section/details_host_info.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/image_section/details_image_header.dart';

class ApartmentDetailsScreenBody extends StatefulWidget {
  final ApartmentModel apartment;
  const ApartmentDetailsScreenBody({super.key, required this.apartment});

  @override
  State<ApartmentDetailsScreenBody> createState() =>
      _ApartmentDetailsScreenBodyState();
}

class _ApartmentDetailsScreenBodyState
    extends State<ApartmentDetailsScreenBody> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsImageHeader(
                  imagesUrl: widget.apartment.imageUrls,
                  apartmentId: widget.apartment.id,
                  currentPage: _currentPage,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                ),
                DetailsHostInfo(
                  description: widget.apartment.description,
                  title: widget.apartment.title,
                  rating: 9.4,
                  owner: widget.apartment.owner,
                  reviews: 160,
                  apartmentId: widget.apartment.id,
                  distance: widget.apartment.distance,
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DetailsBookingBar(
              price: widget.apartment.price.toInt(),
              apartmentId: widget.apartment.id,
            ),
          ),
        ],
      ),
    );
  }
}
