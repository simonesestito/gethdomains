import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gethdomains/routes/router.dart';
import 'package:gethdomains/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String _title = 'Geth Domains';

class GethDomainsApp extends StatelessWidget {
  final _appRouter = AppRouter();

  GethDomainsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        title: _title,
        darkTheme: createDarkTheme(),
        themeMode: ThemeMode.dark,
        theme: createLightTheme(),
        routerConfig: _appRouter.config(
          deepLinkBuilder: (_) => const DeepLink([HomeRoute()]),
        ),
      );
}
