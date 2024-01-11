import 'dart:io';
import 'dart:typed_data';

import 'decoder.dart';

class EthClient {
  final String privateKey;
  final String smartContractAddress;
  final File abiFile;
  final eventDecoder = const EventDecoder();

  const EthClient({
    required this.privateKey,
    required this.smartContractAddress,
    required this.abiFile,
  });

  Stream<Event> subscribeToDomainVerificationEvents() {
    return Stream.empty(); // TODO
  }

  Future<void> sendVerificationResult(Event event, bool result) async {
    // TODO
  }
}
