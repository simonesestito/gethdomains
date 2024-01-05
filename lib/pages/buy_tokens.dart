import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/repository/balance_repository.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/loading_future_builder.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage<BigInt>()
class BuyTokensPage extends StatelessWidget {
  const BuyTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.buyTokensButtonLabel;
    final inputHint = AppLocalizations.of(context)!.buyTokensAmountHint;
    final tokenFeesFuture =
        context.read<BalanceRepository>().getPurchaseTokensFees();
    return _BuySellTokensPage(
      title: title,
      inputHint: inputHint,
      tokenFeesFuture: tokenFeesFuture,
      actionIcon: const Icon(Icons.money),
    );
  }
}

@RoutePage<BigInt>()
class SellTokensPage extends StatelessWidget {
  const SellTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context)!.sellTokensButtonLabel;
    final inputHint = AppLocalizations.of(context)!.sellTokensAmountHint;
    final tokenFeesFuture =
        context.read<BalanceRepository>().getSellTokensFees();
    return _BuySellTokensPage(
      title: title,
      inputHint: inputHint,
      tokenFeesFuture: tokenFeesFuture,
      actionIcon: const Icon(Icons.sell),
    );
  }
}

class _BuySellTokensPage extends StatelessWidget {
  final String title;
  final String inputHint;
  final Future<BigInt> tokenFeesFuture;
  final Widget actionIcon;

  static const _kTokensAmount = 'tokensAmount';
  static final ethPerGeth = Decimal.parse('1000.0');

  final FormGroup form = FormGroup({
    _kTokensAmount: FormControl<int>(
      validators: [
        Validators.required,
        Validators.number,
        Validators.min(1),
      ],
    ),
  });

  _BuySellTokensPage({
    required this.title,
    required this.inputHint,
    required this.tokenFeesFuture,
    required this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: title,
      ),
      body: BodyContainer(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppReactiveTextField(
                formControlName: _kTokensAmount,
                hintText: AppLocalizations.of(context)!.buyTokensAmountHint,
                onSubmit: (_) {},
              ),
              ReactiveFormConsumer(builder: (context, form, _) {
                if (!form.control(_kTokensAmount).valid) {
                  return const SizedBox.shrink();
                }

                final tokensAmount = form.control(_kTokensAmount).value as int;
                final ethAmount = Decimal.fromInt(tokensAmount) / ethPerGeth;
                return Text(
                  AppLocalizations.of(context)!.tokensAmountEthConversion(
                    tokensAmount,
                    ethAmount.toDecimal().toString(),
                  ),
                );
              }),
              LoadingFutureBuilder(
                future: tokenFeesFuture,
                builder: (context, fees) => Text(
                  AppLocalizations.of(context)!.buyTokensFees(fees.toString()),
                ),
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) => FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () => _onSubmit(context),
                  label: Text(title),
                  icon: actionIcon,
                ),
              ),
            ].withColumnGap(),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) async {
    form.markAllAsTouched();
    if (!form.valid) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return;
    }

    final tokensAmount = BigInt.from(form.control(_kTokensAmount).value);
    context.popRoute(tokensAmount);
  }
}
