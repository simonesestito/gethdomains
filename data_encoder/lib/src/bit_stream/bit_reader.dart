import 'dart:typed_data';

class BitReader {
  final Uint8List buffer;
  int index;
  int bitIndex;

  BitReader({
    required this.buffer,
    this.index = 0,
    this.bitIndex = 0,
  });

  bool readBit() {
    // Handle reads after the end of the buffer
    if (index >= buffer.length) {
      return false;
    }

    final bitRead = (buffer[index] >> (7 - bitIndex)) & 1;
    bitIndex++;
    if (bitIndex == 8) {
      bitIndex = 0;
      index++;
    }
    return bitRead == 1;
  }

  int readBits(int count) {
    var value = 0;
    for (var i = 0; i < count; i++) {
      value = (value << 1) | (readBit() ? 1 : 0);
    }
    return value;
  }

  bool hasNext() {
    return index < buffer.length;
  }
}
