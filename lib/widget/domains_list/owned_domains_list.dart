import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'owned_domains_list_item.dart';

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
