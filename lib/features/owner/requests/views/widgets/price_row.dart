
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class PriceRow extends StatelessWidget {
  final dynamic price;

  const PriceRow({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.attach_money_rounded, size: 20, color: AppColors.kPrimaryColor),
        const SizedBox(width: 8),
        Text(
          '${price ?? '–'} EGP / month',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

