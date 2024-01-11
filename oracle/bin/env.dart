class EthParams {
  final String privateKey;
  final String smartContractAddress;
  final String abiFile;

  const EthParams({
    required this.privateKey,
    required this.smartContractAddress,
    required this.abiFile,
  });
}

Future<EthParams> loadPrivateEthParams([
  String paramsFile = 'private_eth_params.json',
]) async {
  // TODO
}
