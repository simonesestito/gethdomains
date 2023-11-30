// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:gethdomains/bloc/theme/theme.dart';

class ThemeUpdater {
  const ThemeUpdater();

  void updateThemeColor(ThemeBrightness brightness) =>
      context.callMethod('updateThemeColor', [brightness.name]);
}
