import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gethdomains/bloc/global_errors/banner.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:gethdomains/di/injector.dart';
import 'package:gethdomains/routing/router.dart';
import 'package:gethdomains/service/theme_updater.dart';
import 'package:gethdomains/theme.dart';

const String _title = 'Geth Domains';

class GethDomainsApp extends StatelessWidget {
  const GethDomainsApp({super.key});

  @override
  Widget build(BuildContext context) => DependencyInjector(
        builder: (context) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
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
          themeMode: _getThemeMode(context),
          theme: createLightTheme(),
          darkTheme: createDarkTheme(),
          // ignore: deprecated_member_use
          routerConfig: context.read<AppRouter>().config(initialDeepLink: '/'),
          builder: (context, router) => Stack(
            children: [
              router ?? const SizedBox.shrink(),
              const GlobalErrorsBanner(),
            ],
          ),
        ),
      );

  ThemeMode _getThemeMode(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    // Update browser theme color
    context.read<ThemeUpdater>().updateThemeColor(themeState);

    return switch (themeState) {
      ThemeBrightness.system => ThemeMode.system,
      ThemeBrightness.dark => ThemeMode.dark,
      ThemeBrightness.light => ThemeMode.light,
    };
  }
}
