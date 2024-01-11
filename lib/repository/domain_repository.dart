import 'dart:typed_data';

import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/contracts/geth_domains.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';

class DomainRepository {
  final GethDomainsContract contract;
  final IpfsCidEncoder ipfsCidEncoder;
  final TorAddressEncoder torAddressEncoder;
  final DomainEncoder domainEncoder;

  const DomainRepository({
    required this.contract,
    required this.ipfsCidEncoder,
    required this.torAddressEncoder,
    required this.domainEncoder,
  });

  Future<Domain?> searchDomain(String domainName) async {
    final jsonResult = await contract.searchDomain(
      _encodeDomain(domainName),
    );
    if (jsonResult == null) {
      return null;
    }

    return Domain.fromSmartContract(
      domainName,
      jsonResult,
      ipfsCidEncoder,
      torAddressEncoder,
    );
  }

  Future<List<Domain>> getMyDomains() async {
    final jsonResult = await contract.getMyDomains();
    return jsonResult.map((jsonItem) {
      final domainName = jsonItem['domain'] as Uint8List;
      return Domain.fromSmartContract(
        domainEncoder.decode(domainName),
        jsonItem,
        ipfsCidEncoder,
        torAddressEncoder,
      );
    }).toList();
  }

  Future<List<Domain>> getDomainsForSale() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.empty();
  }

  Future<BigInt> predictDomainPurchaseFees(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) {
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.purchaseNewDomainFees(
      _encodeDomain(domainName),
      encodedPointer,
      domainType,
    );
  }

  Future<String> purchaseNewDomain(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) async {
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.purchaseNewDomain(
      _encodeDomain(domainName),
      encodedPointer,
      domainType,
    );
  }

  Uint8List _encodeDomain(String domain) {
    if (domain.endsWith(DomainInputValidator.domainSuffix)) {
      domain = domain.substring(
        0,
        domain.length - DomainInputValidator.domainSuffix.length,
      );
    }

    return domainEncoder.encode(domain);
  }
}
