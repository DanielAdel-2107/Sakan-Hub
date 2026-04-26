import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsDescription extends StatefulWidget {
  final String description;

  const DetailsDescription({super.key, required this.description});

  @override
  State<DetailsDescription> createState() => _DetailsDescriptionState();
}

class _DetailsDescriptionState extends State<DetailsDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: RichText(
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded
                  ? TextOverflow.visible
                  : TextOverflow.ellipsis,
              text: TextSpan(
                style: GoogleFonts.lato(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  height: 1.5,
                ),
                children: [TextSpan(text: widget.description)],
              ),
            ),
          ),

          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                isExpanded ? "Show less" : "Show more",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
