import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/routing/router.dart';
import 'package:provider/provider.dart';

class OwnedDomainListItem extends StatelessWidget {
  final Domain domain;
  final bool isLoading;

  const OwnedDomainListItem({
    required this.domain,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(domain.domainName + DomainInputValidator.domainSuffix),
      subtitle: Text(AppLocalizations.of(context)!.userDomainItemDescription(
        domain.type.name,
        domain.realAddress,
      )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => _onAddToMetamask(context),
            icon: const Icon(Icons.add_link),
            tooltip: AppLocalizations.of(context)!
                .userDomainItemAddToMetamaskTooltip,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.userDomainItemEditTooltip,
            onPressed: () => _onEditPressed(context),
          ),
          if (domain.isForSale)
            IconButton(
              icon: const Icon(Icons.money_off),
              tooltip: AppLocalizations.of(context)!.userDomainItemCancelSale,
              onPressed:
                  isLoading ? null : () => _onRemoveFromSalePressed(context),
            )
          else
            IconButton(
              icon: const Icon(Icons.currency_exchange),
              tooltip:
                  AppLocalizations.of(context)!.userDomainItemResellTooltip,
              onPressed: isLoading ? null : () => _onResellPressed(context),
            ),
        ],
      ),
    );
  }

  void _onResellPressed(BuildContext context) {
    context.router.navigate(DomainSellingRoute(
      sellingDomain: domain.domainName,
    ));
  }

  void _onRemoveFromSalePressed(BuildContext context) {
    context.read<DomainsBloc>().unlistDomain(domain.domainName);
  }

  void _onEditPressed(BuildContext context) {
    context.router.navigate(DomainEditingRoute(editingDomain: domain));
  }

  void _onAddToMetamask(BuildContext context) {
    context.read<DomainRepository>().addDomainToMetamask(domain);
  }
}
