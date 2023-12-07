import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryLightColor = Colors.blue;
const _primaryDarkColor = Colors.blueGrey;
final _accentColor = Colors.blueAccent[900];
final appBarLightTextColor = Colors.grey[900];
const appBarDarkTextColor = Colors.white;

TextTheme _textTheme(ThemeData baseTheme) =>
    GoogleFonts.montserratTextTheme(baseTheme.textTheme);

ThemeData createDarkTheme() {
  final baseTheme = ThemeData.dark();
  final colorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.dark,
    primarySwatch: _primaryDarkColor,
    accentColor: _accentColor,
  );

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    primaryColor: _primaryDarkColor,
    appBarTheme: baseTheme.appBarTheme.copyWith(
      color: _primaryDarkColor,
    ),
    textTheme: _textTheme(baseTheme),
  );
}

ThemeData createLightTheme() {
  final baseTheme = ThemeData.light();
  final colorScheme = ColorScheme.fromSwatch(
    brightness: Brightness.light,
    primarySwatch: _primaryLightColor,
    accentColor: _accentColor,
  ).copyWith(surface: _primaryLightColor.shade50);

  return baseTheme.copyWith(
    colorScheme: colorScheme,
    primaryColor: _primaryLightColor,
    textTheme: _textTheme(baseTheme),
  );
}
