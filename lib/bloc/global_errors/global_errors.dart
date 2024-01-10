import 'dart:async';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/contracts/js_error_info.dart';
import 'package:js/js_util.dart';

class GlobalErrorsSink {
  final StreamController<Web3Exception> _web3ErrorsStreamController =
      StreamController<Web3Exception>.broadcast();

  // Singleton!
  static final GlobalErrorsSink _instance = GlobalErrorsSink._internal();

  GlobalErrorsSink._internal() {
    setProperty(window, 'web3ErrorsSink',
        allowInterop((int code, String reason) {
      debugPrint('GlobalErrorsSink: web3ErrorsSink: $code, $reason');
      addWeb3Error(Web3Exception.fromErrorInfo(JsErrorInfo(code, reason)));
    }));
  }

  factory GlobalErrorsSink() => _instance;

  Stream<Web3Notice> get web3ErrorsStream => _web3ErrorsStreamController.stream;

  void addWeb3Error(Web3Exception error) {
    debugPrint('[Web3Exception] $error');
    _web3ErrorsStreamController.add(error);
  }
}
