import 'dart:io';

import 'decoder.dart';

class EthClient {
  final String privateKey;
  final String smartContractAddress;
  final File abiFile;
  final String chainRpcUrl;
  final eventDecoder = const EventDecoder();

  const EthClient({
    required this.privateKey,
    required this.smartContractAddress,
    required this.abiFile,
    required this.chainRpcUrl,
  });

  Stream<Event> subscribeToDomainVerificationEvents() {
    return Stream.empty(); // TODO
  }

  Future<void> sendVerificationResult(Event event, bool result) async {
    // TODO
  }
}
