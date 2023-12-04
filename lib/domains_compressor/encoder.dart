import 'dart:typed_data';

import 'bit_reader.dart';
import 'bit_writer.dart';

part 'char_5_bits_encoder.dart';
part 'huffman_encoder.dart';

abstract class AbstractDomainEncoder {
  /// Encodes the given [domain] into a [Uint8List].
  Uint8List encode(String domain);

  /// Decodes the given [buffer] into a [String].
  String decode(Uint8List buffer);

  /// Check if the given [domain] is valid to be encoded.
  bool isValid(String domain) {
    if (domain.isEmpty) {
      return false;
    }

    // Check that every char of the domain is lowercase letter
    for (final char in domain.split('')) {
      if (char.codeUnitAt(0) < 97 || char.codeUnitAt(0) > 122) {
        return false;
      }
    }

    return true;
  }
}

class HuffmanEncoder extends _HuffmanEncoder {}

/// General encoder, which may use one technique or another,
/// depending on the one that generates the smallest output.
class DomainEncoder extends AbstractDomainEncoder {
  final char5BitsEncoder = _Char5BitsEncoder();
  final huffmanEncoder = _HuffmanEncoder();

  @override
  Uint8List encode(String domain) {
    final huffmanEncoded = huffmanEncoder.encode(domain);

    // Determine if Huffman will waste space.
    // For this, calculate the size of the char_5_bits encoding, without actually running it.
    //
    // This is possible because the size of the char_5_bits encoding depends only on the length of the input:
    // size_in_bits = 5 * (input length) + 1 (for the first bit)
    final char5BytesSize = (5 * domain.length + 1) ~/ 8;
    if (huffmanEncoded.length > char5BytesSize) {
      return char5BitsEncoder.encode(domain);
    } else {
      return huffmanEncoded;
    }
  }

  @override
  String decode(Uint8List buffer) {
    if (buffer.isEmpty) {
      throw ArgumentError.value(buffer, 'buffer', 'Empty buffer supplied');
    }

    // Read the identifier of this technique
    final identifier = (buffer[0] & 0x80) == 1; // 0b10000000 (check byte's MSB)
    if (identifier == _Char5BitsEncoder.techniqueIdentifier) {
      return char5BitsEncoder.decode(buffer);
    } else {
      return huffmanEncoder.decode(buffer);
    }
  }
}
