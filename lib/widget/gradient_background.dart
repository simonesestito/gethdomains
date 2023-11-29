import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final startColor = Theme.of(context).colorScheme.primary;
    final endColor = Theme.of(context).scaffoldBackgroundColor;

    // Create a Container with a Gradient, from top to bottom
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.2],
          colors: [startColor, endColor],
        ),
      ),
    );
  }
}
