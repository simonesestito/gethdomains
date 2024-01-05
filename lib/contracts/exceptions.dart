class Web3Exception implements Exception {
  final int code;

  static const allExceptions = <Web3Exception>[
    UserTransactionRefusedException(),
  ];

  const Web3Exception(this.code);

  factory Web3Exception.fromCode(int code) {
    return allExceptions.firstWhere(
      (e) => e.code == code,
      orElse: () => Web3Exception(code),
    );
  }

  @override
  String toString() {
    return '$runtimeType{code: $code}';
  }
}

class UserTransactionRefusedException extends Web3Exception {
  const UserTransactionRefusedException() : super(4001);
}
