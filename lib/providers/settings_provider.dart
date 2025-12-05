import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
  (ref) => SettingsNotifier(),
);

class SettingsState {
  final String languageCode;
  final ThemeMode themeMode;

  SettingsState({required this.languageCode, required this.themeMode});

  SettingsState copyWith({String? languageCode, ThemeMode? themeMode}) {
    return SettingsState(
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
    : super(SettingsState(languageCode: 'EN', themeMode: ThemeMode.light));

  void setLanguage(String code) {
    state = state.copyWith(languageCode: code.toUpperCase());
  }

  void toggleTheme() {
    state = state.copyWith(
      themeMode: state.themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }
}
