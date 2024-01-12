import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/contracts/geth_domains.dart';

class SellingRepository {
  final GethDomainsContract domainsContract;
  final DomainEncoder domainEncoder;

  const SellingRepository({
    required this.domainsContract,
    required this.domainEncoder,
  });

  Future<BigInt> getSellDomainFees(String domain, BigInt price) =>
      domainsContract.sellDomainFees(domainEncoder.encode(domain), price);

  Future<String> sellDomain(String domain, BigInt price) =>
      domainsContract.sellDomain(domainEncoder.encode(domain), price);

  Future<String> unlistDomainFromSelling(String domain) =>
      domainsContract.unlistDomainFromSelling(domainEncoder.encode(domain));
}
