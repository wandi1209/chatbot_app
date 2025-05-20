import 'package:chatbot_app/core/theme/colors/app_colors.dart';
import 'package:chatbot_app/widgets/bot_chat_widget.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatbot App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: Icon(Icons.smart_toy, color: Colors.white),
        backgroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20), child: BotChatWidget()),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write your message...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(flex: 1, child: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
