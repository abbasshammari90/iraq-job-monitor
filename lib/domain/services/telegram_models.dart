class TelegramMessage {
  final int messageId;
  final int chatId;
  final String senderName;
  final String text;
  final DateTime date;
  final String? replyToMessageId;

  TelegramMessage({
    required this.messageId,
    required this.chatId,
    required this.senderName,
    required this.text,
    required this.date,
    this.replyToMessageId,
  });
}

class TelegramChat {
  final int id;
  final String title;
  final String type; // "supergroup", "group", "channel"
  final String? username;
  final String? description;
  final int memberCount;

  TelegramChat({
    required this.id,
    required this.title,
    required this.type,
    this.username,
    this.description,
    required this.memberCount,
  });
}
