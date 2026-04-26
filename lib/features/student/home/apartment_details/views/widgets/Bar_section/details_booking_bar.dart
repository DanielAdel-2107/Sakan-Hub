import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/Bar_section/button_booking.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/Bar_section/text_priceBar.dart';

class DetailsBookingBar extends StatelessWidget {
  final int price;
  final String apartmentId;
  const DetailsBookingBar({
    super.key,
    required this.price,
    required this.apartmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextPriceBar(price: price),
          ButtonBooking(apartmentId: apartmentId),
        ],
      ),
    );
  }
}
