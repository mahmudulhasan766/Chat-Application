import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message.dart';

enum ChatStatus { initial, loading, ready, failure }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.message,
  });

  final List<ChatMessage> messages;
  final ChatStatus status;
  final String? message;

  @override
  List<Object?> get props => [messages, status, message];
}
