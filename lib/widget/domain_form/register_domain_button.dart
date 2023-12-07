import 'package:flutter/material.dart';

class RegisterDomainButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const RegisterDomainButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      onPressed: onPressed,
      label: Text(label),
      icon: const Icon(Icons.app_registration),
    );
  }
}
