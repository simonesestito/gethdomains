import 'package:freezed_annotation/freezed_annotation.dart';

part 'ipfs_gateway.g.dart';

@JsonSerializable(constructor: '_')
class IpfsGateway {
  static final ipfsGateways = List.unmodifiable([
    // The first gateway is the default one.
    IpfsGateway._fromUrl('https://ipfs.io/ipfs/'),
    IpfsGateway._fromUrl('https://gateway.ipfs.io/ipfs/'),
    IpfsGateway._fromUrl('https://gateway.pinata.cloud/ipfs/'),
    IpfsGateway._fromUrl('https://storry.tv/ipfs/'),
  ]);

  final String name;
  final String url;

  const IpfsGateway._({
    required this.name,
    required this.url,
  });

  factory IpfsGateway._fromUrl(String url) {
    assert(url.startsWith('https://'));
    final name = url.split('/')[2];
    return IpfsGateway._(name: name, url: url);
  }

  Uri getGatewayUrl(String cid) => Uri.parse('$url$cid');

  factory IpfsGateway.fromJson(Map<String, dynamic> json) =>
      _$IpfsGatewayFromJson(json);

  Map<String, dynamic> toJson() => _$IpfsGatewayToJson(this);

  @override
  String toString() => 'IpfsGateway($name, $url)';

  @override
  bool operator ==(Object other) => other is IpfsGateway && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
