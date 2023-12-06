import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;
  final AlignmentGeometry alignment;

  const BodyContainer({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: child,
        ),
      );
}
