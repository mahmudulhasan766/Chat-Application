import 'package:flutter/material.dart';

class DayMarker extends StatelessWidget {
  const DayMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          const Expanded(child: Divider(height: 1)),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'TODAY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          const Expanded(child: Divider(height: 1)),
        ],
      ),
    );
  }
}