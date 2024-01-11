/// Class to interact with the contract
// TODO: Integrate the smart contract via JS API

@JS()
library web3;

import 'dart:convert';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/utils/bytes_convertion.dart';

import 'interop.dart';

@JS('domains_purchaseNewDomain_fees')
external JSPromise _purchaseNewDomainFees(
    String domain, String pointedAddress, String domainType);

@JS('domains_purchaseNewDomain')
external JSPromise _purchaseNewDomain(
    String domain, String pointedAddress, String domainType);

@JS('domains_searchDomain')
external JSPromise _searchDomain(String domain);

class GethDomainsContract {
  const GethDomainsContract();

  Future<BigInt> purchaseNewDomainFees(
          Uint8List domain, Uint8List pointedAddress, DomainType domainType) =>
      metamaskPromise<String>(
        _purchaseNewDomainFees(
          sendUint8List(domain),
          sendUint8List(pointedAddress),
          domainType.name,
        ),
      ).then((value) => BigInt.parse(value));

  Future<String> purchaseNewDomain(
          Uint8List domain, Uint8List pointedAddress, DomainType domainType) =>
      metamaskPromise<String>(
        _purchaseNewDomain(
          sendUint8List(domain),
          sendUint8List(pointedAddress),
          domainType.name,
        ),
      );

  Future<Map<String, dynamic>?> searchDomain(String domain) async {
    final jsonString = await metamaskPromise<String?>(_searchDomain(domain));
    if (jsonString == null) {
      return null;
    }

    final jsonData = jsonDecode(jsonString);
    jsonData['dominioTorOrIpfs'] =
        receiveUint8ListFromHex(jsonData['dominioTorOrIpfs']);
    return jsonData;
  }
}
