import 'package:hive/hive.dart';

part 'chat_message_model.g.dart';

@HiveType(typeId: 0)
class ChatMessageModel extends HiveObject {

  @HiveField(0)
  String message;
  @HiveField(1)
  bool isBot;
  @HiveField(2)
  DateTime timestamp;

  ChatMessageModel({
    required this.message,
    required this.isBot,
    required this.timestamp,
  });
}
