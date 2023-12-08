/// An item in the Huffman encoding map
class HuffmanEncodingItem {
  /// The binary representation of the character
  final int binary;

  /// The length of the binary representation (LSB)
  final int length;

  const HuffmanEncodingItem._({
    required this.binary,
    required this.length,
  });

  factory HuffmanEncodingItem.fromBin(String binary) => HuffmanEncodingItem._(
        binary: int.parse(binary, radix: 2),
        length: binary.length,
      );
}