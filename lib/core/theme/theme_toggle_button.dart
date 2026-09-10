import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/theme_bloc.dart';
import 'bloc/theme_event.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<ThemeBloc, bool>((bloc) => bloc.state.isDark);
    return IconButton(
      key: const Key('theme-toggle'),
      tooltip: isDark ? 'Use light theme' : 'Use dark theme',
      onPressed: () =>
          context.read<ThemeBloc>().add(const ThemeToggleRequested()),
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}
