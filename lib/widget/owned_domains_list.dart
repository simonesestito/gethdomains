import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/model/domain.dart';

class OwnedDomainsList extends StatelessWidget {
  const OwnedDomainsList({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<DomainsBloc, DomainsState>(
        builder: (context, state) => Column(children: [
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.userDomainsListTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          switch (state) {
            LoadingDomainsState() => const Center(
                child: CircularProgressIndicator(),
              ),
            DomainsStateData domainsStateData =>
              _buildDomainList(context, domainsStateData),
            UnavailableDomainsState() => Text(
                AppLocalizations.of(context)!.userDomainsListUnavailable,
              ),
          }
        ]),
      );

  Widget _buildDomainList(BuildContext context, DomainsStateData state) {
    if (state.domains.isEmpty) {
      return Text(AppLocalizations.of(context)!.userDomainsListEmpty);
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.domains.length,
      itemBuilder: (context, index) => OwnedDomainListItem(
        domain: state.domains[index],
      ),
    );
  }
}

class OwnedDomainListItem extends StatelessWidget {
  final Domain domain;

  const OwnedDomainListItem({required this.domain, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(domain.domainName),
      subtitle: Text(AppLocalizations.of(context)!.userDomainItemDescription(
        domain.type.name,
        domain.realAddress,
        domain.validUntilBlockNumber,
      )),
      trailing: IconButton(
        icon: const Icon(Icons.currency_exchange),
        tooltip: AppLocalizations.of(context)!.userDomainItemResellTooltip,
        onPressed: () => _onResellPressed(context),
      ),
    );
  }

  void _onResellPressed(BuildContext context) {
    // TODO: Implement resell domain page route
  }
}
