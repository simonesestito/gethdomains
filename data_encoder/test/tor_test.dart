import 'package:cid/cid.dart';
import 'package:data_encoder/src/tor_encoder.dart';
import 'package:test/test.dart';

bool isValid(String cid) {
  try {
    CID.decodeCid(cid);
    return true;
  } catch (_) {
    return false;
  }
}

void main() {
  group('Tor', () {
    const validAddress =
        'duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion';
    const invalidAddress =
        'duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczbd.onionn';

    const tor = TorAddressEncoder();

    test('Encode a valid Tor address', () {
      final encoded = tor.encode(validAddress);
      expect(encoded.length, 32);
    });

    test('Encode and decode a valid Tor address', () {
      final encoded = tor.encode(validAddress);
      final decoded = tor.decode(encoded);
      expect(decoded, validAddress);
    });

    test('Throw an exception when encoding an invalid Tor address', () {
      expect(() => tor.encode(invalidAddress), throwsException);
    });
  });
}
