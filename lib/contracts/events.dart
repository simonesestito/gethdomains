import 'dart:convert';

import 'package:data_encoder/data_encoder.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/utils/bytes_convertion.dart';

abstract class Web3Notice {
  const Web3Notice();

  String getDisplayMessage();

  @override
  String toString() => '$runtimeType{message: "${getDisplayMessage()}"}';

  @override
  bool operator ==(Object other) {
    if (other is! Web3Notice) return false;
    return getDisplayMessage() == other.getDisplayMessage();
  }

  @override
  int get hashCode => getDisplayMessage().hashCode;
}

sealed class Web3Event extends Web3Notice {
  final String message;

  const Web3Event(this.message);

  factory Web3Event.fromJsTag(String tag, String message) {
    return switch (tag) {
      'transactionSent' => Web3TransactionSent(message),
      'coinTransfer' => Web3CoinTransfer.fromJson(message),
      'domainTransfer' => Web3DomainTransfer.fromJson(message),
      'domainListingForSale' => Web3DomainListingForSale.fromJson(message),
      'domainSold' => Web3DomainSold.fromJson(message),
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
    const domainEncoder = DomainEncoder(
      domainSuffix: DomainInputValidator.domainSuffix,
    );
    final data = jsonDecode(json);
    final domainBytes = receiveUint8ListFromHex(data['domainBytes']);

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

class Web3DomainListingForSale extends Web3Event {
  final String domainName;
  final String seller;
  final BigInt price;

  const Web3DomainListingForSale(this.domainName, this.seller, this.price)
      : super('Domain $domainName listed for sale for $price GETH');

  factory Web3DomainListingForSale.fromJson(String json) {
    const domainEncoder = DomainEncoder(
      domainSuffix: DomainInputValidator.domainSuffix,
    );
    final data = jsonDecode(json);
    final domainBytes = receiveUint8ListFromHex(data['domainBytes']);

    return Web3DomainListingForSale(
      domainEncoder.decode(domainBytes) + DomainInputValidator.domainSuffix,
      data['seller'],
      BigInt.parse(data['price']),
    );
  }

  @override
  String getDisplayMessage() {
    // If zero, print a different message (not for sale)
    if (price.compareTo(BigInt.zero) == 0) {
      return 'Domain $domainName is not for sale';
    }
    return super.getDisplayMessage();
  }
}

class Web3DomainSold extends Web3Event {
  final String domainName;
  final String seller;
  final String buyer;

  const Web3DomainSold(
    this.domainName,
    this.seller,
    this.buyer,
  ) : super('Domain $domainName sold');

  factory Web3DomainSold.fromJson(String json) {
    const domainEncoder = DomainEncoder(
      domainSuffix: DomainInputValidator.domainSuffix,
    );
    final data = jsonDecode(json);
    final domainBytes = receiveUint8ListFromHex(data['domainBytes']);

    return Web3DomainSold(
      domainEncoder.decode(domainBytes) + DomainInputValidator.domainSuffix,
      data['seller'],
      data['buyer'],
    );
  }
}
