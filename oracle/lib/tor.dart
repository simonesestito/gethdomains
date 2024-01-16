import 'dart:io';
import 'dart:typed_data';

import 'package:socks5_proxy/socks_client.dart';

import 'verifier.dart';

class TorVerifier implements IVerifier {
  @override
  Future<bool> verify(String torAddress) async {
    if (!torAddress.endsWith('.onion')) {
      torAddress += '.onion';
    }
    final torUri = Uri.parse('http://$torAddress');

    // Resolve DNS of the Tor address
    final List<InternetAddress> dns;
    try {
      dns = await InternetAddress.lookup(torUri.host);
    } on SocketException catch (err) {
      print('=== Error: $err ===');
      print('');
      return false;
    }

    // Connect via TCP to port 80 of the Tor address
    // using the SOCKS5 Tor proxy on localhost:9150
    final proxySettings = ProxySettings(InternetAddress.loopbackIPv4, 9150);
    final client =
        SocksTCPClient.connect([proxySettings], dns.first, torUri.port);
    final socket = await SocketConnectionTask(client).socket;

    // Send a HTTP HEAD request
    // and consider the check successful
    // iff I receive 1 byte in 5 seconds and the connection stays open
    final httpHeadRequest = """
GET / HTTP/1.1
Host: $torAddress
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0
Accept: */*
"""
        .split('\n')
        .map((row) => row.trim())
        .where((row) => row.isNotEmpty)
        .join('\r\n');

    socket.write(httpHeadRequest);
    socket.write('\r\n\r\n');
    socket.flush();

    // Read 1 byte or handle timeout + connection close
    final result = await socket.where((data) => data.isNotEmpty).first.timeout(
          const Duration(seconds: 5),
          onTimeout: () => Uint8List(0),
        );

    return result.isNotEmpty;
  }
}
