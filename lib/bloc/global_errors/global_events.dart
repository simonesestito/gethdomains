import 'dart:async';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:js/js_util.dart';

class GlobalEventsSink {
  final StreamController<Web3Event> _web3ErrorsStreamController =
      StreamController<Web3Event>.broadcast();

  // Singleton!
  static final GlobalEventsSink _instance = GlobalEventsSink._internal();

  GlobalEventsSink._internal() {
    setProperty(window, 'web3EventsSink',
        allowInterop((String tag, String content) {
      addWeb3Event(Web3Event.fromJsTag(tag, content));
    }));
  }

  factory GlobalEventsSink() => _instance;

  Stream<Web3Event> get web3ErrorsStream => _web3ErrorsStreamController.stream;

  Stream<T> _getWeb3Events<T extends Web3Event>() {
    return web3ErrorsStream.where((event) => event is T).cast<T>();
  }

  Stream<Web3CoinTransfer> get coinTransfers =>
      _getWeb3Events<Web3CoinTransfer>();

  Stream<Web3DomainTransfer> get domainTransfers =>
      _getWeb3Events<Web3DomainTransfer>();

  Stream<Web3DomainListingForSale> get domainListings =>
      _getWeb3Events<Web3DomainListingForSale>();

  Stream<Web3DomainSold> get domainPurchases =>
      _getWeb3Events<Web3DomainSold>();

  Stream<Web3DomainEdited> get domainEdits =>
      _getWeb3Events<Web3DomainEdited>();

  void addWeb3Event(Web3Event event) {
    debugPrint('[Web3Event] $event');
    _web3ErrorsStreamController.add(event);
  }
}
