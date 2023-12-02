import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/routing/router.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.navigate(const SettingsRoute());
      },
      icon: const Icon(Icons.settings),
    );
  }
}
