import 'dart:typed_data';

import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/contracts/geth_domains.dart';
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
      domainEncoder.encode(domainName),
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
      domainEncoder.encode(domainName),
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
      domainEncoder.encode(domainName),
      encodedPointer,
      domainType,
    );
  }

  void addDomainToMetamask(Domain domain) {
    contract.addDomainToMetamask(domainEncoder.encode(domain.domainName));
  }

  Future<BigInt> estimateDomainEditFees(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) {
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.editDomainPointerFees(
      domainEncoder.encode(domainName),
      encodedPointer,
      domainType,
    );
  }

  Future<String> editDomainPointer(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) async {
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.editDomainPointer(
      domainEncoder.encode(domainName),
      encodedPointer,
      domainType,
    );
  }

  Future<String> getDomainOriginalOwner(String domainName) async {
    return contract.getDomainOriginalOwner(domainEncoder.encode(domainName));
  }
}
