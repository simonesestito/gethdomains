import 'dart:math';

import 'package:data_encoder/src/domains/five_bits_encoder.dart';
import 'package:test/test.dart';

void main() {
  group('FiveBitsEncoder', () {
    test('Encode ernu', () {
      final encoded = FiveBitsEncoder().encode('ernu');
      expect(encoded, [
        int.parse('0 00101 10'.replaceAll(' ', ''), radix: 2),
        int.parse('010 01110'.replaceAll(' ', ''), radix: 2),
        int.parse('10101 000'.replaceAll(' ', ''), radix: 2),
      ]);
    });

    test('Encode and decode ernu', () {
      final encoded = FiveBitsEncoder().encode('ernu');
      final decoded = FiveBitsEncoder().decode(encoded);
      expect(decoded, 'ernu');
    });

    test('Encode and decode ernutellaisonfire', () {
      final encoded = FiveBitsEncoder().encode('ernutellaisonfire');
      final decoded = FiveBitsEncoder().decode(encoded);
      expect(decoded, 'ernutellaisonfire');
    });

    test('Encode and decode 1000 random strings of length between 1 and 10', () {
      final random = Random();
      for (int i = 0; i < 1000; i++) {
        final length = random.nextInt(10) + 1;
        final chars = List.generate(length, (_) => String.fromCharCode(random.nextInt(26) + 97));
        final string = chars.join('');
        final encoded = FiveBitsEncoder().encode(string);
        final decoded = FiveBitsEncoder().decode(encoded);
        expect(decoded, string, reason: 'string: $string');
      }
    });
  });
}
