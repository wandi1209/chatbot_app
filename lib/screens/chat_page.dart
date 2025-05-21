import 'package:chatbot_app/core/configs/theme/app_colors.dart';
import 'package:chatbot_app/models/chat_message_model.dart';
import 'package:chatbot_app/widgets/bot_chat_widget.dart';
import 'package:chatbot_app/widgets/user_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController message = TextEditingController();
  List<ChatMessageModel> chats = [];

  @override
  void initState() {
    _openHiveBox();
    super.initState();
  }

  void _openHiveBox() async {
    var box = await Hive.openBox('chats');
    chats = box.get('chats')?.cast<ChatMessageModel>() ?? [];
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  void _sendPrompt(String message) async {
    var box = await Hive.openBox('chats');
    List<ChatMessageModel> savedChats =
        box.get('chats')?.cast<ChatMessageModel>() ?? [];

    savedChats.add(
      ChatMessageModel(
        message: message,
        isBot: false,
        timestamp: DateTime.now(),
      ),
    );

    await box.put('chats', savedChats);

    setState(() {
      chats = savedChats;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatbot App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.accent,
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                ChatMessageModel data = chats[index];
                if (chats.isEmpty) {
                  return Text("No message available");
                }
                if (data.isBot) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: BotChatWidget(message: data.message),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: UserChatWidget(message: data.message),
                  );
                }
              },
            ),
          ),
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
                    controller: message,
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
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (message.text.trim().isNotEmpty) {
                        _sendPrompt(message.text.trim());
                        message.clear();
                      }
                    },
                    child: Icon(Icons.send, color: AppColors.accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
