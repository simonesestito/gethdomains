import 'package:flutter/material.dart';

const _appBarTitleSize = 20.0;
const _primaryLightColor = Colors.blue;
final _primaryDarkColor = Colors.blueGrey;
final _accentColor = Colors.blueAccent[900];
final _appBarLightTextColor = Colors.grey[900];
const _appBarDarkTextColor = Colors.white;

ThemeData createDarkTheme() => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _primaryDarkColor,
        accentColor: _accentColor,
      ),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: _primaryDarkColor,
        contentTextStyle: const TextStyle(color: Colors.white),
        dividerColor: _primaryDarkColor,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(
          color: _appBarDarkTextColor,
          fontSize: _appBarTitleSize,
        ),
        color: _primaryDarkColor,
      ),
      iconTheme: const IconThemeData(color: _appBarDarkTextColor),
    );

ThemeData createLightTheme() => ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: _primaryLightColor,
        accentColor: _accentColor,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: _appBarLightTextColor,
          fontSize: _appBarTitleSize,
        ),
      ),
      iconTheme: IconThemeData(color: _appBarLightTextColor),
    );
