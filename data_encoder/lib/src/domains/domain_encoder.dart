import 'dart:typed_data';

import 'interface.dart';
import 'five_bits_encoder.dart';
import 'huffman/huffman_encoder.dart';

/// General encoder, which may use one technique or another,
/// depending on the one that generates the smallest output.
class DomainEncoder extends AbstractDomainEncoder {
  final char5BitsEncoder = FiveBitsEncoder();
  final huffmanEncoder = HuffmanEncoder();

  @override
  Uint8List encode(String data) {
    final huffmanEncoded = huffmanEncoder.encode(data);

    // Determine if Huffman will waste space.
    // For this, calculate the size of the char_5_bits encoding, without actually running it.
    //
    // This is possible because the size of the char_5_bits encoding depends only on the length of the input:
    // size_in_bits = 5 * (input length) + 1 (for the first bit)
    final char5BytesSize = ((5 * data.length + 1) / 8).ceil();
    if (huffmanEncoded.length > char5BytesSize) {
      return char5BitsEncoder.encode(data);
    } else {
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
