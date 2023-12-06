import 'package:flutter/material.dart';
import 'package:gethdomains/widget/banner_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginProviderErrorBanner extends StatelessWidget {
  const LoginProviderErrorBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      color: Theme.of(context).colorScheme.error,
      icon: const Icon(Icons.error),
      content: Text(
        AppLocalizations.of(context)!.loginProviderErrorMessage,
      ),
    );
  }
}
