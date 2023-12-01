import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;

  const BodyContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
}
