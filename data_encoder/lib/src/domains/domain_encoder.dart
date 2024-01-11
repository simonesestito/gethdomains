import 'dart:typed_data';

import 'five_bits_encoder.dart';
import 'huffman/huffman_encoder.dart';
import 'interface.dart';

/// General encoder, which may use one technique or another,
/// depending on the one that generates the smallest output.
class DomainEncoder extends AbstractDomainEncoder {
  final char5BitsEncoder = const FiveBitsEncoder();
  final huffmanEncoder = const HuffmanEncoder();

  const DomainEncoder();

  @override
  Uint8List encode(String data) {
    final huffmanEncoded = huffmanEncoder.encode(data);

    // Determine if Huffman will waste space.
    // For this, calculate the size of the char_5_bits encoding, without actually running it.
    //
    // This is possible because the size of the char_5_bits encoding depends only on the length of the input:
    // size_in_bits = 5 * (input length) + 1 (for the first bit)
    final char5BytesSize = ((5 * data.length + 1) / 8).ceil();
    print('Encoded strings sizes:');
    print('  - Huffman: ${huffmanEncoded.length} bytes');
    print('  - Five bits encoding: ${char5BytesSize} bytes');
    if (huffmanEncoded.length > char5BytesSize) {
      print('Encoding with 5 bits encoding');
      return char5BitsEncoder.encode(data);
    } else {
      print('Compressing with Huffman');
      return huffmanEncoded;
    }
  }

  @override
  String decode(Uint8List data) {
    if (data.isEmpty) {
      throw ArgumentError.value(data, 'buffer', 'Empty buffer supplied');
    }

    // Read the identifier of this technique
    final identifier =
        (data[0] & 0x80) == 0x80; // 0b10000000 (check byte's MSB)
    if (identifier == FiveBitsEncoder.techniqueIdentifier) {
      return char5BitsEncoder.decode(data);
    } else {
      return huffmanEncoder.decode(data);
    }
  }
}
