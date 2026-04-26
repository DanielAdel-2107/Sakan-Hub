import 'package:flutter/material.dart';

class TextPriceBar extends StatelessWidget {
  const TextPriceBar({super.key, required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "\$$price",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const TextSpan(
            text: " / night",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
