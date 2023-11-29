import 'package:flutter/material.dart';

ThemeData createDarkTheme() => ThemeData.dark(useMaterial3: false).copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      accentColor: Colors.blueAccent[800],
    ),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: Colors.blueGrey[900],
      contentTextStyle: const TextStyle(color: Colors.white),
    )
);

ThemeData createLightTheme() => ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent[800],
  ),
);