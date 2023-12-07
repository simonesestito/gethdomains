import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/balance/balance_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GethBalanceTile extends StatelessWidget {
  const GethBalanceTile({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<BalanceBloc, BalanceState>(
        builder: (context, state) => switch (state) {
          LoadingBalanceState() => const SizedBox.shrink(),
          BalanceStateData balanceState => ListTile(
              title: Text(AppLocalizations.of(context)!.userTokenBalanceMessage(
                balanceState.balance,
              )),
              trailing: OutlinedButton.icon(
                onPressed: () => _onBuyTokensPressed(context),
                icon: const Icon(Icons.money),
                label: Text(AppLocalizations.of(context)!.buyTokensButtonLabel),
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
}
