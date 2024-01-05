part of 'balance_bloc.dart';

sealed class BalanceEvent {
  const BalanceEvent();
}

/// Used only by the bloc to update the balance
class _UpdateBalanceEvent extends BalanceEvent {
  final BigInt? balance;

  const _UpdateBalanceEvent({required this.balance});
}

class LoadBalanceEvent extends BalanceEvent {
  const LoadBalanceEvent();
}

class BuyTokensEvent extends BalanceEvent {
  final BigInt amount;

  const BuyTokensEvent(this.amount);
}
