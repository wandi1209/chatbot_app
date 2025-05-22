import 'dart:convert';
import 'dart:io';

import 'package:chatbot_app/models/chat_message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ChatMessageModel?> prompting(String question) async {
    try {
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Bearer ${dotenv.env['OPENAI_API_KEY']}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": question},
          ],
        }),
      );

      debugPrint('${response.body}');

      return ChatMessageModel(
        message: response.body,
        isBot: true,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
}
