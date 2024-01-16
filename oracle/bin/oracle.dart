import 'package:oracle/domain_type.dart';
import 'package:oracle/oracle.dart';

import './env.dart';

void main() async {
  final ethParams = await loadPrivateEthParams();
  final ethClient = EthClient(
    privateKey: ethParams.privateKey,
    smartContractAddress: ethParams.smartContractAddress,
    abiFile: ethParams.abiFile,
    chainRpcUrl: ethParams.chainRpcUrl,
  );

  //! TEST
  final verifier = IVerifier.forType(DomainType.tor);
  print(await verifier.verify('onion3yj2gmj7tv3f.onion'));
  print(await verifier.verify(
      'duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion'));

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
