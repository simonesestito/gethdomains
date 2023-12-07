import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/utils/form_utils.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/domain_form/ipfs_tor_inputs.dart';
import 'package:gethdomains/widget/domain_form/validity_blocks_input.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/domain_form/register_domain_button.dart';
import 'package:gethdomains/widget/text_field_decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainRenewalPage extends StatelessWidget {
  static const String _kDomainName = 'domain';
  final Domain domainToRenew;

  final FormGroup form = FormGroup({});

  DomainRenewalPage({super.key, required this.domainToRenew}) {
    form.replaceControls({
      _kDomainName: FormControl<String>(
        value: domainToRenew.domainName,
        disabled: true,
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.domainRenewalTitle,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.info),
                  subtitle: Text(
                      AppLocalizations.of(context)!.userDomainItemDescription(
                    domainToRenew.type.name,
                    domainToRenew.realAddress,
                    domainToRenew.validUntilBlockNumber,
                  )),
                ),
              ),
              ValidityBlocksCountInput(
                form: form,
                helperText: AppLocalizations.of(context)!
                    .domainRenewalValidityBlocksCountHelperText,
                onSubmit: () => _onSubmit(context),
              ),
              ReactiveFormConsumer(
                builder: (context, form, _) => RegisterDomainButton(
                  showEdit: true,
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
    if (!form.valid) {
      debugPrint('Form is invalid, with errors: ${form.errors}');
      return;
    }

    final realAddressPointer =
        form.value[IpfsTorFormInputs.kDomainType] == DomainType.ipfs
            ? form.value[IpfsTorFormInputs.kIpfsHash].toString()
            : form.value[IpfsTorFormInputs.kTorHash].toString();

    final validityBlocksCount =
        form.value[ValidityBlocksCountInput.kValidityBlocksCount] as int;
    debugPrint('Validity blocks count: $validityBlocksCount');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(realAddressPointer)),
    );
  }
}
