import 'dart:math';
import 'package:gethdomains/model/domain.dart';

class DomainRepository {
  Future<Domain?> searchDomain(String domainName) async {
    // Simulate fake waiting time
    await Future.delayed(const Duration(seconds: 1));

    // with probability 0.4, throw an exception
    if (Random().nextDouble() < 0.4) {
      throw Exception('Error searching domain');
    }

    final mockDomain = Domain(
      domainName: 'test.eth',
      realAddress: 'QmZiSAYkU7gZtqYeZWL21yuwgFtRnJu1JjDzR6Qd2qdDBr',
      type: DomainType.ipfs,
      owner: '0x000000000000000000000000000000000000dead',
      validUntil: DateTime(2023, 12, 31),
    );

    if (domainName == mockDomain.domainName) {
      return mockDomain;
    } else {
      return null;
    }
  }
}