import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/model/account.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => switch (state) {
              AuthLoggedIn successResult => _buildLoggedInButton(
                  context,
                  successResult.account,
                ),
              AuthLoggedOut() => _buildLoggedOutButton(context),
              AuthLoading() => _buildLoadingButton(context),
            });
  }

  Widget _buildLoggedInButton(BuildContext context, UserAccount account) {
    return IconButton(
      icon: const Icon(Icons.logout),
      tooltip: AppLocalizations.of(context)!.logout,
      onPressed: () => context.read<AuthBloc>().logout(),
    );
  }

  Widget _buildLoggedOutButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.account_circle),
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
