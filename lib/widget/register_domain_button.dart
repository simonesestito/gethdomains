import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterDomainButton extends StatelessWidget {
  final Function() onPressed;

  const RegisterDomainButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      label: Text(
        AppLocalizations.of(context)!.domainsSearchRegisterButton,
      ),
      icon: const Icon(Icons.app_registration),
    );
  }
}
