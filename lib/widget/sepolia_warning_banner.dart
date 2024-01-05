import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/sepolia/sepolia_bloc.dart';

import 'banner_card.dart';

class SepoliaWarningBanner extends StatelessWidget {
  const SepoliaWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final sepoliaNetworkBloc = context.watch<SepoliaNetworkBloc>();
    if (sepoliaNetworkBloc.state.isUsingSepolia) {
      return const SizedBox.shrink();
    }

    return BannerCard(
      color: Colors.deepOrange,
      icon: const Icon(Icons.warning),
      content: Text(
        AppLocalizations.of(context)!.sepoliaWarningBanner,
      ),
      action: TextButton.icon(
        style: TextButton.styleFrom(
          iconColor: Theme.of(context).textTheme.bodyMedium!.color,
          foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
        ),
        onPressed: () => sepoliaNetworkBloc.switchToSepolia(),
        icon: const Icon(Icons.open_in_new),
        label: Text(
          AppLocalizations.of(context)!.sepoliaWarningBannerButton,
        ),
      ),
    );
  }
}
