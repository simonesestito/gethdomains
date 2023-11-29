import 'dart:math';

import 'package:flutter/material.dart';

class DomainSearchForm extends StatelessWidget {
  const DomainSearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: integrate reactive_forms
    return const Form(child: _DomainSearchField());
  }
}

class _DomainSearchField extends StatelessWidget {
  const _DomainSearchField();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final minWidth = constraints.maxWidth * 0.8;
      const maxWidth = 800.0;

      return SizedBox(
        width: min(minWidth, maxWidth),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search for a domain',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.secondary.withAlpha(100),
            prefixIcon: const Icon(Icons.search),
            prefixIconColor: Theme.of(context).iconTheme.color,
          ),
        ),
      );
    });
  }
}
