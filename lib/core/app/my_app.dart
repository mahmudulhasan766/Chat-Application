import 'package:chat_application/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({this.chatRepository, super.key});

  final ChatRepository? chatRepository;

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.mode,
          home: AuthPage(chatRepository: chatRepository),
        ),
      ),
    );
  }
}
