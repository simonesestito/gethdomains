import 'package:data_encoder/data_encoder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain.freezed.dart';

@freezed
class Domain with _$Domain {
  const factory Domain({
    required String domainName,
    required String realAddress,
    required DomainType type,
    required String owner,
    required BigInt resoldTimes,
    required BigInt price,
  }) = _Domain;

  const Domain._();

  factory Domain.fromSmartContract(
    String originalDomain,
    Map<String, dynamic> data,
    IpfsCidEncoder ipfsCidEncoder,
    TorAddressEncoder torAddressEncoder,
  ) {
    final isTor = data['isTor'] == true;
    final decodedDomain = (isTor ? torAddressEncoder : ipfsCidEncoder)
        .decode(data['pointedAddress']);
    return Domain(
      domainName: originalDomain,
      realAddress: decodedDomain,
      type: isTor ? DomainType.tor : DomainType.ipfs,
      owner: data['owner'],
      resoldTimes: BigInt.parse(data['resoldTimes']),
      price: BigInt.parse(data['price']),
    );
  }

  bool get isForSale => price.compareTo(BigInt.zero) > 0;
}

enum DomainType {
  @JsonValue('ipfs')
  ipfs,
  @JsonValue('tor')
  tor,
}
