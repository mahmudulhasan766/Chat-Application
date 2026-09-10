import 'package:chat_application/core/app/my_app.dart';
import 'package:chat_application/features/chat/domain/entities/chat_message.dart';
import 'package:chat_application/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('email entry opens the chat room', (tester) async {
    await tester.pumpWidget(MyApp(chatRepository: _FakeChatRepository()));

    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.byKey(const Key('display-name-field')), findsOneWidget);
    expect(find.byKey(const Key('server-settings')), findsOneWidget);

    expect(find.byTooltip('Use dark theme'), findsOneWidget);
    await tester.tap(find.byKey(const Key('theme-toggle')));
    await tester.pump();
    expect(find.byTooltip('Use light theme'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('server-settings')));
    await tester.tap(find.byKey(const Key('server-settings')));
    await tester.pump();
    expect(find.byKey(const Key('server-url-field')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'test@example.com',
    );
    await tester.ensureVisible(find.byKey(const Key('continue-button')));
    await tester.tap(find.byKey(const Key('continue-button')));
    await tester.pumpAndSettle();
    expect(find.text('Launch crew'), findsOneWidget);
    expect(find.text('8 online'), findsOneWidget);
    expect(find.text('TODAY'), findsOneWidget);
  });
}

class _FakeChatRepository implements ChatRepository {
  @override
  Stream<List<ChatMessage>> watchMessages(String roomId) =>
      Stream.value(const []);

  @override
  Future<void> sendMessage({
    required String roomId,
    required String authorId,
    required String authorName,
    required String text,
  }) async {}
}
