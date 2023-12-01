import 'package:cid/cid.dart';
import "package:reactive_forms/reactive_forms.dart";

class IpfsCidValidator extends Validator<String> {
  static const String validationName = 'ipfsFormat';

  const IpfsCidValidator() : super();

  @override
  Map<String, dynamic>? validate(AbstractControl<String> control) {
    final requiredValidation = const RequiredValidator().validate(control);
    if (requiredValidation != null) {
      return requiredValidation;
    }

    final cid = control.value!;
    try {
      CID.decodeCid(cid);
      return null;
    } catch (err) {
      return {validationName: true};
    }
  }
}
