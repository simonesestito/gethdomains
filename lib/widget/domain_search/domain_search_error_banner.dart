import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domain_search/domain_search_bloc.dart';
import 'package:gethdomains/widget/banner_card.dart';

class DomainSearchErrorBanner extends StatelessWidget {
  const DomainSearchErrorBanner({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DomainSearchBloc, DomainSearchState>(
        builder: (context, state) => switch (state) {
          DomainSearchStateNoResults() => _buildNoResultsBanner(context),
          DomainSearchStateError error => _buildErrorBanner(context, error),
          DomainSearchStateSuccess success =>
            _buildSuccessBanner(context, success),
          _ => const SizedBox.shrink(),
        },
      );

  Widget _buildNoResultsBanner(BuildContext context) => BannerCard(
        content: Text(AppLocalizations.of(context)!.domainSearchResultNotFound),
        color: Colors.yellow.shade700,
        icon: const Icon(Icons.no_adult_content),
      );

  Widget _buildErrorBanner(
          BuildContext context, DomainSearchStateError error) =>
      BannerCard(
        content: Text(AppLocalizations.of(context)!.domainSearchResultError),
        color: Colors.red.shade700,
        icon: const Icon(Icons.error),
      );

  Widget _buildSuccessBanner(
          BuildContext context, DomainSearchStateSuccess success) =>
      BannerCard(
        content: SelectableText(
          AppLocalizations.of(context)!.domainSearchResultSuccess(
            success.domainSearchResult.type.name.toUpperCase(),
            success.domainSearchResult.realAddress,
          ),
        ),
        color: Colors.green.shade700,
        icon: const Icon(Icons.check),
        action: TextButton.icon(
          style: TextButton.styleFrom(
            iconColor: Theme.of(context).textTheme.bodyMedium!.color,
            foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
          ),
          onPressed: () {
            // TODO: Open site
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(success.domainSearchResult.realAddress)),
            );
          },
          icon: const Icon(Icons.open_in_new),
          label: Text(AppLocalizations.of(context)!.openDomainPointer),
        ),
      );
}
