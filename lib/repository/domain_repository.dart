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

    const mockDomains = [
      Domain(
        domainName: 'test${DomainInputValidator.domainSuffix}',
        realAddress:
            'bafybeifx7yeb55armcsxwwitkymga5xf53dxiarykms3ygqic223w5sk3m',
        type: DomainType.ipfs,
        owner: '0x000000000000000000000000000000000000dead',
        validUntilBlockNumber: 6000000,
      ),
      Domain(
        domainName: 'tor${DomainInputValidator.domainSuffix}',
        realAddress:
            'duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion',
        type: DomainType.tor,
        owner: '0x000000000000000000000000000000000000dead',
        validUntilBlockNumber: 6000000,
      ),
    ];

    // ignore: unnecessary_cast
    return mockDomains.map((d) => d as Domain?).firstWhere(
      (domain) => domain?.domainName == domainName,
      orElse: () => null,
    );
  }
}
