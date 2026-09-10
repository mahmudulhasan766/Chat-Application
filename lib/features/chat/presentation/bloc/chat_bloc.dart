import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._repository) : super(const ChatState()) {
    on<ChatStarted>(_onStarted);
    on<ChatMessageSent>(_onMessageSent);
    on<ChatMessagesUpdated>(
      (event, emit) =>
          emit(ChatState(messages: event.messages, status: ChatStatus.ready)),
    );
  }

  final ChatRepository _repository;
  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  Future<void> _onStarted(ChatStarted event, Emitter<ChatState> emit) async {
    emit(const ChatState(status: ChatStatus.loading));
    await _messagesSubscription?.cancel();
    _messagesSubscription = _repository
        .watchMessages(event.roomId)
        .listen((messages) => add(ChatMessagesUpdated(messages)));
  }

  Future<void> _onMessageSent(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _repository.sendMessage(
        roomId: event.roomId,
        authorId: event.authorId,
        authorName: event.authorName,
        text: event.text,
      );
    } on Failure catch (error) {
      emit(
        ChatState(
          messages: state.messages,
          status: ChatStatus.failure,
          message: error.message,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _messagesSubscription?.cancel();
    return super.close();
  }
}
