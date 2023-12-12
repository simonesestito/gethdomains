import 'dart:io';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:data_encoder/data_encoder.dart';

final encoders = <String, AbstractEncoder>{
  'ipfs': IpfsCidEncoder(),
  'tor': TorAddressEncoder(),
  'domain': DomainEncoder(),
};

void showHelpAndExit() {
  print('Usage: data_encoder_cli <encoder> <action> <data>');
  print('Encoders: ${encoders.keys.join(', ')}');
  print('Actions: encode, decode');
  print('Data: string for encode, hex for decode');
  exit(1);
}

AbstractEncoder requireEncoder(String input) {
  if (!encoders.containsKey(input)) {
    print('Unknown encoder: $input');
    showHelpAndExit();
  }
  return encoders[input]!;
}

Uint8List requireHex(String input) {
  try {
    return Uint8List.fromList(hex.decode(input));
  } catch (_) {
    print('Invalid hex: $input');
    showHelpAndExit();
    return Uint8List.fromList([]); // Never reached but required by analyzer
  }
}

void main(List<String> args) {
  if (args.length < 3) {
    print('Missing arguments (expected 3, got ${args.length})');
    showHelpAndExit();
  } else if (args.length > 3) {
    print('Too many arguments (expected 3, got ${args.length})');
    showHelpAndExit();
  }

  final encoder = requireEncoder(args[0]);
  final action = args[1];
  final data = args[2];

  switch (action) {
    case 'encode':
      print('Input length: ${data.length}');
      final resultBytes = encoder.encode(data);
      print('Result bytes (hex): ${hex.encode(resultBytes)}');
      print('Result length (bytes): ${resultBytes.length}');
      break;
    case 'decode':
      print('Input length (bytes): ${data.length ~/ 2}');
      final result = encoder.decode(requireHex(data));
      print('Result: $result');
      print('Result length: ${result.length}');
      break;
    default:
      print('Unknown action: $action');
      showHelpAndExit();
  }
}
