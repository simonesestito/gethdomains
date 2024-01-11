import 'package:oracle/domain_type.dart';

import 'ipfs.dart';
import 'tor.dart';

abstract class IVerifier {
  Future<bool> verify(String domain);

  factory IVerifier.forType(DomainType type) => switch (type) {
        DomainType.tor => TorVerifier(),
        DomainType.ipfs => IpfsVerifier(),
      };
}
