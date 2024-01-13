import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gethdomains/routing/router.dart';

class ForSaleDomainsIconButton extends StatelessWidget {
  const ForSaleDomainsIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.router.push(const ForSaleDomainsRoute());
      },
      icon: const Icon(Icons.sell),
    );
  }
}
