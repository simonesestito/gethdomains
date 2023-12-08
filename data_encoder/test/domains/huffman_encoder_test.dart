import 'dart:math';

import 'package:data_encoder/src/domains/huffman/huffman_encoder.dart';
import 'package:test/test.dart';

void main() {
  group('HuffmanEncoder', () {
    test('Encode and decode ernu', () {
      final encoded = HuffmanEncoder().encode('ernu');
      final decoded = HuffmanEncoder().decode(encoded);
      expect(decoded, 'ernu');
    });

    test('Encode and decode ernutellaisonfire', () {
      final encoded = HuffmanEncoder().encode('ernutellaisonfire');
      final decoded = HuffmanEncoder().decode(encoded);
      expect(decoded, 'ernutellaisonfire');
    });

    test('Encode and decode 1000 random strings of length between 1 and 10', () {
      final random = Random();
      for (int i = 0; i < 1000; i++) {
        final length = random.nextInt(10) + 1;
        final chars = List.generate(length, (_) => String.fromCharCode(random.nextInt(26) + 97));
        final string = chars.join('');
        final encoded = HuffmanEncoder().encode(string);
        final decoded = HuffmanEncoder().decode(encoded);
        expect(decoded, string, reason: 'string: $string');
      }
    });
  });
}
