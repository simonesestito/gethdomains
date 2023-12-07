import 'package:flutter/material.dart';
import 'package:gethdomains/input/validators/ipfs_cid_validator.dart';
import 'package:gethdomains/input/validators/tor_address_validator.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/utils/form_utils.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IpfsTorFormInputs extends StatelessWidget {
  static const String kDomainType = 'domainType';
  static const String kIpfsHash = 'ipfsHash';
  static const String kTorHash = 'torHash';

  final ipfsHashInput = FormControl<String>();
  final torHashInput = FormControl<String>();

  final void Function() onSubmit;

  IpfsTorFormInputs({
    super.key,
    required FormGroup form,
    required this.onSubmit,
    Domain? editingDomain,
  }) {
    form.replaceControls({
      IpfsTorFormInputs.kIpfsHash: ipfsHashInput,
      IpfsTorFormInputs.kTorHash: torHashInput,
    });

    if (editingDomain != null) {
      switch (editingDomain.type) {
        case DomainType.ipfs:
          form.patchValue({
            IpfsTorFormInputs.kIpfsHash: editingDomain.realAddress,
          });
          break;
        case DomainType.tor:
          form.patchValue({
            IpfsTorFormInputs.kTorHash: editingDomain.realAddress,
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            for (final domainType in DomainType.values)
              Expanded(
                child: ReactiveRadioListTile(
                  formControlName: kDomainType,
                  value: domainType,
                  title: Text(
                    domainType.name.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
              ),
          ],
        ),
        ReactiveValueListenableBuilder(
          formControlName: kDomainType,
          builder: (context, form, _) {
            debugPrint('form.value: ${form.value}');
            _updateHashValidators(form.value as DomainType?);

            if (form.value == DomainType.ipfs) {
              return AppReactiveTextField(
                key: const Key(kIpfsHash),
                formControlName: kIpfsHash,
                hintText: AppLocalizations.of(context)!
                    .domainRegistrationIpfsHashLabel,
                onSubmit: (_) => onSubmit(),
              );
            } else if (form.value == DomainType.tor) {
              return AppReactiveTextField(
                key: const Key(kTorHash),
                formControlName: kTorHash,
                hintText: AppLocalizations.of(context)!
                    .domainRegistrationTorHashLabel,
                onSubmit: (_) => onSubmit(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        ReactiveFormConsumer(
          builder: (context, form, _) {
            if (form.value[kDomainType] == null) {
              return Text(
                AppLocalizations.of(context)!.inputErrorDomainTypeRequired,
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
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
