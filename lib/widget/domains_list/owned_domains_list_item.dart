import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/routing/router.dart';

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
      )),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: AppLocalizations.of(context)!.userDomainItemEditTooltip,
            onPressed: () => _onEditPressed(context),
          ),
          IconButton(
            icon: const Icon(Icons.currency_exchange),
            tooltip: AppLocalizations.of(context)!.userDomainItemResellTooltip,
            onPressed: () => _onResellPressed(context),
          ),
        ],
      ),
    );
  }

  void _onResellPressed(BuildContext context) {
    // TODO: Implement resell domain page route
  }

  void _onEditPressed(BuildContext context) {
    context.router.navigate(DomainEditingRoute(editingDomain: domain));
  }
}
