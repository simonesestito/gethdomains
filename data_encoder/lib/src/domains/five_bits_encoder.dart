
import 'dart:typed_data';

import '../bit_stream/bit_reader.dart';
import '../bit_stream/bit_writer.dart';
import 'interface.dart';

class FiveBitsEncoder extends AbstractDomainEncoder {
  static const bool techniqueIdentifier = false;

  @override
  Uint8List encode(String data) {
    if (!isValid(data)) {
      throw ArgumentError.value(data, 'data', 'Invalid domain supplied');
    }

    final bitWriter = BitWriter();

    // Write the identifier of this technique
    bitWriter.writeBit(techniqueIdentifier);

    for (final char in data.split('')) {
      final index = _getIndexByChar(char);
      bitWriter.writeBits(index, 5);
    }

    return bitWriter.getBuffer();
  }

  @override
  String decode(Uint8List data) {
    final bitReader = BitReader(buffer: data);

    // Read the identifier of this technique
    final identifier = bitReader.readBit();
    if (identifier != techniqueIdentifier) {
      throw ArgumentError.value(data, 'data', 'Invalid buffer supplied');
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
