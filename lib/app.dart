import 'package:flutter/material.dart';
import 'package:gethdomains/routes/home.dart';
import 'package:gethdomains/theme.dart';

const String _title = 'Geth Domains';

class GethDomainsApp extends StatelessWidget {
  const GethDomainsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: _title,
    darkTheme: createDarkTheme(),
    themeMode: ThemeMode.dark,
    theme: createLightTheme(),
    home: const HomeRoute(),
  );
}
