import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthBloc>().state is AuthLoggedIn;

    return IconButton(
        icon: isLoggedIn
            ? const Icon(Icons.logout)
            : const Icon(Icons.account_circle),
        tooltip: isLoggedIn
            ? AppLocalizations.of(context)!.logout
            : AppLocalizations.of(context)!.login,
        onPressed: () {
          if (isLoggedIn) {
            context.read<AuthBloc>().logout();
          } else {
            context.read<AuthBloc>().login();
          }
        });
  }
}
