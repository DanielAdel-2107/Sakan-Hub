import 'package:flutter/material.dart';

class EmptyApartmentsView extends StatelessWidget {
  const EmptyApartmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.apartment_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text('No Apartments Found', style: TextStyle(fontSize: 20, color: Colors.grey)),
          SizedBox(height: 8),
          Text('Add an apartment to get started', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}