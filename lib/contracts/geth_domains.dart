/// Class to interact with the contract
// TODO: Integrate the smart contract via JS API

@JS()
library web3;

import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:gethdomains/model/domain.dart';

import 'interop.dart';

@JS('domains_purchaseNewDomain_fees')
external JSPromise _purchaseNewDomainFees(
    String domain, String pointedAddress, String domainType);

@JS('domains_purchaseNewDomain')
external JSPromise _purchaseNewDomain(
    String domain, String pointedAddress, String domainType);

// Convert to base64 for compatibility purposes
String _sendUint8List(Uint8List input) => base64Encode(input);

class GethDomainsContract {
  const GethDomainsContract();

  Future<BigInt> purchaseNewDomainFees(
          Uint8List domain, Uint8List pointedAddress, DomainType domainType) =>
      metamaskPromise<String>(
        _purchaseNewDomainFees(
          _sendUint8List(domain),
          _sendUint8List(pointedAddress),
          domainType.name,
        ),
      ).then((value) => BigInt.parse(value));

  Future<String> purchaseNewDomain(
          Uint8List domain, Uint8List pointedAddress, DomainType domainType) =>
      metamaskPromise<String>(
        _purchaseNewDomain(
          _sendUint8List(domain),
          _sendUint8List(pointedAddress),
          domainType.name,
        ),
      );
}
