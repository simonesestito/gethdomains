import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/widget/gradient_background.dart';

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
        appBar: _buildAppBar(),
        body: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Discover the new domain name system, decentralized',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: const Text('Geth Domains'),
        backgroundColor: Colors.transparent,
      );
}
