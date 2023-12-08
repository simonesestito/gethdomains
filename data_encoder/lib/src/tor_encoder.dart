import 'dart:typed_data';
import 'package:base32/base32.dart';
import 'encoder.dart';
import 'package:sha3/sha3.dart';

/// Parse v3 Tor addresses
class TorAddressEncoder implements AbstractEncoder {
  const TorAddressEncoder();

  @override
  Uint8List encode(String address) {
    if (!address.endsWith('.onion')) {
      throw const FormatException('Tor address must end with ".onion"');
    }

    // A Tor address (v3) is encoded as shown below:
    //
    //      onion_address = base32(PUBKEY | CHECKSUM | VERSION) + ".onion"
    //      CHECKSUM = H(".onion checksum" | PUBKEY | VERSION)[:2]
    //
    //      where:
    //        - PUBKEY is the 32 bytes ed25519 master pubkey of the hidden service.
    //        - VERSION is a one byte version field (default value '\x03')
    //        - ".onion checksum" is a constant string
    //        - CHECKSUM is truncated to two bytes before inserting it in onion address
    //
    final nonOnionAddress =
        address.substring(0, address.length - '.onion'.length).toUpperCase();

    final decoded = base32.decode(nonOnionAddress);

    // The first 32 bytes are the public key
    if (decoded.length != (32 + 2 + 1)) {
      throw FormatException(
          'Invalid Tor address, invalid size (${decoded.length}})');
    }

    final pubKey = decoded.sublist(0, 32);
    final checksum = decoded.sublist(32, 32 + 2);
    final version = decoded[32 + 2];

    if (version != 0x03) {
      throw FormatException('Invalid Tor address, invalid version ($version)');
    }

    final expectedChecksum = _computeChecksum(pubKey, version);
    if (expectedChecksum[0] != checksum[0] ||
        expectedChecksum[1] != checksum[1]) {
      throw const FormatException('Invalid Tor address, invalid checksum');
    }

    return pubKey;
  }

  @override
  bool isValid(String address) {
    try {
      encode(address);
      return true;
    } on FormatException catch (err) {
      print('Tor parsing error: $err');
      return false;
    }
  }

  @override
  String decode(Uint8List data) {
    //      onion_address = base32(PUBKEY | CHECKSUM | VERSION) + ".onion"
    //      CHECKSUM = H(".onion checksum" | PUBKEY | VERSION)[:2]
    final checksum = _computeChecksum(data, 0x03);
    final checksummedData = Uint8List.fromList([
      ...data,
      ...checksum,
      0x03,
    ]);

    final encoded = base32.encode(checksummedData).toLowerCase();
    return '$encoded.onion';
  }

  Uint8List _computeChecksum(Uint8List pubKey, int version) {
    final checksumPrefix = '.onion checksum'.codeUnits;
    final checksumContent = Uint8List.fromList([
      ...checksumPrefix,
      ...pubKey,
      version,
    ]);

    final checksum = SHA3(256, SHA3_PADDING, 256)..update(checksumContent);
    return Uint8List.fromList(checksum.digest().sublist(0, 2));
  }
}
