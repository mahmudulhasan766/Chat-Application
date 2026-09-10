import 'package:flutter/material.dart';

class ThemeState {
  const ThemeState({this.mode = ThemeMode.light});

  final ThemeMode mode;

  bool get isDark => mode == ThemeMode.dark;

  ThemeState copyWith({ThemeMode? mode}) => ThemeState(mode: mode ?? this.mode);
}
