import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gethdomains/contracts/exceptions.dart';

class GlobalErrorsSink {
  final StreamController<Web3Exception> _web3ErrorsStreamController =
      StreamController<Web3Exception>.broadcast();

  Stream<Web3Exception> get web3ErrorsStream =>
      _web3ErrorsStreamController.stream;

  void addWeb3Error(Web3Exception error) {
    debugPrint('Web3Error: $error');
    _web3ErrorsStreamController.add(error);
  }
}
