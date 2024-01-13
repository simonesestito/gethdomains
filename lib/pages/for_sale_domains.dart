import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/selling/selling_bloc.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';

@RoutePage()
class ForSaleDomainsPage extends StatelessWidget {
  const ForSaleDomainsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: gethAppBar(
          context,
          title: AppLocalizations.of(context)!.forSaleDomainsTitle,
        ),
        body: BlocBuilder<SellingBloc, SellingState>(
          builder: (context, state) {
            if (state is SellingLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SellingError) {
              return Center(
                child: Text(AppLocalizations.of(context)!.forSaleDomainsError),
              );
            }

            if (state is SellingData && state.domains.isEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.remove_shopping_cart),
                      const SizedBox(height: 24),
                      Text(AppLocalizations.of(context)!.forSaleDomainsEmpty),
                    ],
                  ),
                ],
              );
            }

            if (state is SellingData /* && state.domains.isNotEmpty */) {
              return ListView.separated(
                itemCount: state.domains.length,
                itemBuilder: (context, index) {
                  final domain = state.domains[index];
                  return ListTile(
                    title: Text(
                      domain.domainName + DomainInputValidator.domainSuffix,
                    ),
                    subtitle: Text('${domain.price} GETH'),
                    trailing: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        // TODO: Add buy domain
                      },
                    ),
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              );
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
