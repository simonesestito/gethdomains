import "package:reactive_forms/reactive_forms.dart";

class DomainInputValidator extends Validator<String> {
  static const String validationName = 'domainFormat';
  static const String domainSuffix = '.geth';
  static final _domainPattern = RegExp(r'^[a-z]+\.geth$');
  static final _validators = [
    Validators.required,
    PatternValidator(
      RegExpPatternEvaluator(_domainPattern),
      validationMessage: validationName,
    ),
    Validators.minLength(3 + domainSuffix.length),
  ];

  const DomainInputValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    for (final validator in _validators) {
      final result = validator.validate(control);
      if (result != null) {
        return result;
      }
    }
    return null;
  }
}
