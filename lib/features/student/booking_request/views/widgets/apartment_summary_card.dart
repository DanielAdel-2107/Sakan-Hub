import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ApartmentSummaryCard extends StatefulWidget {
  final ApartmentModel? apartment;

  const ApartmentSummaryCard({super.key, this.apartment});

  @override
  State<ApartmentSummaryCard> createState() => _ApartmentSummaryCardState();
}

class _ApartmentSummaryCardState extends State<ApartmentSummaryCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.apartment == null) return const SizedBox.shrink();
    final apt = widget.apartment!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageCarousel(apt),
          Padding(
            padding: EdgeInsets.all(SizeConfig.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        apt.title,
                        style: AppTextStyles.heading2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildDistanceBadge(apt.distance),
                  ],
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                Text(
                  apt.description,
                  style: AppTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: SizeConfig.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOwnerInfo(apt.owner.fullName),
                    Text(
                      '${apt.price.toInt()} EGP',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.kPrimaryColor,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(ApartmentModel apt) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: SizeConfig.height * 0.25,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => setState(() => _currentIndex = index),
          ),
          items: apt.imageUrls.map((url) {
            return Builder(
              builder: (BuildContext context) {
                return Hero(
                  tag: 'apt_${apt.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported_rounded),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${_currentIndex + 1}/${apt.imageUrls.length}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDistanceBadge(double distance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_walk_rounded, size: 14, color: AppColors.kPrimaryColor),
          const SizedBox(width: 4),
          Text(
            '${distance.toStringAsFixed(1)} km',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildOwnerInfo(String name) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.kPrimaryColor.withOpacity(0.2),
          child: Icon(Icons.person, size: 16, color: AppColors.kPrimaryColor),
        ),
        const SizedBox(width: 8),
        Text(name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
