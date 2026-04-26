import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CircleButtonFavorit extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const CircleButtonFavorit({
    super.key,
    required this.onTap,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Iconsax.heart5,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 22,
        ),
      ),
    );
  }
}
