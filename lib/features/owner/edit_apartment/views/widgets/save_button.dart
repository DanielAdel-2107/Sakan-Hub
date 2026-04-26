import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class SaveButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.save_rounded, size: 24),
              label: const Text('Save changes', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kPrimaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
    );
  }
}