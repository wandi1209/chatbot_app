import 'package:chatbot_app/core/configs/theme/app_colors.dart';
import 'package:chatbot_app/models/chat_message_model.dart';
import 'package:chatbot_app/services/api_service.dart';
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
  final apiService = ApiService();
  TextEditingController message = TextEditingController();
  List<ChatMessageModel> chats = [];
  bool isLoading = false;

  @override
  void initState() {
    _openHiveBox();
    super.initState();
  }

  void _openHiveBox() async {
    setState(() {
      isLoading = true;
    });
    var box = await Hive.openBox('chats');
    chats = box.get('chats')?.cast<ChatMessageModel>() ?? [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  void _sendPrompt(String message) async {
    setState(() {
      isLoading = true;
    });
    var box = await Hive.openBox('chats');
    List<ChatMessageModel> savedChats =
        box.get('chats')?.cast<ChatMessageModel>() ?? [];

    // User message
    final userMessage = ChatMessageModel(
      message: message,
      isBot: false,
      timestamp: DateTime.now(),
    );

    savedChats.add(userMessage);
    await box.put('chats', savedChats);

    final botResponse = await apiService.prompting(message);
    if (botResponse != null) {
      savedChats.add(botResponse);
      await box.put('chats', savedChats);
    }

    setState(() {
      isLoading = false;
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () async {
                var box = await Hive.openBox('chats');
                await box.delete('chats');
                setState(() {
                  chats = [];
                });
              },
              child: Icon(Icons.delete, color: AppColors.primary),
            ),
          ),
        ],
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.accent, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    cursorColor: AppColors.accent,
                    controller: message,
                    decoration: InputDecoration(
                      hintText: 'Write your message...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                      ),
                      focusColor: AppColors.accent,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      if (message.text.trim().isNotEmpty && !isLoading) {
                        _sendPrompt(message.text.trim());
                        message.clear();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor:
                          isLoading ? AppColors.dark : AppColors.accent,
                      radius: 32,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                    padding: EdgeInsets.all(3),
                                  ),
                                )
                                : Icon(
                                  Icons.arrow_upward,
                                  size: 24,
                                  color: AppColors.primary,
                                ),
                      ),
                    ),
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
