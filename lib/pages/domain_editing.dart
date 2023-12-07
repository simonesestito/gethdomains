import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/column_gap.dart';
import 'package:gethdomains/widget/domain_form/ipfs_tor_inputs.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/domain_form/register_domain_button.dart';
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(realAddressPointer)),
    );
  }
}
