import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';

@RoutePage()
class LoginStatusPage extends StatelessWidget {
  const LoginStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.loginStatusPageTitle,
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => switch (state) {
            AuthLoggedOut() => const _LoginStatusLoggedOut(),
            AuthLoggedIn loggedInState => _LoginStatusLoggedIn(
                authState: loggedInState,
              ),
            AuthLoading() => const _LoginStatusLoading(),
          },
        ),
      ),
    );
  }
}

class _LoginStatusLoggedOut extends StatelessWidget {
  const _LoginStatusLoggedOut();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppLocalizations.of(context)!.loginStatusPageLoggedOut),
        const SizedBox(height: 16),
        FloatingActionButton.extended(
          onPressed: () => context.read<AuthBloc>().login(),
          icon: const Icon(Icons.login),
          label: Text(AppLocalizations.of(context)!.login),
        ),
      ],
    );
  }
}

class _LoginStatusLoggedIn extends StatelessWidget {
  final AuthLoggedIn authState;

  const _LoginStatusLoggedIn({required this.authState});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppLocalizations.of(context)!.loginStatusPageLoggedIn(
          authState.account.address,
        )),
        const SizedBox(height: 16),
        FloatingActionButton.extended(
          onPressed: () => context.read<AuthBloc>().logout(),
          icon: const Icon(Icons.logout),
          label: Text(AppLocalizations.of(context)!.logout),
        ),
      ],
    );
  }
}

class _LoginStatusLoading extends StatelessWidget {
  const _LoginStatusLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
