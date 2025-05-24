import 'dart:convert';
import 'dart:io';

import 'package:chatbot_app/models/chat_message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<ChatMessageModel?> prompting(String question) async {
    try {
      final response = await http.post(
        Uri.parse(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${dotenv.env['GEMINI_API_KEY']}",
        ),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": question},
              ],
            },
          ],
        }),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      debugPrint('$data');
      return ChatMessageModel(
        message: data['candidates'][0]['content']['parts'][0]['text'],
        isBot: true,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
}
