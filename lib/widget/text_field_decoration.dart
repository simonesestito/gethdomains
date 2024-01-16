import 'package:flutter/material.dart';
import 'package:gethdomains/input/validators/messages.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveTextField<T> extends StatelessWidget {
  final String formControlName;
  final String hintText;
  final String? helperText;
  final ReactiveFormFieldCallback<T>? onSubmit;
  final ReactiveFormFieldCallback<T>? onChanged;
  final bool Function(FormControl<dynamic>)? showErrors;

  const AppReactiveTextField({
    super.key,
    required this.formControlName,
    this.helperText,
    required this.hintText,
    this.onSubmit,
    this.onChanged,
    this.showErrors,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControlName: formControlName,
      decoration: AppTextFieldDecoration(
        context,
        hintText: hintText,
        helperText: helperText,
      ),
      validationMessages: getValidationMessages(context),
      onChanged: onChanged,
      onEditingComplete: (form) {
        form.markAllAsTouched();
        if (form.parent?.valid != false && onSubmit != null) {
          onSubmit!(form);
        }
      },
      showErrors: showErrors,
    );
  }
}

class AppTextFieldDecoration extends InputDecoration {
  AppTextFieldDecoration(
    BuildContext context, {
    required String hintText,
    String? helperText,
  }) : super(
          hintText: hintText,
          helperText: helperText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
        );
}
