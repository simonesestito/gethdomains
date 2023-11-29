import 'package:flutter/material.dart';

const _appBarTitleSize = 20.0;
const _primaryLightColor = Colors.blue;
const _primaryDarkColor = Colors.blueGrey;
final _accentColor = Colors.blueAccent[900];
final _appBarLightTextColor = Colors.grey[900];
const _appBarDarkTextColor = Colors.white;

ThemeData createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: _primaryDarkColor,
    accentColor: _accentColor,
  ).copyWith(surface: _primaryDarkColor.shade100);

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    bannerTheme: baseTheme.bannerTheme.copyWith(
      backgroundColor: _primaryDarkColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      dividerColor: _primaryDarkColor,
    ),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      titleTextStyle: const TextStyle(
        color: _appBarDarkTextColor,
        fontSize: _appBarTitleSize,
      ),
      color: _primaryDarkColor,
    ),
    iconTheme: baseTheme.iconTheme.copyWith(color: _appBarDarkTextColor),
    popupMenuTheme: baseTheme.popupMenuTheme.copyWith(
      color: colorScheme.surface,
      textStyle: const TextStyle(color: Colors.white),
      iconColor: Colors.white,
    ),
  );
}

ThemeData createLightTheme() {
  final baseTheme = ThemeData.light();
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: _primaryLightColor,
    accentColor: _accentColor,
  ).copyWith(surface: _primaryLightColor.shade50);

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: _appBarLightTextColor,
        fontSize: _appBarTitleSize,
      ),
    ),
    iconTheme: IconThemeData(color: _appBarLightTextColor),
  );
}
