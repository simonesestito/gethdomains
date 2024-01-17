import 'dart:async';
import 'dart:convert';

import 'package:socks5_io/socks5_io.dart';

import 'verifier.dart';

class TorVerifier implements IVerifier {
  @override
  Future<bool> verify(String torAddress) async {
    if (!torAddress.endsWith('.onion')) {
      torAddress += '.onion';
    }
    final torUri = Uri.parse('http://$torAddress');

    // Connect via TCP to port 80 of the Tor address
    // using the SOCKS5 Tor proxy on localhost:9150
    final proxy = Socks5ClientDialer("127.0.0.1", 9150, authMethods: [
      AuthMethod.notRequired,
    ]);
    try {
      final socket = await proxy.connect(torUri.host, torUri.port);

      final result = Completer<bool>();
      complete(bool success) async {
        if (result.isCompleted) return;
        result.complete(success);
        await socket.close();
      }

      // Timeout
      Future.delayed(
        const Duration(seconds: 30),
        () => complete(false),
      );

      // Read 1 byte or handle timeout + connection close
      socket.getReader().listen(
        (event) {
          print('=== Event: ${event.length} ===');
          if (event.isNotEmpty) {
            complete(true);
          }
        },
        onError: (err) {
          print('onError');
          print(err);
          complete(false);
        },
        onDone: () => complete(false),
      );

      // Send a HTTP HEAD request
      // and consider the check successful
      // iff I receive 1 byte in 5 seconds and the connection stays open
      socket.getWriter().add(ascii.encode([
            "GET / HTTP/1.1",
            "Host: $torAddress",
            "User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0",
            "Accept: */*",
            "",
            "", // An HTTP request must end with 2 CRLF
          ].join('\r\n')));

      return result.future;
    } catch (err, stackTrace) {
      print(err);
      print(stackTrace);
      return false;
    }
  }
}
