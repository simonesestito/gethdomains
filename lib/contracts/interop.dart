// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:js_interop';
import 'dart:js_util';

import 'package:flutter/cupertino.dart';

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
  debugPrint('jsNativeError: $jsNativeErrorString');
  Map<String, dynamic> data = const JsonDecoder().convert(
    jsNativeErrorString.substring(jsNativeErrorString.indexOf('{')),
  );

  if (data.containsKey('originalError')) {
    data = data['originalError'];
  }

  final errorCode = data['code'] as int;
  final errorReason = data['data']['reason'] as String?;
  final message = data['message'] as String?;

  return JsErrorInfo(errorCode, errorReason ?? message);
}

JsErrorInfo _handleJsObjectError(Object error) {
  final errorCode = getProperty(error, 'code');
  final errorData = getProperty(error, 'data');
  final reason =
      errorData != null ? getProperty(errorData, 'reason').toString() : null;
  final message = getProperty(error, 'message');
  return JsErrorInfo(errorCode, reason ?? message);
}
