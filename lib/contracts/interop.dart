// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_util';

import 'exceptions.dart';
import 'js_error_info.dart';

Future<T> metamaskPromise<T>(JSPromise promise) async {
  try {
    return await promiseToFuture<T>(promise);
  } catch (error) {
    print(error.runtimeType);
    print(error);
    final errorInfo = error.runtimeType.toString() == 'NativeError'
        ? _handleJsNativeError(error)
        : _handleJsObjectError(error);
    print(errorInfo);
    throw Web3Exception.fromErrorInfo(errorInfo);
  }
}

JsErrorInfo _handleJsNativeError(dynamic /* NativeError */ jsNativeError) {
  final jsNativeErrorString = jsNativeError.toString();
  final data = const JsonDecoder().convert(
    jsNativeErrorString.substring(jsNativeErrorString.indexOf('{')),
  );

  final errorCode = data['code'] as int;
  final errorReason = data['data']['reason'] as String?;
  return JsErrorInfo(errorCode, errorReason);
}

JsErrorInfo _handleJsObjectError(Object error) {
  final errorCode = getProperty(error, 'code');
  final errorData = getProperty(error, 'data');
  final reason =
      errorData != null ? getProperty(errorData, 'reason').toString() : null;
  return JsErrorInfo(errorCode, reason);
}
