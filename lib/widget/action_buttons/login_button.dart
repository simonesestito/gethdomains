import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/routing/router.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => switch (state) {
        AuthLoggedIn _ => _buildAccountButton(context),
        AuthLoggedOut() => _buildLoginButton(context),
        AuthLoading() => _buildLoadingButton(context),
        AuthMissingProvider() => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildAccountButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
      tooltip: AppLocalizations.of(context)!.accountButtonTooltip,
      onPressed: () => context.router.navigate(LoginStatusRoute()),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.login),
      tooltip: AppLocalizations.of(context)!.login,
      onPressed: () => context.read<AuthBloc>().login(),
    );
  }

  Widget _buildLoadingButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: IconTheme.of(context).color,
        ),
      ),
    );
  }
}
