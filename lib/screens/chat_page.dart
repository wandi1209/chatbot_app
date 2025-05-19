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
        backgroundColor: Colors.grey.shade400,
      ),
      body: Column(
        children: [
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
