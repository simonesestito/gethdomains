import 'package:flutter/material.dart';
import 'package:gethdomains/input/validators/messages.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppReactiveTextField<T> extends StatelessWidget {
  final String formControlName;
  final String hintText;
  final ReactiveFormFieldCallback<T> onSubmit;
  final ReactiveFormFieldCallback<T>? onChanged;

  const AppReactiveTextField({
    super.key,
    required this.formControlName,
    required this.hintText,
    required this.onSubmit,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<T>(
      formControlName: formControlName,
      decoration: AppTextFieldDecoration(
        context,
        hintText: hintText,
      ),
      validationMessages: getValidationMessages(context),
      onChanged: onChanged,
      onEditingComplete: (form) {
        form.markAllAsTouched();
        if (form.parent?.valid != false) {
          onSubmit(form);
        }
      },
    );
  }
}

class AppTextFieldDecoration extends InputDecoration {
  AppTextFieldDecoration(BuildContext context, {required String hintText})
      : super(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
        );
}
