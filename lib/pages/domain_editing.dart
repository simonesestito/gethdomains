import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/domain_form/ipfs_tor_inputs.dart';
import 'package:gethdomains/widget/domain_form/register_domain_button.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/loading_future_builder.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainEditingPage extends StatelessWidget {
  final Domain editingDomain;
  static const String _kDomainName = 'domain';

  late final FormGroup form;

  DomainEditingPage({super.key, required this.editingDomain}) {
    form = FormGroup({
      _kDomainName: FormControl<String>(
        validators: const [DomainInputValidator()],
        value: editingDomain.domainName,
        disabled: true,
      ),
      IpfsTorFormInputs.kDomainType: FormControl<DomainType>(
        validators: [Validators.required],
        value: editingDomain.type,
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.domainEditingTitle,
      ),
      body: BodyContainer(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppReactiveTextField(
                formControlName: _kDomainName,
                hintText: '',
                onSubmit: (_) {},
              ),
              IpfsTorFormInputs(
                form: form,
                editingDomain: editingDomain,
                onSubmit: () => _onSubmit(context),
              ),
              ReactiveFormConsumer(
                  builder: (context, form, _) => _buildFeesEstimation(
                        context,
                        form,
                      )),
              ReactiveFormConsumer(
                builder: (context, form, _) => RegisterDomainButton(
                  label: AppLocalizations.of(context)!.domainsConfirmEditButton,
                  onPressed: () => _onSubmit(context),
                ),
              ),
            ].withColumnGap(),
          ),
        ),
      ),
    );
  }

  String? _getAddressPointer() {
    final domainType = form.control(IpfsTorFormInputs.kDomainType).value;
    if (domainType == null) {
      return null;
    }

    final pointerFieldKey = domainType == DomainType.ipfs
        ? IpfsTorFormInputs.kIpfsHash
        : IpfsTorFormInputs.kTorHash;

    if (!form.contains(pointerFieldKey)) {
      return null;
    }

    return form.control(pointerFieldKey).value.toString();
  }

  Widget _buildFeesEstimation(BuildContext context, FormGroup form) {
    if (!form.valid) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return const SizedBox.shrink();
    }

    Future<BigInt> feesEstimation;
    try {
      feesEstimation = context.read<DomainsBloc>().estimateDomainEditFees(
            form.control(_kDomainName).value.toString(),
            _getAddressPointer() ?? '',
            form.control(IpfsTorFormInputs.kDomainType).value,
          );
    } catch (e) {
      debugPrint('DomainEditingPage: _buildFeesEstimation: $e');
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

    context.read<DomainsBloc>().editDomainPointer(
          form.control(_kDomainName).value.toString(),
          _getAddressPointer() ?? '',
          form.control(IpfsTorFormInputs.kDomainType).value,
        );
    context.popRoute();
  }
}
