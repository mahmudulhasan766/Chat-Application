import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/chat_message.dart';

abstract interface class ChatRemoteDataSource {
  Stream<List<ChatMessage>> watchMessages(String roomId);
  Future<void> sendMessage({
    required String roomId,
    required String authorId,
    required String authorName,
    required String text,
  });
}

class FirebaseChatRemoteDataSource implements ChatRemoteDataSource {
  FirebaseChatRemoteDataSource(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<ChatMessage>> watchMessages(String roomId) {
    return _firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_toMessage).toList());
  }

  @override
  Future<void> sendMessage({
    required String roomId,
    required String authorId,
    required String authorName,
    required String text,
  }) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .add({
            'authorId': authorId,
            'authorName': authorName,
            'text': text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
            'isDelivered': true,
          });
    } on FirebaseException catch (error) {
      throw Failure(error.message ?? 'Message could not be sent.');
    }
  }

  ChatMessage _toMessage(QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    final timestamp = data['createdAt'] as Timestamp?;
    return ChatMessage(
      id: document.id,
      roomId: document.reference.parent.parent?.id ?? '',
      authorId: data['authorId'] as String? ?? '',
      authorName: data['authorName'] as String? ?? 'Unknown',
      text: data['text'] as String? ?? '',
      createdAt: timestamp?.toDate() ?? DateTime.now(),
      isDelivered: data['isDelivered'] as bool? ?? false,
    );
  }
}
