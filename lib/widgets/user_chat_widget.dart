import 'package:flutter/material.dart';

class UserChatWidget extends StatelessWidget {
  final String message;
  const UserChatWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(message, style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
