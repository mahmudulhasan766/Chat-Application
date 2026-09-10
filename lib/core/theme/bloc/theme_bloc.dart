import 'package:chat_application/core/theme/bloc/theme_event.dart';
import 'package:chat_application/core/theme/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeToggleRequested>(_onToggleRequested);
  }

  void _onToggleRequested(
    ThemeToggleRequested event,
    Emitter<ThemeState> emit,
  ) {
    final nextMode = state.mode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(state.copyWith(mode: nextMode));
  }

}
