import 'package:flutter/material.dart';

const _primaryColor = Colors.blue;
final _accentColor = Colors.blueAccent[900];
final appBarLightTextColor = Colors.grey[900];
const appBarDarkTextColor = Colors.white;

ThemeData createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final colorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: _primaryColor,
    accentColor: _accentColor,
  );

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    primaryColor: _primaryColor,
    appBarTheme: baseTheme.appBarTheme.copyWith(
      color: _primaryColor,
    ),
  );
}

ThemeData createLightTheme() {
  final baseTheme = ThemeData.light();
  final colorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: _primaryColor,
    accentColor: _accentColor,
  ).copyWith(surface: _primaryColor.shade50);

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    primaryColor: _primaryColor,
  );
}
