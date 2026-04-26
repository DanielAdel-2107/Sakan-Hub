import 'package:flutter/material.dart';
import 'package:sakan/features/auth/sign_in/views/widgets/SocialButton.dart';

class ContinueWith extends StatelessWidget {
  const ContinueWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(height: 1, color: Colors.grey[350])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  'Or Continue with',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: Colors.grey[350])),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialButton(
              imagePath: 'assets/images/facebook.png',
              onTap: () {
                print("Facebook tapped");
              },
            ),
            SocialButton(
              imagePath: 'assets/images/google.png',
              onTap: () {
                print("Google tapped");
              },
            ),

            SocialButton(
              imagePath: 'assets/images/Twitter.png',
              onTap: () {
                print("Twitter tapped");
              },
            ),
          ],
        ),
      ],
    );
  }
}
