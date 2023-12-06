import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain.freezed.dart';

@freezed
class Domain with _$Domain {
  const factory Domain({
    required String domainName,
    required String realAddress,
    required DomainType type,
    required String owner,
    required int validUntilBlockNumber,
  }) = _Domain;
}

enum DomainType {
  @JsonValue('ipfs')
  ipfs,
  @JsonValue('tor')
  tor,
}