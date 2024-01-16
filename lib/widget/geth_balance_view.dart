import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/balance/balance_bloc.dart';
import 'package:gethdomains/routing/router.dart';

///
/// A way to show the balance in GETH,
/// but in a more compact way (not as a list tile).
///
class GethBalanceView extends StatelessWidget {
  final int? showBuyIfLowerThan;

  const GethBalanceView({
    super.key,
    this.showBuyIfLowerThan,
  });

  @override
  Widget build(BuildContext context) {
    final balanceState = context.watch<BalanceBloc>().state;
    if (balanceState is! BalanceStateData) {
      return const CircularProgressIndicator();
    }

    final gethBalance = balanceState.balance;

    if (showBuyIfLowerThan != null &&
        gethBalance < BigInt.from(showBuyIfLowerThan!)) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBalanceText(context, gethBalance),
          const SizedBox(width: 64),
          _buildBuyButton(context),
        ],
      );
    } else {
      return _buildBalanceText(context, gethBalance);
    }
  }

  Widget _buildBalanceText(BuildContext context, BigInt gethBalance) {
    return Text(
      AppLocalizations.of(context)!.userTokenBalanceMessage(
        gethBalance,
      ),
    );
  }

  Widget _buildBuyButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onBuyGeth(context),
      child: Text(AppLocalizations.of(context)!.buyTokensButtonLabel),
    );
  }

  void _onBuyGeth(BuildContext context) async {
    final balanceBloc = context.read<BalanceBloc>();
    final amount = await context.pushRoute<BigInt>(const BuyTokensRoute());
    if (amount != null) {
      balanceBloc.buyTokens(amount);
    }
  }
}
