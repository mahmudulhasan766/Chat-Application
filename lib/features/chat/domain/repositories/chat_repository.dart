import '../entities/chat_message.dart';

abstract interface class ChatRepository {
  Stream<List<ChatMessage>> watchMessages(String roomId);
  Future<void> sendMessage({
    required String roomId,
    required String authorId,
    required String authorName,
    required String text,
  });
}
