import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.own});

  final dynamic message;
  final bool own;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final time =
        '${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}';

    return Align(
      alignment: own ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        constraints: const BoxConstraints(maxWidth: 330),
        padding: const EdgeInsets.fromLTRB(13, 10, 13, 8),
        decoration: BoxDecoration(
          color: own
              ? const Color(0xff335c67)
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(own ? 16 : 4),
            bottomRight: Radius.circular(own ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!own) ...[
              Text(
                message.authorName,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 3),
            ],

            Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                height: 1.35,
                color: own ? Colors.white : colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 4),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 10,
                    color: own ? Colors.white70 : Colors.grey,
                  ),
                ),

                if (own) ...[
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.done_all,
                    size: 14,
                    color: Color(0xff8fc7a8),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}