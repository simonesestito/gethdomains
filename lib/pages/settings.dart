import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/settings/settings.dart';
import 'package:gethdomains/model/ipfs_gateway.dart';
import 'package:gethdomains/widget/body_container.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.settingsPageTitle,
        actions: [
          // Legal and License page button
          IconButton(
            onPressed: () => showLicensePage(context: context),
            icon: const Icon(Icons.balance),
            tooltip: AppLocalizations.of(context)!.settingsItemLicense,
          ),
        ],
      ),
      body: BodyContainer(child: _SettingsForm()),
    );
  }
}

class _SettingsForm extends StatelessWidget {
  static const _kIpfsGateway = 'ipfsGateway';

  final FormGroup formGroup = FormGroup({
    _kIpfsGateway: FormControl<IpfsGateway>(
      validators: [Validators.required],
      value: IpfsGateway.ipfsGateways.first,
    ),
  });

  _SettingsForm();

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => _buildForm(context),
      builder: (context, form, _) => ReactiveDropdownField<IpfsGateway>(
        formControlName: _kIpfsGateway,
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.settingsItemIpfsGateway,
        ),
        items: [
          for (final ipfsGateway in IpfsGateway.ipfsGateways)
            DropdownMenuItem(
              value: ipfsGateway,
              child: Text(ipfsGateway.name),
            ),
        ],
        onChanged: (value) {
          value.markAsTouched();
          if (value.valid) {
            context.read<SettingsCubit>().changeIpfsGateway(value.value!);
          }
        },
      ),
    );
  }

  FormGroup _buildForm(BuildContext context) => FormGroup({
        _kIpfsGateway: FormControl<IpfsGateway>(
          validators: [Validators.required],
          value: context.read<SettingsCubit>().state.ipfsGateway,
        ),
      });
}
