import 'package:gethdomains/contracts/geth_contract.dart';

/// Repository for balance
class BalanceRepository {
  final GethContract gethContract;

  const BalanceRepository(this.gethContract);

  /// Get the balance of the current account
  Future<BigInt> getBalance() => gethContract.getMyBalance();

  /// Get the fees for purchasing tokens
  Future<BigInt> getPurchaseTokensFees() =>
      gethContract.purchaseTokensFees(BigInt.one);

  /// Purchase tokens
  Future<String> purchaseTokens(BigInt amount) =>
      gethContract.purchaseTokens(amount);

  /// Get the fees for selling tokens
  Future<BigInt> getSellTokensFees() => gethContract.sellTokensFees(BigInt.one);

  /// Sell tokens
  Future<String> sellTokens(BigInt amount) => gethContract.sellTokens(amount);
}
