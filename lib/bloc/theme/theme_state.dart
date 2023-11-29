part of 'theme.dart';

enum ThemeBrightness {
  system,
  dark,
  light,
}

extension ThemeStateExtension on ThemeBrightness {
  String get name => switch (this) {
        ThemeBrightness.system => 'system',
        ThemeBrightness.dark => 'dark',
        ThemeBrightness.light => 'light',
      };
}

ThemeBrightness themeBrightnessFromJson(String? json) => switch (json) {
      'system' => ThemeBrightness.system,
      'dark' => ThemeBrightness.dark,
      'light' => ThemeBrightness.light,
      _ => ThemeBrightness.system,
    };
