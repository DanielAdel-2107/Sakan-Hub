import 'package:flutter/material.dart';

class EditableImageItem extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onRemove;
  final bool isNetwork;

  const EditableImageItem({
    super.key,
    required this.image,
    required this.onRemove,
    required this.isNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(image: image, fit: BoxFit.cover),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
            ),
          ),
        ),
      ],
    );
  }
}

