import 'dart:convert';
import 'dart:io';

class EthParams {
  final String privateKey;
  final String smartContractAddress;
  final String chainRpcUrl;
  final File abiFile;

  const EthParams({
    required this.privateKey,
    required this.smartContractAddress,
    required this.chainRpcUrl,
    required this.abiFile,
  });
}

Future<EthParams> loadPrivateEthParams([
  String paramsFile = 'private_eth_params.json',
]) async {
  // Load JSON struct from the file
  final jsonString = await File(paramsFile).readAsString();
  final params = jsonDecode(jsonString);
  return EthParams(
    privateKey: params['ethPrivateKey'],
    smartContractAddress: params['smartContractAddress'],
    chainRpcUrl: params['chainRpcUrl'],
    abiFile: File(params['abiFile']).absolute,
  );
}
