import 'package:data_encoder/src/bit_stream/bit_writer.dart';
import 'package:test/test.dart';

void main() {
  group('BitWriter', () {
    var bitWriter = BitWriter();

    setUp(() {
      bitWriter = BitWriter();
    });

    test('Write 8 bits, all at once', () {
      const bitsString = '11101000';
      final bitsInt = int.parse(bitsString, radix: 2);
      bitWriter.writeBits(bitsInt, 8);
      expect(bitWriter.getBuffer(), [bitsInt]);
    });

    test('Write 8 bits, one by one', () {
      const bitsString = '11101000';
      for (final bit in bitsString.split('')) {
        bitWriter.writeBit(bit == '1');
      }
      expect(bitWriter.getBuffer(), [int.parse(bitsString, radix: 2)]);
    });

    test('Write 7 bits, one by one', () {
      const bitsString = '1110100';
      for (final bit in bitsString.split('')) {
        bitWriter.writeBit(bit == '1');
      }
      expect(bitWriter.getBuffer(), [int.parse('${bitsString}0', radix: 2)]);
    });

    test('Write 7 bits, all at once', () {
      const bitsString = '1110100';
      final bitsInt = int.parse(bitsString, radix: 2);
      bitWriter.writeBits(bitsInt, 7);
      expect(bitWriter.getBuffer(), [int.parse('${bitsString}0', radix: 2)]);
    });

    test('Write 9 bits, all at once', () {
      const bitsString1 = '11101000';
      const bitsString2 = '1';
      bitWriter.writeBits(int.parse(bitsString1, radix: 2), 8);
      bitWriter.writeBits(int.parse(bitsString2, radix: 2), 1);
      expect(bitWriter.getBuffer(), [
        int.parse(bitsString1, radix: 2),
        int.parse(bitsString2+('0'*7), radix: 2),
      ]);
    });

    test('getBuffer must not alter inside buffer', () {
      const bitsString1 = '11101000';
      const bitsString2 = '1';
      bitWriter.writeBits(int.parse(bitsString1, radix: 2), 8);
      bitWriter.writeBits(int.parse(bitsString2, radix: 2), 1);

      expect(bitWriter.getBuffer(), [
        int.parse(bitsString1, radix: 2),
        int.parse(bitsString2+('0'*7), radix: 2),
      ]);

      const bitsString3 = '011';
      bitWriter.writeBits(int.parse(bitsString3, radix: 2), 3);
      expect(bitWriter.getBuffer(), [
        int.parse(bitsString1, radix: 2),
        int.parse(bitsString2+bitsString3+('0'*4), radix: 2),
      ]);
    });
  });
}
