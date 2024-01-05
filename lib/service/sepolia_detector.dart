import 'dart:js_interop';
import 'dart:js_util';

import 'package:flutter/foundation.dart';

@JS('isSepoliaNetwork')
external JSPromise _isSepoliaNetwork();

@JS('useSepoliaNetwork')
external JSPromise _useSepoliaNetwork();

abstract class SepoliaNetworkDetector {
  static const _testingSepoliaNetworkDetector = false;

  Future<bool> isSepoliaNetwork();

  Future<bool> useSepoliaNetwork();

  factory SepoliaNetworkDetector() {
    if (kReleaseMode || _testingSepoliaNetworkDetector) {
      return ProdSepoliaNetworkDetector();
    } else {
      return DevSepoliaNetworkDetector();
    }
  }
}

class ProdSepoliaNetworkDetector implements SepoliaNetworkDetector {
  @override
  Future<bool> isSepoliaNetwork() async {
    try {
      return promiseToFuture<bool>(_isSepoliaNetwork());
    } catch (err) {
      debugPrint('Error checking if is Sepolia Network: $err');
      return false;
    }
  }

  @override
  Future<bool> useSepoliaNetwork() async {
    try {
      return promiseToFuture<bool>(_useSepoliaNetwork());
    } catch (err) {
      debugPrint('Error using Sepolia Network: $err');
      return false;
    }
  }
}

class DevSepoliaNetworkDetector implements SepoliaNetworkDetector {
  @override
  Future<bool> isSepoliaNetwork() async => true;

  @override
  Future<bool> useSepoliaNetwork() async => true;
}
