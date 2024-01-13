import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/js_error_info.dart';

class Web3Exception extends Web3Notice implements Exception {
  final int code;

  const Web3Exception(this.code);

  factory Web3Exception.fromErrorInfo(JsErrorInfo info) {
    if (info.code == 4001) {
      return const UserTransactionRefusedException();
    }

    if (info.reason != null) {
      return SmartContractRuntimeError(info.reason!);
    }

    return Web3Exception(info.code);
  }

  @override
  String toString() {
    return '$runtimeType{code: $code}';
  }

  @override
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
  String getDisplayMessage() {
    if (reason.contains('insufficient funds for gas')) {
      return 'Insufficient funds to pay for the gas of the transaction';
    }

    if (reason.startsWith('execution reverted:')) {
      return reason.substring('execution reverted:'.length).trim();
    }

    return reason;
  }
}
