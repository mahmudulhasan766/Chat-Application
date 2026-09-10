import 'package:chat_application/features/chat/presentation/pages/widgets/day_marker.dart';
import 'package:chat_application/features/chat/presentation/pages/widgets/member_strip.dart';
import 'package:chat_application/features/chat/presentation/pages/widgets/message_bubble.dart';
import 'package:chat_application/features/chat/presentation/pages/widgets/online_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/theme_toggle_button.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../domain/repositories/chat_repository.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({required this.user, this.repository, super.key});

  final AppUser user;
  final ChatRepository? repository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ChatBloc(repository ?? getIt<ChatRepository>())
            ..add(const ChatStarted('launch-crew')),
      child: _RoomView(user: user),
    );
  }
}

class _RoomView extends StatefulWidget {
  const _RoomView({required this.user});

  final AppUser user;

  @override
  State<_RoomView> createState() => _RoomViewState();
}

class _RoomViewState extends State<_RoomView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    context.read<ChatBloc>().add(
      ChatMessageSent(
        roomId: 'launch-crew',
        authorId: widget.user.id,
        authorName: widget.user.displayName ?? widget.user.email,
        text: text,
      ),
    );

    _controller.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#General',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2),
            OnlineWithText(),
          ],
        ),
        actions: const [ThemeToggleButton(), SizedBox(width: 8)],
      ),

      body: SafeArea(
        child: Column(
          children: [
            const MemberStrip(),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.status == ChatStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.status == ChatStatus.failure) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          state.message ?? 'Unable to load messages.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (state.messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'No messages yet.\nStart the conversation!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    itemCount: state.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const DayMarker();
                      }

                      final message = state.messages[index - 1];

                      final bool own = message.authorId == widget.user.id;

                      return MessageBubble(message: message, own: own);
                    },
                  );
                },
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: _controller.text.isNotEmpty
                  ? const Align(
                      key: ValueKey('typing'),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 22, bottom: 5),
                        child: Text(
                          'You are typing...',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    )
                  : const SizedBox(key: ValueKey('empty'), height: 0),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                            color: colorScheme.primary,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  SizedBox(
                    height: 48,
                    width: 48,
                    child: IconButton.filled(
                      onPressed: _controller.text.trim().isEmpty ? null : _send,
                      icon: const Icon(Icons.arrow_upward),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


