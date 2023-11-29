import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/widget/domain_search/domain_search.dart';
import 'package:gethdomains/widget/gradient_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          const GradientBackground(),
          _buildContent(context),
        ],
      );

  Widget _buildContent(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
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
              DomainSearchForm(onSubmit: onDomainSearch),
            ],
          ),
        ),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
        backgroundColor: Colors.transparent,
      );

  void onDomainSearch(String domain) {
    debugPrint(domain);
  }
}
