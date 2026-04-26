import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ApartmentImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ApartmentImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        color: Colors.grey.shade300,
        child: const Center(child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey)),
      );
    }

    if (imageUrls.length == 1) {
      return Image.network(
        imageUrls.first,
        fit: BoxFit.cover,
        height: 190,
        width: double.infinity,
        loadingBuilder: (_, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        errorBuilder: (_, _, _) => const Center(child: Icon(Icons.broken_image_rounded, size: 50, color: Colors.grey)),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: true,
      ),
      items: imageUrls.map((url) {
        return Image.network(
          url,
          fit: BoxFit.cover,
          width: double.infinity,
          loadingBuilder: (_, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          errorBuilder: (_, _, _) => const Center(child: Icon(Icons.broken_image_rounded, size: 50, color: Colors.grey)),
        );
      }).toList(),
    );
  }
}

