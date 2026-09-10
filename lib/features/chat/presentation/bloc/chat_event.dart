import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

final class ChatStarted extends ChatEvent {
  const ChatStarted(this.roomId);

  final String roomId;

  @override
  List<Object> get props => [roomId];
}

final class ChatMessageSent extends ChatEvent {
  const ChatMessageSent({
    required this.roomId,
    required this.authorId,
    required this.authorName,
    required this.text,
  });

  final String roomId;
  final String authorId;
  final String authorName;
  final String text;

  @override
  List<Object> get props => [roomId, authorId, authorName, text];
}

final class ChatMessagesUpdated extends ChatEvent {
  const ChatMessagesUpdated(this.messages);

  final List<ChatMessage> messages;

  @override
  List<Object> get props => [messages];
}
