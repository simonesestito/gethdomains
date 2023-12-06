part of 'balance_bloc.dart';

sealed class BalanceState {
  const BalanceState();
}

class LoadingBalanceState extends BalanceState {
  const LoadingBalanceState();
}

class BalanceStateData extends BalanceState {
  final BigInt balance;

  const BalanceStateData(this.balance);
}

class UnavailableBalanceState extends BalanceState {
  const UnavailableBalanceState();
}
