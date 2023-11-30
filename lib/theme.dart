import 'package:flutter/material.dart';

const _appBarTitleSize = 20.0;
const _primaryLightColor = Colors.blue;
const _primaryDarkColor = Colors.blueGrey;
final _accentColor = Colors.blueAccent[900];
final appBarLightTextColor = Colors.grey[900];
const appBarDarkTextColor = Colors.white;

ThemeData createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final colorScheme = ColorScheme.fromSwatch(
    primarySwatch: _primaryDarkColor,
    accentColor: _accentColor,
  ).copyWith(surface: _primaryDarkColor.shade100);

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    primaryColor: _primaryDarkColor,
    bannerTheme: baseTheme.bannerTheme.copyWith(
      backgroundColor: _primaryDarkColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      dividerColor: _primaryDarkColor,
    ),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      titleTextStyle: const TextStyle(
        color: appBarDarkTextColor,
        fontSize: _appBarTitleSize,
      ),
      color: _primaryDarkColor,
    ),
    iconTheme: baseTheme.iconTheme.copyWith(color: appBarDarkTextColor),
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
    primaryColor: _primaryLightColor,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: appBarLightTextColor,
        fontSize: _appBarTitleSize,
      ),
    ),
    iconTheme: IconThemeData(color: appBarLightTextColor),
  );
}
