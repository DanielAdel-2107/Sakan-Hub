import 'package:flutter/material.dart';

class ImageSliderWidget extends StatelessWidget {
  final List<String> imagesUrl;
  final int currentPage;
  final Function(int) onPageChanged;

  const ImageSliderWidget({
    super.key,
    required this.imagesUrl,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // السلايدر
        SizedBox(
          height: 200,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: PageView.builder(
              itemCount: imagesUrl.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) =>
                  Image.network(imagesUrl[index], fit: BoxFit.cover),
            ),
          ),
        ),
        // التعتيم الخفيف خلف النقاط
        IgnorePointer(
          ignoring: true,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
        // النقاط (Indicator)
        Positioned(
          bottom: 12,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imagesUrl.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: currentPage == index ? 8 : 6,
                width: currentPage == index ? 8 : 6,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
