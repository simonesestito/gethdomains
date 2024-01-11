// Convert to base64 for compatibility purposes
import 'dart:convert';
import 'dart:typed_data';

String sendUint8List(Uint8List input) => base64Encode(input);

Uint8List receiveUint8ListFromHex(String input) {
  // Every 2 chars, starting after 0x, it's a byte
  final bytes = <int>[];
  for (var i = 2; i < input.length; i += 2) {
    final hex = input.substring(i, i + 2);
    bytes.add(int.parse(hex, radix: 16));
  }
  return Uint8List.fromList(bytes);
}
