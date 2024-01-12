import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellDomainButton extends StatelessWidget {
  final Function() onPressed;

  const SellDomainButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      label: Text(
        AppLocalizations.of(context)!.domainSellingSellButton,
      ),
      icon: const Icon(Icons.sell),
    );
  }
}
