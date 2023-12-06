/// Repository for balance
/// TODO: Implement interaction with the smart contract to get the balance
class BalanceRepository {
  const BalanceRepository();
  
  /// Get the balance of the current account
  Future<BigInt> getBalance() async {
    return BigInt.from(100);
  }
}