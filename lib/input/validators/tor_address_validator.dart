import 'package:data_encoder/data_encoder.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TorAddressValidator extends Validator<String> {
  static const String validationName = 'torFormat';

  final torParser = const TorAddressEncoder();

  const TorAddressValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    final requiredValidation = const RequiredValidator().validate(control);
    if (requiredValidation != null) {
      return requiredValidation;
    }

    if (!torParser.isValid(control.value!)) {
      return {validationName: true};
    }

    return null;
  }
}
