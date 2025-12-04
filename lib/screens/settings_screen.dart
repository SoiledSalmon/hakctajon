import 'package:ai_loan_buddy/providers/chat_provider.dart';
import 'package:ai_loan_buddy/providers/settings_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/widgets/app_button.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ListView(
            children: [
              Text(
                'Language',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              LanguageSelectorDropdown(
                currentLanguage: settings.languageCode,
                onChanged: (val) {
                  settingsNotifier.setLanguage(val);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Theme',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SwitchListTile(
                title: Text(settings.themeMode == ThemeMode.light ? 'Light Mode' : 'Dark Mode'),
                value: settings.themeMode == ThemeMode.dark,
                onChanged: (_) {
                  settingsNotifier.toggleTheme();
                  ref.read(appThemeProvider.notifier).state =
                      settings.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Clear Conversation',
                onPressed: () {
                  ref.read(chatProvider.notifier).clearConversation();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Conversation cleared')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
