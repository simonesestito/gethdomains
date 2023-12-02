import 'package:cid/cid.dart';
import 'package:cid/src/multibase.dart' as multibase;
import 'package:flutter/foundation.dart';

class IpfsCidParser {
  const IpfsCidParser();

  bool isValid(String cid) {
    try {
      CID.decodeCid(cid);
      return true;
    } catch (err) {
      debugPrint('Error validating CID: $err');
      return false;
    }
  }

  Uint8List? toBinary(String cid) {
    try {
      return toBinaryOrThrow(cid);
    } catch (err) {
      debugPrint('Error parsing CID: $err');
      return null;
    }
  }

  Uint8List toBinaryOrThrow(String cid) {
    final cidV1 = _toCidV1(cid);
    debugPrint('CID V1 from lib: $cidV1');
    // The library will take care of determining the base
    final decodedCidWithVersion = multibase.decodeInputStringWithBase(
      multibase.getMultibaseFromCode(cidV1[0]),
      cidV1,
    );

    debugPrint(
        'Decoded CID with version (length = ${decodedCidWithVersion.length}): $decodedCidWithVersion');

    // Remove the first decoded byte, which is the CID version
    // In this case, it's always 0x01 (we converted to V1 above)
    assert(decodedCidWithVersion[0] == 0x01);

    // Remove the first byte, which is the CID version
    // since it's always the same (0x01)
    final decodedCid = decodedCidWithVersion.sublist(1);
    debugPrint('Decoded CID (length = ${decodedCid.length}): $decodedCid');
    return decodedCid;
  }

  /// Takes a CID in any base and returns it in the preferred base
  /// However, it will work only if the input CID is in V1
  String fromBinaryV1(Uint8List cidBytes,
      [Multibase base = Multibase.base58btc]) {
    // Add the CID version byte (0x01) to the beginning of the CID
    final cidBytesWithVersion = Uint8List(cidBytes.length + 1);
    cidBytesWithVersion[0] = 0x01;
    cidBytesWithVersion.setRange(1, cidBytesWithVersion.length, cidBytes);

    debugPrint('CID bytes with version: $cidBytesWithVersion');

    // Encode the CID in the specified base
    final cid =
        multibase.encodeInputMultihashWithBase(base, cidBytesWithVersion);
    debugPrint('Reconstructed CID: $cid');
    return cid; // It will already have the 'm' prefix (or whatever the base is)
  }

  /// Convert a [cid] to V1, in whatever base
  String _toCidV1(String cid) {
    final cidInfo = CID.decodeCid(cid)..toV1();
    return cidInfo.cid;
  }
}
