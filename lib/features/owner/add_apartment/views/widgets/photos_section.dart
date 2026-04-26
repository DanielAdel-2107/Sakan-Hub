import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/add_photo_button.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/photo_item.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/section_title.dart';

class PhotosSection extends StatelessWidget {
  final List<XFile> photos;
  final VoidCallback onPickPhotos;
  final void Function(int) onRemovePhoto;
  final int maxPhotos;

  const PhotosSection({
    super.key,
    required this.photos,
    required this.onPickPhotos,
    required this.onRemovePhoto,
    required this.maxPhotos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Photos'),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length + (photos.length < maxPhotos ? 1 : 0),
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              if (index == photos.length) {
                return AddPhotoButton(onTap: onPickPhotos);
              }
              return PhotoItem(
                photo: photos[index],
                index: index,
                onRemove: onRemovePhoto,
              );
            },
          ),
        ),
      ],
    );
  }
}

