import '../encoder.dart';


abstract class AbstractDomainEncoder extends AbstractEncoder {
  /// Check if the given [domain] is valid to be encoded.
  @override
  bool isValid(String domain) {
    if (domain.isEmpty) {
      return false;
    }

    // Check that every char of the domain is lowercase letter
    for (final char in domain.split('')) {
      if (char.codeUnitAt(0) < 97 || char.codeUnitAt(0) > 122) {
        return false;
      }
    }

    return true;
  }
}
