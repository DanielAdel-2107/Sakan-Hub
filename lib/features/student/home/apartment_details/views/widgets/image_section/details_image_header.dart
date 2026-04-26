import 'package:flutter/material.dart';
import 'package:sakan/features/student/home/apartment/service/favorite_service.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/image_section/circle_button_back.dart';
import 'package:sakan/features/student/home/apartment_details/views/widgets/image_section/circle_button_favorit.dart';

class DetailsImageHeader extends StatefulWidget {
  final String apartmentId;
  final List<String> imagesUrl;
  final int currentPage;
  final Function(int) onPageChanged;

  const DetailsImageHeader({
    super.key,
    required this.imagesUrl,
    required this.apartmentId,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<DetailsImageHeader> createState() => _DetailsImageHeaderState();
}

class _DetailsImageHeaderState extends State<DetailsImageHeader> {
  bool isFavorite = false; // القيمة الابتدائية
  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus(); // أول ما يشتغل الودجت، يروح يشيك على الحالة
  }

  // دالة لجلب الحالة الحقيقية من الذاكرة
  Future<void> _loadFavoriteStatus() async {
    bool status = await FavoriteService.isFavorite(widget.apartmentId);
    if (mounted) {
      setState(() {
        isFavorite = status;
      });
    }
  }

  // دالة لتبديل الحالة عند الضغط
  Future<void> _handleToggleFavorite() async {
    bool newState = await FavoriteService.toggleFavorite(widget.apartmentId);
    setState(() {
      isFavorite = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // السلايدر
        SizedBox(
          height: 350,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: PageView.builder(
              itemCount: widget.imagesUrl.length,
              onPageChanged: widget.onPageChanged,
              itemBuilder: (context, index) =>
                  Image.network(widget.imagesUrl[index], fit: BoxFit.cover),
            ),
          ),
        ),
        // التعتيم الخفيف خلف النقاط
        IgnorePointer(
          ignoring: true,
          child: Container(
            height: 350,
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
              widget.imagesUrl.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: widget.currentPage == index ? 8 : 6,
                width: widget.currentPage == index ? 8 : 6,
                decoration: BoxDecoration(
                  color: widget.currentPage == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonBack(
                  icon: Icons.arrow_back_ios_new,

                  onPressed: () =>
                      Navigator.pop(context), // widget.onBackPress(),
                ),
                CircleButtonFavorit(
                  onTap: _handleToggleFavorite,
                  isFavorite: isFavorite,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
