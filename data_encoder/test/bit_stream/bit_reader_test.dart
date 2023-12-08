import 'dart:typed_data';

import 'package:data_encoder/src/bit_stream/bit_reader.dart';
import 'package:test/test.dart';

void main() {
  group('BitReader', () {
    const bits1String = '11101000';
    final bits1Int = int.parse(bits1String, radix: 2);

    const bits2String = '1011';
    final bits2IntPadded = int.parse(bits2String+('0'*4), radix: 2);
    final bits2Int = int.parse(bits2String, radix: 2);

    Uint8List buffer = Uint8List.fromList([bits1Int, bits2IntPadded]);
    var bitReader = BitReader(buffer: buffer);

    setUp(() {
      buffer = Uint8List.fromList([bits1Int, bits2IntPadded]);
      bitReader = BitReader(buffer: buffer);
    });

    test('Read 8 bits, all at once', () {
      expect(bitReader.readBits(8), bits1Int);
    });

    test('Read 8 bits, one by one', () {
      for (final bit in bits1String.split('')) {
        expect(bitReader.readBit(), bit == '1');
      }
    });

    test('Read 7 bits, all at once', () {
      final partialBits1String = bits1String.substring(0, 7);
      final partialBits1Int = int.parse(partialBits1String, radix: 2);
      expect(bitReader.readBits(7), partialBits1Int);
    });

    test('Read 12 bits, one by one', () {
      for (int i = 0; i < 8; i++) {
        final bit = bits1String[i];
        expect(bitReader.readBit(), bit == '1', reason: 'bit [bits1Int].$i');
      }
      for (int i = 0; i < 4; i++) {
        final bit = bits2String[i];
        expect(bitReader.readBit(), bit == '1', reason: 'bit [bits2Int].$i');
      }
    });

    test('Read 12 bits, all at once', () {
      expect(bitReader.readBits(8), bits1Int, reason: 'bits1Int');
      expect(bitReader.readBits(4), bits2Int, reason: 'bits2Int');
    });
  });
}
