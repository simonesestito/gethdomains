import 'dart:typed_data';

import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/contracts/geth_domains.dart';
import 'package:gethdomains/model/domain.dart';

class SellingRepository {
  final GethDomainsContract domainsContract;
  final DomainEncoder domainEncoder;
  final IpfsCidEncoder ipfsCidEncoder;
  final TorAddressEncoder torAddressEncoder;

  const SellingRepository({
    required this.domainsContract,
    required this.domainEncoder,
    required this.ipfsCidEncoder,
    required this.torAddressEncoder,
  });

  Future<BigInt> getSellDomainFees(String domain, BigInt price) =>
      domainsContract.sellDomainFees(domainEncoder.encode(domain), price);

  Future<String> sellDomain(String domain, BigInt price) =>
      domainsContract.sellDomain(domainEncoder.encode(domain), price);

  Future<String> unlistDomainFromSelling(String domain) =>
      domainsContract.unlistDomainFromSelling(domainEncoder.encode(domain));

  Future<List<Domain>> getDomainsForSale() async {
    final jsonResult = await domainsContract.getDomainsForSale();
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

  Future<String> buyDomain(Domain domain) => domainsContract.buyDomain(
        domainEncoder.encode(domain.domainName),
        domain.price,
      );
}
