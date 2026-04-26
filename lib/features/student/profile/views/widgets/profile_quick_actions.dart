import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:sakan/features/student/my_bookings/views/screens/my_bookings_screen.dart';
import 'package:sakan/features/student/favorites/views/screens/favorites_screen.dart';

class ProfileQuickActions extends StatelessWidget {
  const ProfileQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            context,
            title: 'My Bookings',
            subtitle: 'Check status',
            icon: Icons.bookmark_added_rounded,
            color: AppColors.kPrimaryColor,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyBookingsScreen()),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.04),
        Expanded(
          child: _buildActionCard(
            context,
            title: 'Favorites',
            subtitle: 'Saved homes',
            icon: Icons.favorite_rounded,
            color: AppColors.kSecondaryColor,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesScreen()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(height: SizeConfig.height * 0.015),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.kTextSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
