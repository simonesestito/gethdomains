part of 'encoder.dart';

class _Char5BitsEncoder extends AbstractDomainEncoder {
  static const bool techniqueIdentifier = false;

  @override
  Uint8List encode(String domain) {
    if (!isValid(domain)) {
      throw ArgumentError.value(domain, 'domain', 'Invalid domain supplied');
    }

    final bitWriter = BitWriter();

    // Write the identifier of this technique
    bitWriter.writeBit(techniqueIdentifier);

    for (final char in domain.split('')) {
      final index = _getIndexByChar(char);
      bitWriter.writeBits(index, 5);
    }

    return bitWriter.getBuffer();
  }

  @override
  String decode(Uint8List buffer) {
    final bitReader = BitReader(buffer: buffer);

    // Read the identifier of this technique
    final identifier = bitReader.readBit();
    if (identifier != techniqueIdentifier) {
      throw ArgumentError.value(buffer, 'buffer', 'Invalid buffer supplied');
    }

    String result = '';
    while (bitReader.hasNext()) {
      final index = bitReader.readBits(5);
      if (index == 0) {
        break;
      }
      result += _getCharByIndex(index);
    }

    return result;
  }

  int _getIndexByChar(String char) => char.codeUnitAt(0) - 96;

  String _getCharByIndex(int index) => String.fromCharCode(index + 96);
}
