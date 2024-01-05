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
  Future<void> purchaseTokens(BigInt amount) =>
      gethContract.purchaseTokens(amount);

  /// Get the fees for selling tokens
  Future<BigInt> getSellTokensFees() => gethContract.sellTokensFees(BigInt.one);

  /// Sell tokens
  Future<void> sellTokens(BigInt amount) => gethContract.sellTokens(amount);

  /// Handle balance changes
// TODO: Stream<BigInt> get balanceChanges => gethContract.balanceChanges;
}
