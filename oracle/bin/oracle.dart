import 'dart:io';

import 'package:oracle/oracle.dart';

import './env.dart';

void main() async {
  final ethParams = await loadPrivateEthParams();
  final ethClient = EthClient(
    privateKey: ethParams.privateKey,
    smartContractAddress: ethParams.smartContractAddress,
    abiFile: File(ethParams.abiFile),
  );

  ethClient.subscribeToDomainVerificationEvents().listen((event) async {
    final verifier = IVerifier.forType(event.type);
    final bool result = await verifier.verify(event.domainPointer).onError(
      (error, stackTrace) {
        print('=== Error: $error ===');
        print(stackTrace);
        print('');
        return false;
      },
    );
    await ethClient.sendVerificationResult(event, result).onError(
      (error, stackTrace) {
        print('=== Error: $error ===');
        print(stackTrace);
        print('');
      },
    );
  });
}
