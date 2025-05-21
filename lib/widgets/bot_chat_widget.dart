import 'package:chatbot_app/core/configs/assets/app_images.dart';
import 'package:chatbot_app/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BotChatWidget extends StatelessWidget {
  final String message;
  const BotChatWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(AppImages.chatLogo, width: 40),
        SizedBox(width: 10),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(message, style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
