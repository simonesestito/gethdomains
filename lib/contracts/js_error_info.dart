class JsErrorInfo {
  final int code;
  final String? reason;

  const JsErrorInfo(this.code, this.reason);

  @override
  String toString() {
    return 'JsErrorInfo{code: $code, reason: $reason}';
  }

  String? normalizedReason() {
    if (reason == null) {
      return null;
    }

    // Sometimes, the reason is a stringified JSON object
    // Extract the message using a regex
    final oneLineReason = reason?.replaceAll('\n', ' ');
    final messageRegex = RegExp(r'{.*"message":\s*"(.+?)".*}');
    final match = messageRegex.firstMatch(oneLineReason ?? '');
    if (match != null) {
      return match.group(1);
    } else {
      return reason;
    }
  }
}
