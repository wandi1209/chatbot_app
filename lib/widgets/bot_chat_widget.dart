import 'package:chatbot_app/core/theme/colors/app_colors.dart';
import 'package:flutter/material.dart';

class BotChatWidget extends StatelessWidget {
  const BotChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text('Loading...'),
        ),
      ],
    );
  }
}
