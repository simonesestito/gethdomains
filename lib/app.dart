import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/routes/router.dart';
import 'package:gethdomains/theme.dart';

const String _title = 'Geth Domains';

class GethDomainsApp extends StatelessWidget {
  final _appRouter = AppRouter();

  GethDomainsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: _title,
        darkTheme: createDarkTheme(),
        themeMode: ThemeMode.light,
        theme: createLightTheme(),
        routerConfig: _appRouter.config(
          deepLinkBuilder: (_) => const DeepLink([HomeRoute()]),
        ),
      );
}
