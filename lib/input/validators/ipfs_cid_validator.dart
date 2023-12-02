import 'package:gethdomains/input/ipfs_cid_parser.dart';
import "package:reactive_forms/reactive_forms.dart";

class IpfsCidValidator extends Validator<String> {
  final cidParser = const IpfsCidParser();
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

    assert(cidParser
        .isValid(cidParser.fromBinaryV1(cidParser.toBinary(control.value!)!)));

    return null;
  }
}
