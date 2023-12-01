import "package:flutter/cupertino.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:reactive_forms/reactive_forms.dart";

class DomainInputValidator extends Validator<String> {
  static const String domainSuffix = '.geth';
  static final _domainPattern = RegExp(r'^[a-z]+\.geth$');
  static final _validators = [
    Validators.required,
    PatternValidator(RegExpPatternEvaluator(_domainPattern)),
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

  static Map<String, String Function(Object)> getValidationMessages(
          BuildContext context) =>
      {
        ValidationMessage.required: (_) =>
            AppLocalizations.of(context)!.inputErrorRequired,
        ValidationMessage.minLength: (_) =>
            AppLocalizations.of(context)!.inputErrorDomainTooShort,
        ValidationMessage.pattern: (_) =>
            AppLocalizations.of(context)!.inputErrorDomainInvalid(
              DomainInputValidator.domainSuffix,
            ),
      };
}
