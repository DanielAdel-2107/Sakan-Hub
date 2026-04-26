import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelInfoWidget extends StatelessWidget {
  final String title;
  final String address;
  final double rating;
  final int reviews;
  final int price;
  final double distance;

  const HotelInfoWidget({
    super.key,
    required this.title,
    required this.address,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // العنوان والتقييم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.merriweather(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 30),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFBC02D), size: 18),
                  Text(
                    " $rating",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " ($reviews)",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            overflow: TextOverflow.ellipsis,
            address,
            style: GoogleFonts.lato(color: Colors.grey, fontSize: 14),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          // السعر والمسافة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "\$$price",
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " / night",
                      style: GoogleFonts.lato(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                '${distance.toStringAsFixed(1)} km',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
