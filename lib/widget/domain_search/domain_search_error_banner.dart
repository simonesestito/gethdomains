import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domain_search/domain_search_bloc.dart';
import 'package:gethdomains/bloc/settings/settings.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/widget/banner_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DomainSearchResultBanner extends StatelessWidget {
  const DomainSearchResultBanner({super.key});

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
          onPressed: () => _openDomainPointer(
            context,
            success.domainSearchResult,
          ),
          icon: const Icon(Icons.open_in_new),
          label: Text(AppLocalizations.of(context)!.openDomainPointer),
        ),
      );

  void _openDomainPointer(BuildContext context, Domain domain) {
    switch (domain.type) {
      case DomainType.ipfs:
        _openIpfsDomain(context, domain.realAddress);
        break;
      case DomainType.tor:
        _openTorDomain(context, domain.realAddress);
        break;
    }
  }

  void _openIpfsDomain(BuildContext context, String cid) {
    final httpUrl =
        context.read<SettingsCubit>().state.ipfsGateway.getGatewayUrl(cid);
    // Open a new browser tab with the IPFS gateway URL
    launchUrl(httpUrl, webOnlyWindowName: '_blank');
  }

  void _openTorDomain(BuildContext context, String domain) {
    final httpUrl = Uri.parse('https://$domain');
    // Launch ONION domain, even if the user is not using Tor
    launchUrl(httpUrl, webOnlyWindowName: '_blank');
  }
}
