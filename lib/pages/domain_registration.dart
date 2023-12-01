import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/input/validators/ipfs_cid_validator.dart';
import 'package:gethdomains/input/validators/tor_address_validator.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/register_domain_button.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainRegistrationPage extends StatelessWidget {
  final String? searchedDomain;
  static const String _kDomainName = 'domain';
  static const String _kDomainType = 'domainType';
  static const String _kIpfsHash = 'ipfsHash';
  static const String _kTorHash = 'torHash';

  final ipfsHashInput = FormControl<String>();
  final torHashInput = FormControl<String>();
  late final FormGroup form;

  DomainRegistrationPage({super.key, this.searchedDomain}) {
    form = FormGroup({
      _kDomainName: FormControl<String>(
        validators: const [DomainInputValidator()],
        value: searchedDomain,
        disabled: true,
      ),
      _kDomainType: FormControl<DomainType>(
        validators: [Validators.required],
      ),
      _kIpfsHash: ipfsHashInput,
      _kTorHash: torHashInput,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.domainRegistrationTitle,
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
              Row(
                children: [
                  for (final domainType in DomainType.values)
                    Expanded(
                      child: ReactiveRadioListTile(
                        formControlName: _kDomainType,
                        value: domainType,
                        title: Text(
                          domainType.name.toUpperCase(),
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              ReactiveValueListenableBuilder(
                formControlName: _kDomainType,
                builder: (context, form, _) {
                  debugPrint('form.value: ${form.value}');
                  _updateHashValidators(form.value as DomainType?);

                  if (form.value == DomainType.ipfs) {
                    return AppReactiveTextField(
                      key: const Key(_kIpfsHash),
                      formControlName: _kIpfsHash,
                      hintText: AppLocalizations.of(context)!
                          .domainRegistrationIpfsHashLabel,
                      onSubmit: (_) => _onSubmit(context),
                    );
                  } else if (form.value == DomainType.tor) {
                    return AppReactiveTextField(
                      key: const Key(_kTorHash),
                      formControlName: _kTorHash,
                      hintText: AppLocalizations.of(context)!
                          .domainRegistrationTorHashLabel,
                      onSubmit: (_) => _onSubmit(context),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) {
                  if (form.value[_kDomainType] == null) {
                    return Text(
                      AppLocalizations.of(context)!
                          .inputErrorDomainTypeRequired,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) => RegisterDomainButton(
                  onPressed: () => _onSubmit(context),
                ),
              ),
            ].withColumnGap(),
          ),
        ),
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    form.markAllAsTouched();
    if (!form.valid) return;

    final realAddressPointer = form.value[_kDomainType] == DomainType.ipfs
        ? form.value[_kIpfsHash].toString()
        : form.value[_kTorHash].toString();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(realAddressPointer)),
    );
  }

  void _updateHashValidators(DomainType? value) {
    final inputs = [ipfsHashInput, torHashInput];

    // Reset all validators
    for (final input in inputs) {
      input.clearValidators();
    }

    // Set appropriate validators
    if (value == DomainType.ipfs) {
      ipfsHashInput.setValidators(const [IpfsCidValidator()]);
    } else if (value == DomainType.tor) {
      torHashInput.setValidators(const [TorAddressValidator()]);
    }

    // Refresh validity for all inputs
    for (final input in inputs) {
      input.updateValueAndValidity();
    }
  }
}
