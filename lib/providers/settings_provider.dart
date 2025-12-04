import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
    (ref) => SettingsNotifier());

class SettingsState {
  final String languageCode;
  final double voiceSpeed;
  final ThemeMode themeMode;

  SettingsState({
    required this.languageCode,
    required this.voiceSpeed,
    required this.themeMode,
  });

  SettingsState copyWith({
    String? languageCode,
    double? voiceSpeed,
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      languageCode: languageCode ?? this.languageCode,
      voiceSpeed: voiceSpeed ?? this.voiceSpeed,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier()
      : super(SettingsState(
          languageCode: 'EN',
          voiceSpeed: 1.0,
          themeMode: ThemeMode.light,
        ));

  void setLanguage(String code) {
    state = state.copyWith(languageCode: code.toUpperCase());
  }

  void setVoiceSpeed(double speed) {
    state = state.copyWith(voiceSpeed: speed);
  }

  void toggleTheme() {
    state = state.copyWith(
      themeMode:
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
