import 'dart:typed_data';

import 'package:cid/cid.dart';

import '../encoder.dart';
import 'multibase.dart' as multibase;

class IpfsCidEncoder implements AbstractEncoder {
  const IpfsCidEncoder();

  @override
  bool isValid(String cid) {
    try {
      CID.decodeCid(cid);
      return true;
    } catch (err) {
      print('Error validating CID: $err');
      return false;
    }
  }

  @override
  Uint8List encode(String cid) {
    final cidV1 = _toCidV1(cid);
    // The library will take care of determining the base
    final decodedCidWithVersion = multibase.decodeInputStringWithBase(
      multibase.getMultibaseFromCode(cidV1[0]),
      cidV1,
    );

    // Remove the first decoded byte, which is the CID version
    // In this case, it's always 0x01 (we converted to V1 above)
    assert(decodedCidWithVersion[0] == 0x01);

    // Remove the first byte, which is the CID version
    // since it's always the same (0x01)
    final decodedCid = decodedCidWithVersion.sublist(1);
    return decodedCid;
  }

  /// Takes a CID in any base and returns it in the preferred base
  /// However, it will work only if the input CID is in V1
  @override
  String decode(Uint8List cidBytes,
      [Multibase base = Multibase.base58btc]) {
    // Add the CID version byte (0x01) to the beginning of the CID
    final cidBytesWithVersion = Uint8List(cidBytes.length + 1);
    cidBytesWithVersion[0] = 0x01;
    cidBytesWithVersion.setRange(1, cidBytesWithVersion.length, cidBytes);

    // Encode the CID in the specified base
    final cid =
        multibase.encodeInputMultihashWithBase(base, cidBytesWithVersion);
    return cid; // It will already have the 'm' prefix (or whatever the base is)
  }

  /// Convert a [cid] to V1, in whatever base
  String _toCidV1(String cid) {
    final cidInfo = CID.decodeCid(cid)..toV1();
    return cidInfo.cid;
  }
}
