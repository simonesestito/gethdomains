import 'dart:math';

import 'package:data_encoder/src/domains/domain_encoder.dart';
import 'package:data_encoder/src/domains/five_bits_encoder.dart';
import 'package:data_encoder/src/domains/huffman/huffman_encoder.dart';
import 'package:test/test.dart';

const _domainSuffix = '.geth';

void main() {
  group('DomainEncoder', () {
    test('Encode and decode ernu', () {
      final encoded = DomainEncoder(domainSuffix: _domainSuffix).encode('ernu');
      final decoded =
          DomainEncoder(domainSuffix: _domainSuffix).decode(encoded);
      expect(decoded, 'ernu');
    });

    test('Encode and decode ernutellaisonfire', () {
      final encoded = DomainEncoder(domainSuffix: _domainSuffix)
          .encode('ernutellaisonfire');
      final decoded =
          DomainEncoder(domainSuffix: _domainSuffix).decode(encoded);
      expect(decoded, 'ernutellaisonfire');
    });

    test('Encode and decode 1000 random strings of length between 1 and 10', () {
      final random = Random();
      for (int i = 0; i < 1000; i++) {
        final length = random.nextInt(10) + 1;
        final chars = List.generate(
            length, (_) => String.fromCharCode(random.nextInt(26) + 97));
        final string = chars.join('');
        final encoded =
            DomainEncoder(domainSuffix: _domainSuffix).encode(string);
        final decoded =
            DomainEncoder(domainSuffix: _domainSuffix).decode(encoded);
        expect(decoded, string, reason: 'string: $string');
      }
    });

    test('Encode "soia" using HuffmanEncoder', () {
      final encoded = DomainEncoder(domainSuffix: _domainSuffix).encode('soia');
      expect(encoded[0] & 0x80 == 0x80, HuffmanEncoder.techniqueIdentifier);
    });

    test('Encode "xzq" using FiveBitsEncoder', () {
      final encoded = DomainEncoder(domainSuffix: _domainSuffix).encode('xzq');
      expect(encoded[0] & 0x80 == 0x80, FiveBitsEncoder.techniqueIdentifier);
    });
  });
}
