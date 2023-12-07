import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterDomainButton extends StatelessWidget {
  final bool showEdit;
  final Function() onPressed;

  const RegisterDomainButton({
    super.key,
    required this.onPressed,
    this.showEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      label: Text(
        showEdit
            ? AppLocalizations.of(context)!.domainsSearchConfirmEditButton
            : AppLocalizations.of(context)!.domainsSearchRegisterButton,
      ),
      icon: const Icon(Icons.app_registration),
    );
  }
}
