import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/widget/geth_app_bar.dart';

@RoutePage()
class DomainRegistrationPage extends StatelessWidget {
  final String searchedDomain;

  const DomainRegistrationPage({super.key, required this.searchedDomain});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: gethAppBar(context),
      body: Center(
        child: Text('Domain Registration for $searchedDomain'),
      ),
    );
  }
}
