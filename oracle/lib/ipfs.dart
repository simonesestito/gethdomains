import 'dart:async';
import 'dart:io';

import './verifier.dart';

class IpfsVerifier implements IVerifier {
  final httpClient = HttpClient();
  final proxyUrl = 'https://gateway.ipfs.io/ipfs/';

  @override
  Future<bool> verify(String ipfsHash) async {
    // Do a HTTP HEAD request to the URL of the gateway
    // If the response code is 200, return true
    // Also use a timeout of 5 seconds

    final url = Uri.parse(proxyUrl + ipfsHash);
    try {
      final response = await _doHttpHeadRequest(url).timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException('Timeout for IPFS check'),
      );
      return response.statusCode == 200;
    } on TimeoutException {
      return false;
    } on SocketException catch (err, stackTrace) {
      print('=== SocketException: $err ===');
      print(stackTrace);
      print('');
      return false;
    }
  }

  Future<HttpClientResponse> _doHttpHeadRequest(Uri url) async {
    final request = await httpClient.headUrl(url);
    return request.close();
  }
}
