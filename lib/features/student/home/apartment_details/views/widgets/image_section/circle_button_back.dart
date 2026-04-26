import 'package:flutter/material.dart';

class CircleButtonBack extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CircleButtonBack({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
