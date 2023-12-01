import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class DomainRegistrationPage extends StatelessWidget {
  final String searchedDomain;

  final formGroup = FormGroup({
    // TODO: list required fields to register a domain
  });

  DomainRegistrationPage({super.key, required this.searchedDomain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(
        context,
        title: AppLocalizations.of(context)!
            .domainRegistrationTitle(searchedDomain),
      ),
      body: ReactiveForm(
        formGroup: formGroup,
        child: Column(children: [
          const Text('Ciao'),
        ]),
      ),
    );
  }
}
