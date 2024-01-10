/// Class to interact with the contract
// TODO: Integrate the smart contract via JS API

@JS()
library web3;

import 'dart:js_interop';

import 'interop.dart';

@JS('geth_getMyBalance')
external JSPromise _getMyBalance();

@JS('geth_purchaseTokens_fees')
external JSPromise _purchaseTokensFees(String amount);

@JS('geth_purchaseTokens')
external JSPromise _purchaseTokens(String amount);

@JS('geth_withdrawEther_fees')
external JSPromise _withdrawEthFees(String amount);

@JS('geth_withdrawEther')
external JSPromise _withdrawEth(String amount);

class GethContract {
  const GethContract();

  Future<BigInt> getMyBalance() => metamaskPromise<String>(_getMyBalance())
      .then((value) => BigInt.parse(value));

  Future<BigInt> purchaseTokensFees(BigInt amount) => metamaskPromise<String>(
        _purchaseTokensFees(amount.toString()),
      ).then((value) => BigInt.parse(value));

  Future<String> purchaseTokens(BigInt amount) => metamaskPromise<String>(
        _purchaseTokens(amount.toString()),
      );

  Future<BigInt> sellTokensFees(BigInt amount) => metamaskPromise<String>(
        _withdrawEthFees(amount.toString()),
      ).then((value) => BigInt.parse(value));

  Future<String> sellTokens(BigInt amount) => metamaskPromise<String>(
        _withdrawEth(amount.toString()),
      );
}
