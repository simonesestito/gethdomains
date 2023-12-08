import 'dart:math';

import 'package:cid/cid.dart';
import 'package:data_encoder/src/ipfs/ipfs_cid_encoder.dart';
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
  group('IPFS', () {
    const validIpfsV0 = 'QmbWqxBEKC3P8tqsKc98xmWNzrzDtRLMiMPL8wBuTGsMnR';
    const validIpfsV1Base64 = 'mAXASIMPEcz7Ir/0Gz56f9Q/8a80uyFphcABLtwlmnDHelDka';
    const validIpfsV1Base32 = 'bafybeifx7yeb55armcsxwwitkymga5xf53dxiarykms3ygqic223w5sk3m';
    const validIpfsV1Base58 = 'zdj7Whp8MXSDAgmwiv8f7UBseBzjYfTXiNm7Nk9m4GpZzoHCW';

    const invalidIpfsV0 = 'QebWqxBEKC3P8tqsKc98xmWNzrzDtRLMiMPL8wBuTGsMnR';
    const invalidIpfsV1Base64 = 'mbXASIMPEcz7Ir/0Gz56f9Q/8a80uyFphcABLtwlmnDHelDka';
    const invalidIpfsV1Base32 = 'bcfybeifx7yeb55armcsxwwitkymga5xf53dxiarykms3ygqic223w5sk3m';
    const invalidIpfsV1Base58 = 'zek7Whp8MXSDAgmwiv8f7UBseBzjYfTXiNm7Nk9m4GpZzoHCW';

    const ipfs = IpfsCidEncoder();

    test('Encode and decode a valid IPFS CID v0', () {
      final encoded = ipfs.encode(validIpfsV0);
      final decoded = ipfs.decode(encoded);
      expect(isValid(decoded), true, reason: 'decoded: $decoded');
    });

    test('Re-encoding a valid IPFS CID v0 should not change the content', () {
      final encoded = ipfs.encode(validIpfsV0);
      final decoded = ipfs.decode(encoded);
      final reEncoded = ipfs.encode(decoded);
      expect(reEncoded, encoded);
    });

    test('Encode and decode a valid IPFS CID v1 base64', () {
      final encoded = ipfs.encode(validIpfsV1Base64);
      final decoded = ipfs.decode(encoded);
      expect(isValid(decoded), true, reason: 'decoded: $decoded');
    });

    test('Re-encoding a valid IPFS CID v1 base64 should not change the content', () {
      final encoded = ipfs.encode(validIpfsV1Base64);
      final decoded = ipfs.decode(encoded);
      final reEncoded = ipfs.encode(decoded);
      expect(reEncoded, encoded);
    });

    test('Encode and decode a valid IPFS CID v1 base32', () {
      final encoded = ipfs.encode(validIpfsV1Base32);
      final decoded = ipfs.decode(encoded);
      expect(isValid(decoded), true, reason: 'decoded: $decoded');
    });

    test('Re-encoding a valid IPFS CID v1 base32 should not change the content', () {
      final encoded = ipfs.encode(validIpfsV1Base32);
      final decoded = ipfs.decode(encoded);
      final reEncoded = ipfs.encode(decoded);
      expect(reEncoded, encoded);
    });

    test('Encode and decode a valid IPFS CID v1 base58', () {
      final encoded = ipfs.encode(validIpfsV1Base58);
      final decoded = ipfs.decode(encoded);
      expect(isValid(decoded), true, reason: 'decoded: $decoded');
    });

    test('Re-encoding a valid IPFS CID v1 base58 should not change the content', () {
      final encoded = ipfs.encode(validIpfsV1Base58);
      final decoded = ipfs.decode(encoded);
      final reEncoded = ipfs.encode(decoded);
      expect(reEncoded, encoded);
    });

    test('Throw on invalid IPFS CID v0', () {
      expect(() => ipfs.encode(invalidIpfsV0), throwsException);
    });

    test('Throw on invalid IPFS CID v1 base64', () {
      expect(() => ipfs.encode(invalidIpfsV1Base64), throwsException);
    });

    test('Throw on invalid IPFS CID v1 base32', () {
      expect(() => ipfs.encode(invalidIpfsV1Base32), throwsException);
    });

    test('Throw on invalid IPFS CID v1 base58', () {
      expect(() => ipfs.encode(invalidIpfsV1Base58), throwsException);
    });
  });
}
