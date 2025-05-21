import 'package:flutter/material.dart';

class UserChatWidget extends StatelessWidget {
  const UserChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text("Apa yang dimaksud dengan ATOM?"),
        ),
      ],
    );
  }
}
