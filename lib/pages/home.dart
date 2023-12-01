import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/bloc/domain_search/domain_search_bloc.dart';
import 'package:gethdomains/routing/router.dart';
import 'package:gethdomains/widget/domain_search/domain_search.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';
import 'package:gethdomains/widget/gradient_background.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    // Inject the BLoC locally in this route
        create: (context) => DomainSearchBloc(
          domainRepository: context.read(),
        ),
        child: Builder(
            builder: (context) => Stack(
                  children: [
                    const GradientBackground(),
                    _buildContent(context),
                  ],
                )),
      );

  Widget _buildContent(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: gethAppBar(context, backgroundColor: Colors.transparent),
        body: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.homeAppDescription,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),
              DomainSearchForm(
                onSubmit: (domain) => onDomainSearch(context, domain),
                onRegister: (domain) =>
                    requestDomainRegistration(context, domain),
              ),
            ],
          ),
        ),
      );

  void onDomainSearch(BuildContext context, String domain) {
    final domainSearchBloc = context.read<DomainSearchBloc>();
    domainSearchBloc.search(domain);
  }

  void requestDomainRegistration(BuildContext context, String domain) {
    context.router.navigate(DomainRegistrationRoute(
      searchedDomain: domain,
    ));
  }
}
