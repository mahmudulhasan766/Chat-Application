class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.authorId,
    required this.authorName,
    required this.text,
    required this.createdAt,
    required this.isDelivered,
  });

  final String id;
  final String roomId;
  final String authorId;
  final String authorName;
  final String text;
  final DateTime createdAt;
  final bool isDelivered;
}
