import 'package:chat_application/core/constents/app_colors.dart';
import 'package:chat_application/features/auth/presentation/pages/widgets/text_with_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme_toggle_button.dart';
import '../../../chat/domain/repositories/chat_repository.dart';
import '../../../chat/presentation/pages/room_page.dart';
import '../../domain/entities/app_user.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({this.chatRepository, super.key});

  final ChatRepository? chatRepository;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _email = TextEditingController();
  final _displayName = TextEditingController();
  final _serverUrl = TextEditingController(text: 'https://chat.example.com');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _displayName.dispose();
    _serverUrl.dispose();
    super.dispose();
  }

  void _enterRoom() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final email = _email.text.trim();
    final displayName = _displayName.text.trim().isEmpty
        ? email.split('@').first
        : _displayName.text.trim();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => RoomPage(
          user: AppUser(
            id: 'guest-${email.hashCode}',
            email: email,
            displayName: displayName,
          ),
          repository: widget.chatRepository,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CHAT APP',
                      style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const ThemeToggleButton(),
                  ],
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.kPrimaryColor,
                      ),
                      child: Icon(
                        Icons.message,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Join the Room',
                    style: TextStyle(
                      color: AppColors.kPrimaryColor.withValues(alpha: .6),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      height: 1.02,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Your email is your identity here-use the same one next time and your history comes back with you.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  key: const Key('email-field'),
                  controller: _email,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.go,
                  onFieldSubmitted: (_) => _enterRoom(),
                  validator: (value) {
                    final email = value?.trim() ?? '';
                    if (email.isEmpty || !email.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    hintText: 'you@example.com',
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: const Key('display-name-field'),
                  controller: _displayName,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Display name (optional)',
                    hintText: 'How should people see you?',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 8),
                ExpansionTile(
                  key: const Key('server-settings'),
                  tilePadding: EdgeInsets.zero,
                  leading: const Icon(Icons.tune),
                  title: const Text('Server settings'),
                  subtitle: const Text('Using default server'),
                  children: [
                    TextFormField(
                      key: const Key('server-url-field'),
                      controller: _serverUrl,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: 'Server URL',
                        prefixIcon: Icon(Icons.dns_outlined),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    key: const Key('continue-button'),
                    onPressed: _enterRoom,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      foregroundColor: Colors.white,
                    ),
                    label: const Text('Enter chat room'),
                  ),
                ),
                SizedBox(height: 20),
                TextWithIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
