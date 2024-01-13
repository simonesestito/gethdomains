/// Class to interact with the contract

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

@JS('domains_getMyDomains')
external JSPromise _getMyDomains();

@JS('domains_addDomainToMetamask')
external void _addDomainToMetamask(String domain);

@JS('domains_sellDomain_fees')
external JSPromise _sellDomainFees(String domain, String price);

@JS('domains_sellDomain')
external JSPromise _sellDomain(String domain, String price);

@JS('domains_retrieveDomain')
external JSPromise _retrieveDomain(String domain);

@JS('domains_getDomainsForSale')
external JSPromise _getDomainsForSale();

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

  Future<Map<String, dynamic>?> searchDomain(Uint8List domain) async {
    final jsonString = await metamaskPromise<String?>(_searchDomain(
      sendUint8List(domain),
    ));
    if (jsonString == null) {
      return null;
    }

    final jsonData = jsonDecode(jsonString);
    jsonData['pointedAddress'] =
        receiveUint8ListFromHex(jsonData['pointedAddress']);
    return jsonData;
  }

  Future<List<Map<String, dynamic>>> getMyDomains() async {
    final jsonString = await metamaskPromise<String?>(_getMyDomains());
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonData = jsonDecode(jsonString);
    return _receiveDomainsList(jsonData);
  }

  void addDomainToMetamask(Uint8List domainBytes) {
    _addDomainToMetamask(sendUint8List(domainBytes));
  }

  Future<BigInt> sellDomainFees(Uint8List domain, BigInt price) =>
      metamaskPromise<String>(_sellDomainFees(
        sendUint8List(domain),
        price.toString(),
      )).then((value) => BigInt.parse(value));

  Future<String> sellDomain(Uint8List domain, BigInt price) =>
      metamaskPromise<String>(_sellDomain(
        sendUint8List(domain),
        price.toString(),
      ));

  Future<String> unlistDomainFromSelling(Uint8List domain) =>
      metamaskPromise<String>(_retrieveDomain(sendUint8List(domain)));

  Future<List<Map<String, dynamic>>> getDomainsForSale() async {
    final jsonString = await metamaskPromise<String?>(_getDomainsForSale());
    if (jsonString == null) {
      return [];
    }

    final List<dynamic> jsonData = jsonDecode(jsonString);
    return _receiveDomainsList(jsonData);
  }

  List<Map<String, dynamic>> _receiveDomainsList(List<dynamic> jsonData) {
    for (var i = 0; i < jsonData.length; i++) {
      jsonData[i]['pointedAddress'] =
          receiveUint8ListFromHex(jsonData[i]['pointedAddress']);
      jsonData[i]['domain'] = receiveUint8ListFromHex(jsonData[i]['domain']);
    }
    return jsonData.cast<Map<String, dynamic>>();
  }
}
