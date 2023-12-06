import 'dart:math';

import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';

class DomainRepository {
  const DomainRepository();

  Future<Domain?> searchDomain(String domainName) async {
    // Simulate fake waiting time
    await Future.delayed(const Duration(milliseconds: 100));

    // with some probability, throw an exception
    if (Random().nextDouble() < 0.25) {
      throw Exception('Error searching domain');
    }

    final mockDomain = const Domain(
      domainName: 'test${DomainInputValidator.domainSuffix}',
      realAddress:
          'bafybeifx7yeb55armcsxwwitkymga5xf53dxiarykms3ygqic223w5sk3m',
      type: DomainType.ipfs,
      owner: '0x000000000000000000000000000000000000dead',
      validUntilBlockNumber: 6000000,
    );

    if (domainName == mockDomain.domainName) {
      return mockDomain;
    } else {
      return null;
    }
  }
}
