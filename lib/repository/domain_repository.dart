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
    // Simulate fake waiting time
    await Future.delayed(const Duration(milliseconds: 100));
    return null;
  }

  Future<Domain?> getDomainById(BigInt id) async {
    // Simulate fake waiting time
    await Future.delayed(const Duration(milliseconds: 100));
    return null;
  }

  Future<List<Domain>> getMyDomains() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.empty();
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
    if (domainName.endsWith(DomainInputValidator.domainSuffix)) {
      domainName = domainName.substring(
        0,
        domainName.length - DomainInputValidator.domainSuffix.length,
      );
    }

    final encodedDomain = domainEncoder.encode(domainName);
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.purchaseNewDomainFees(
      encodedDomain,
      encodedPointer,
      domainType,
    );
  }

  Future<String> purchaseNewDomain(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) async {
    if (domainName.endsWith(DomainInputValidator.domainSuffix)) {
      domainName = domainName.substring(
        0,
        domainName.length - DomainInputValidator.domainSuffix.length,
      );
    }

    final encodedDomain = domainEncoder.encode(domainName);
    final encodedPointer = switch (domainType) {
      DomainType.ipfs => ipfsCidEncoder.encode(pointedAddress),
      DomainType.tor => torAddressEncoder.encode(pointedAddress),
    };
    return contract.purchaseNewDomain(
      encodedDomain,
      encodedPointer,
      domainType,
    );
  }
}
