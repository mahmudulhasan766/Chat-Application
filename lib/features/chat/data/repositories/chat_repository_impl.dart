import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._dataSource);

  final ChatRemoteDataSource _dataSource;

  @override
  Stream<List<ChatMessage>> watchMessages(String roomId) =>
      _dataSource.watchMessages(roomId);

  @override
  Future<void> sendMessage({
    required String roomId,
    required String authorId,
    required String authorName,
    required String text,
  }) => _dataSource.sendMessage(
    roomId: roomId,
    authorId: authorId,
    authorName: authorName,
    text: text,
  );
}
