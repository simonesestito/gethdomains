import "package:reactive_forms/reactive_forms.dart";

class DomainInputValidator extends PatternValidator {
  static final _domainPattern = RegExp(r'^[a-z]+\.eth$');

  DomainInputValidator() : super(RegExpPatternEvaluator(_domainPattern));
}