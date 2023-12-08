import 'package:data_encoder/data_encoder.dart';
import "package:reactive_forms/reactive_forms.dart";

class IpfsCidValidator extends Validator<String> {
  final cidParser = const IpfsCidEncoder();
  static const String validationName = 'ipfsFormat';

  const IpfsCidValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    final requiredValidation = const RequiredValidator().validate(control);
    if (requiredValidation != null) {
      return requiredValidation;
    }

    if (!cidParser.isValid(control.value!)) {
      return {validationName: true};
    }

    return null;
  }
}
