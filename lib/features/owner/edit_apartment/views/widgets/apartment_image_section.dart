import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/editable_image_item.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/empty_images_placeholder.dart';

class ApartmentImagesSection extends StatelessWidget {
  final List<String> existingUrls;
  final List<File> newFiles;
  final void Function(int) onRemoveExisting;
  final void Function(int) onRemoveNew;
  final VoidCallback onAddPhotos;

  const ApartmentImagesSection({
    super.key,
    required this.existingUrls,
    required this.newFiles,
    required this.onRemoveExisting,
    required this.onRemoveNew,
    required this.onAddPhotos,
  });

  @override
  Widget build(BuildContext context) {
    final totalImages = existingUrls.length + newFiles.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (totalImages == 0)
          const EmptyImagesPlaceholder()
        else
          CarouselSlider(
            options: CarouselOptions(
              height: 240,
              viewportFraction: 0.92,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              autoPlay: totalImages > 1,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayCurve: Curves.easeInOut,
            ),
            items: [
              ...existingUrls.asMap().entries.map((e) => EditableImageItem(
                    image: NetworkImage(e.value),
                    onRemove: () => onRemoveExisting(e.key),
                    isNetwork: true,
                  )),
              ...newFiles.asMap().entries.map((e) => EditableImageItem(
                    image: FileImage(e.value),
                    onRemove: () => onRemoveNew(e.key),
                    isNetwork: false,
                  )),
            ],
          ),
        const SizedBox(height: 16),
        Center(
          child: OutlinedButton.icon(
            onPressed: onAddPhotos,
            icon: const Icon(Icons.add_photo_alternate_rounded, size: 20),
            label: const Text('Add Photos', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.kPrimaryColor,
              side: BorderSide(color: AppColors.kPrimaryColor),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }
}

