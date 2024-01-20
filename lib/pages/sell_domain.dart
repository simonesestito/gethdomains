import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/repository/selling_repository.dart';
import 'package:gethdomains/widget/action_buttons/sell_domain_button.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/loading_future_builder.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainSellingPage extends StatelessWidget {
  final String sellingDomain;
  static const String _kDomainName = 'domain';
  static const String _kPrice = 'price';

  late final FormGroup form;
  late final Future<String> domainOriginalOwner;

  DomainSellingPage({super.key, required this.sellingDomain}) {
    form = FormGroup({
      _kDomainName: FormControl<String>(
        value: sellingDomain,
        disabled: true,
      ),
      _kPrice: FormControl<int>(
        validators: [
          Validators.required,
          Validators.number,
          Validators.min(1),
          Validators.max(4294967295),
          // uint32 max
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.domainSellingTitle,
      ),
      body: BodyContainer(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppReactiveTextField(
                formControlName: _kDomainName,
                hintText: '',
              ),
              AppReactiveTextField(
                formControlName: _kPrice,
                hintText: AppLocalizations.of(context)!.domainSellingPriceHint,
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) => _buildEarningsEstimation(
                  context,
                  form,
                ),
              ),
              ReactiveFormConsumer(
                  builder: (context, form, _) => _buildFeesEstimation(
                        context,
                        form,
                      )),
              ReactiveFormConsumer(
                builder: (context, form, _) => SellDomainButton(
                  onPressed: () => _onSubmit(context),
                ),
              ),
            ].withColumnGap(),
          ),
        ),
      ),
    );
  }

  Widget _buildFeesEstimation(BuildContext context, FormGroup form) {
    if (!form.valid) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return const SizedBox.shrink();
    }

    Future<BigInt> feesEstimation;
    try {
      feesEstimation = context.read<SellingRepository>().getSellDomainFees(
            sellingDomain,
            BigInt.from(form.control(_kPrice).value),
          );
    } catch (e) {
      debugPrint('DomainSellingPage: _buildFeesEstimation: $e');
      return const SizedBox.shrink();
    }

    return LoadingFutureBuilder<BigInt>(
      future: feesEstimation,
      builder: (context, gas) => Text(
        AppLocalizations.of(context)!.domainsSearchRegisterFees(gas.toString()),
      ),
      errorBuilder: (_, __) => const SizedBox.shrink(),
    );
  }

  void _onSubmit(BuildContext context) {
    form.markAllAsTouched();
    if (!form.valid) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return;
    }

    context.read<DomainsBloc>().sellDomain(
          sellingDomain,
          BigInt.from(form.control(_kPrice).value),
        );
    context.popRoute();
  }

  Widget _buildEarningsEstimation(BuildContext context, FormGroup form) {
    if (!form.valid || form.control(_kPrice).value == null) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return const SizedBox.shrink();
    }

    final price = BigInt.from(form.control(_kPrice).value);
    final originalOwnerFuture =
        context.read<DomainRepository>().getDomainOriginalOwner(sellingDomain);

    return LoadingFutureBuilder<String>(
      key: ValueKey<String>(sellingDomain),
      future: originalOwnerFuture,
      loadingBuilder: (_) => const SizedBox.shrink(),
      builder: (context, originalOwner) {
        final authUser = context.watch<AuthBloc>().getCurrentUserAddress();
        if (authUser == null) {
          debugPrint('User is not logged in');
          return const SizedBox.shrink();
        }

        if (authUser == originalOwner) {
          // The seller is the original owner, so he will get all the money
          return Text(
            AppLocalizations.of(context)!
                .domainRealSellingPriceInfo(price.toString()),
          );
        } else {
          // The seller is not the original owner, so he won't get royalties
          // Calculate the final earnings: they will be the price minus the royalties (5%)
          final royalties = price ~/ BigInt.from(20);
          final earnings = price - royalties;

          return Text(
            AppLocalizations.of(context)!
                .domainRealSellingPriceInfoWithRoyalties(earnings.toString()),
          );
        }
      },
    );
  }
}
