import 'dart:js_interop';
import 'dart:js_util';

import 'exceptions.dart';

Future<T> metamaskPromise<T>(JSPromise promise) async {
  try {
    return await promiseToFuture<T>(promise);
  } catch (error) {
    final errorCode = getProperty(error, 'code');
    throw Web3Exception.fromCode(errorCode);
  }
}
