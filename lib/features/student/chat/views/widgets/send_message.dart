import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({
    super.key,
    required this.onPressed,
    required this.controller,
  });

  final Function()? onPressed;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.01,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.black12,
                hintText: "enter your message",
                suffixIcon: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    color: AppColors.kPrimaryColor,
                    onPressed: onPressed,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: AppColors.kPrimaryColor,

                  )
                )
              ),
              controller: controller,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.mic_none_rounded),
          color: AppColors.kPrimaryColor,
          onPressed: () {
          },
        ),
      ],
    );
  }
}
