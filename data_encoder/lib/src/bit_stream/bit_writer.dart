import 'dart:typed_data';

class BitWriter {
  final List<int> buffer = [];
  int currentByte = 0;
  int numBitsFilled = 0;

  void writeBit(bool bit) {
    currentByte = (currentByte << 1) | (bit ? 1 : 0);
    numBitsFilled++;
    if (numBitsFilled == 8) {
      buffer.add(currentByte);
      currentByte = 0;
      numBitsFilled = 0;
    }
  }

  void writeBits(int value, int numBits) {
    assert(numBits >= 0 && numBits <= 32);
    for (var i = 0; i < numBits; i++) {
      final bit = ((value >> (numBits - i - 1)) & 1) == 1;
      writeBit(bit);
    }
  }

  Uint8List getBuffer() {
    List<int> resultingBuffer = List.from(buffer);
    if (numBitsFilled > 0 && currentByte != 0) {
      resultingBuffer.add(currentByte << (8 - numBitsFilled));
    }
    return Uint8List.fromList(resultingBuffer);
  }
}
