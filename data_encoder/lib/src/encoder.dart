import 'dart:typed_data';

abstract class AbstractEncoder {
  const AbstractEncoder();
  Uint8List encode(String data);
  String decode(Uint8List data);
  bool isValid(String data);
}
