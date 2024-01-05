/// Class to interact with the contract
// TODO: Integrate the smart contract via JS API

@JS()
library web3;

import 'dart:js_interop';
import 'dart:js_util';

@JS('geth_getMyBalance')
external JSPromise _getMyBalance();

@JS('geth_purchaseTokens_fees')
external JSPromise _purchaseTokensFees(String amount);

@JS('geth_purchaseTokens')
external JSPromise _purchaseTokens(String amount);

class GethContract {
  const GethContract();

  Future<BigInt> getMyBalance() => promiseToFuture<String>(_getMyBalance())
      .then((value) => BigInt.parse(value));

  Future<BigInt> purchaseTokensFees(BigInt amount) => promiseToFuture<String>(
        _purchaseTokensFees(amount.toString()),
      ).then((value) => BigInt.parse(value));

  Future<void> purchaseTokens(BigInt amount) => promiseToFuture<void>(
        _purchaseTokens(amount.toString()),
      );
}

class GethDomainContract {
  final String address;
  final String abi;

  const GethDomainContract({
    required this.address,
    required this.abi,
  });
}
