import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainRegistrationPage extends StatelessWidget {
  final String? searchedDomain;
  static const String _kDomainName = 'domain';

  final formGroup = FormGroup({
    _kDomainName: FormControl<String>(
      validators: const [DomainInputValidator()],
    ),
  });

  DomainRegistrationPage({super.key, this.searchedDomain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!.domainRegistrationTitle,
      ),
      body: ReactiveForm(
        formGroup: formGroup,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReactiveTextField(
              formControlName: _kDomainName,
              decoration: InputDecoration(
                labelText:
                    AppLocalizations.of(context)!.domainRegistrationDomainLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
