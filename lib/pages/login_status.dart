import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/balance/balance_bloc.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/login_provider_error_banner.dart';

@RoutePage<bool>()
class LoginStatusPage extends StatelessWidget {
  final bool popAfterLogin;

  const LoginStatusPage({super.key, this.popAfterLogin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.loginStatusPageTitle,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Also, listen for AuthLoggedIn state changes and redirect
          // to the route that was passed in the constructor.
          if (state is AuthLoggedIn && popAfterLogin) {
            context.router.pop(true);
          }
        },
        child: BodyContainer(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => switch (state) {
              AuthLoggedOut() => const _LoginStatusLoggedOut(),
              AuthMissingProvider() => const LoginProviderErrorBanner(),
              AuthLoggedIn loggedInState => _LoginStatusLoggedIn(
                  authState: loggedInState,
                ),
              AuthLoading() => const _LoginStatusLoading(),
            },
          ),
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
        SelectableText(AppLocalizations.of(context)!.loginStatusPageLoggedIn(
          authState.account.address,
        )),
        const SizedBox(height: 16),
        FloatingActionButton.extended(
          onPressed: () => context.read<AuthBloc>().logout(),
          icon: const Icon(Icons.logout),
          label: Text(AppLocalizations.of(context)!.logout),
        ),
        const SizedBox(height: 16),
        const Divider(),
        _buildTokenBalance(context),
        const Divider(),
        _buildDomainsList(context),
      ],
    );
  }

  Widget _buildTokenBalance(BuildContext context) =>
      BlocBuilder<BalanceBloc, BalanceState>(
        builder: (context, state) => switch (state) {
          LoadingBalanceState() => const SizedBox.shrink(),
          BalanceStateData balanceState => ListTile(
              title: Text(AppLocalizations.of(context)!.userTokenBalanceMessage(
                balanceState.balance,
              )),
              trailing: OutlinedButton(
                onPressed: () => _onBuyTokensPressed(context),
                child: Text(AppLocalizations.of(context)!.buyTokensButtonLabel),
              ),
            ),
          UnavailableBalanceState() => Text(
              AppLocalizations.of(context)!.userTokenBalanceUnavailable,
            ),
        },
      );

  void _onBuyTokensPressed(BuildContext context) {
    // TODO: Implement buying tokens page route
  }

  Widget _buildDomainsList(BuildContext context) {
    // TODO: Build domains list
    return Column(children: [
      const SizedBox(height: 16),
      Text(
        AppLocalizations.of(context)!.userDomainsListTitle,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(height: 16),
      const Placeholder(),
    ]);
  }
}

class _LoginStatusLoading extends StatelessWidget {
  const _LoginStatusLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
