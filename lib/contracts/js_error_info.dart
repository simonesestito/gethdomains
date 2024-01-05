class JsErrorInfo {
  final int code;
  final String? reason;

  const JsErrorInfo(this.code, this.reason);

  @override
  String toString() {
    return 'JsErrorInfo{code: $code, reason: $reason}';
  }
}
