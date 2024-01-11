import 'dart:convert';
import 'dart:typed_data';

import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/input/validators/domain_input.dart';

abstract class Web3Notice {
  const Web3Notice();

  String getDisplayMessage();

  @override
  String toString() => '$runtimeType{message: "${getDisplayMessage()}"}';
}

sealed class Web3Event extends Web3Notice {
  final String message;

  const Web3Event(this.message);

  factory Web3Event.fromJsTag(String tag, String message) {
    return switch (tag) {
      'transactionSent' => Web3TransactionSent(message),
      'coinTransfer' => Web3CoinTransfer.fromJson(message),
      'domainTransfer' => Web3DomainTransfer.fromJson(message),
      _ => throw Exception('Unknown Web3Event tag: $tag'),
    };
  }

  @override
  String getDisplayMessage() => message;
}

// First 2 chars are 0x, and the rest are all zeros
bool _addressIsNoOne(String address) =>
    address.startsWith('0x') &&
    address.substring(2).split('').every((c) => c == '0');

class Web3TransactionSent extends Web3Event {
  final String transactionHash;

  const Web3TransactionSent(this.transactionHash)
      : super('Transaction sent: $transactionHash');
}

class Web3CoinTransfer extends Web3Event {
  final String from;
  final String to;
  final BigInt value;

  const Web3CoinTransfer({
    required this.from,
    required this.to,
    required this.value,
  }) : super('Transfer $value from $from to $to');

  factory Web3CoinTransfer.fromJson(String json) {
    final data = jsonDecode(json);
    return Web3CoinTransfer(
      from: data['from'],
      to: data['to'],
      value: BigInt.parse(data['value']),
    );
  }

  bool fromNoOne() => _addressIsNoOne(from);

  bool toNoOne() => _addressIsNoOne(to);
}

class Web3DomainTransfer extends Web3Event {
  final String from;
  final String to;
  final String domainName;

  const Web3DomainTransfer({
    required this.from,
    required this.to,
    required this.domainName,
  }) : super('Transfer domain $domainName from $from to $to');

  factory Web3DomainTransfer.fromJson(String json) {
    const domainEncoder = DomainEncoder();
    final data = jsonDecode(json);
    final domainHex = data['domainBytes'] as String;
    final domainBytes = Uint8List((domainHex.length - 2 /* 0x */) ~/ 2);
    for (var i = 0; i < domainBytes.length; i++) {
      domainBytes[i] =
          int.parse(domainHex.substring(2 + i * 2, 4 + i * 2), radix: 16);
    }

    return Web3DomainTransfer(
      from: data['from'],
      to: data['to'],
      domainName:
          domainEncoder.decode(domainBytes) + DomainInputValidator.domainSuffix,
    );
  }

  bool fromNoOne() => _addressIsNoOne(from);

  bool toNoOne() => _addressIsNoOne(to);
}
