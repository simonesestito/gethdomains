import 'package:gethdomains/contracts/js_error_info.dart';

class Web3Exception implements Exception {
  final int code;

  const Web3Exception(this.code);

  factory Web3Exception.fromErrorInfo(JsErrorInfo info) {
    return switch (info.code) {
      4001 => const UserTransactionRefusedException(),
      -32000 => SmartContractRuntimeError(info.reason!),
      _ => Web3Exception(info.code),
    };
  }

  @override
  String toString() {
    return '$runtimeType{code: $code}';
  }

  String getDisplayMessage() => 'Unknown error with code $code';
}

class UserTransactionRefusedException extends Web3Exception {
  const UserTransactionRefusedException() : super(4001);

  @override
  String getDisplayMessage() => 'Action cancelled by user';
}

class SmartContractRuntimeError extends Web3Exception {
  final String reason;

  const SmartContractRuntimeError(this.reason) : super(-32000);

  @override
  String toString() {
    return '$runtimeType{code: $code, reason: $reason}';
  }

  @override
  String getDisplayMessage() => reason;
}
