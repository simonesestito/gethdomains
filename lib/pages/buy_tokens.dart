import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/repository/balance_repository.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/domain_form/register_domain_button.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/loading_future_builder.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage<BigInt>()
class BuyTokensPage extends StatelessWidget {
  static const _kTokensAmount = 'tokensAmount';

  final FormGroup form = FormGroup({
    _kTokensAmount: FormControl<int>(
      validators: [
        Validators.required,
        Validators.number,
        Validators.min(1),
      ],
    ),
  });

  BuyTokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.buyTokensButtonLabel,
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
              LoadingFutureBuilder(
                future:
                    context.read<BalanceRepository>().getPurchaseTokensFees(),
                builder: (context, fees) => Text(
                  AppLocalizations.of(context)!.buyTokensFees(fees.toString()),
                ),
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) => RegisterDomainButton(
                  label: AppLocalizations.of(context)!.buyTokensButtonLabel,
                  onPressed: () => _onSubmit(context),
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
