import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/repository/balance_repository.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceRepository balanceRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;

  BalanceBloc({
    required this.balanceRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
    required Stream<AuthState> authStateChanges,
  }) : super(const LoadingBalanceState()) {
    on<LoadBalanceEvent>(_onLoadBalanceEvent);
    on<_UpdateBalanceEvent>(_onUpdateBalanceEvent);
    on<BuyTokensEvent>(_onBuyTokensEvent);
    on<SellTokensEvent>(_onSellTokensEvent);

    // Listen to the auth state changes
    // They should reset the balance status
    authStateChanges.listen((state) {
      debugPrint('BalanceBloc: authStateChanges.listen: $state');
      if (state is AuthLoggedIn) {
        add(const LoadBalanceEvent());
      } else {
        add(const _UpdateBalanceEvent(balance: null));
      }
    });

    // Listen to coin transfers
    globalEventsSink.coinTransfers.listen((event) {
      debugPrint('BalanceBloc: globalEventsSink.coinTransfers.listen: $event');
      add(const LoadBalanceEvent());
    });
  }

  FutureOr<void> _onLoadBalanceEvent(
    LoadBalanceEvent event,
    Emitter<BalanceState> emit,
  ) async {
    debugPrint('BalanceBloc: _onLoadBalanceEvent');
    emit(const LoadingBalanceState());
    try {
      final balance = await balanceRepository.getBalance();
      emit(BalanceStateData(balance));
    } catch (e) {
      emit(const UnavailableBalanceState());
    }
  }

  /// Handle the event _UpdateBalanceEvent, which is private.
  /// So, the data it gives can be trusted (not coming from outside classes).
  FutureOr<void> _onUpdateBalanceEvent(
    _UpdateBalanceEvent event,
    Emitter<BalanceState> emit,
  ) async {
    if (event.balance == null) {
      emit(const UnavailableBalanceState());
    } else {
      emit(BalanceStateData(event.balance!));
    }
  }

  void buyTokens(BigInt amount) => add(BuyTokensEvent(amount));

  FutureOr<T?> _wrapSmartContractInvocation<T>(
    Future<T> Function() invocation,
    Emitter<BalanceState> emit,
  ) async {
    emit(const LoadingBalanceState());
    try {
      return await invocation();
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      debugPrint('BalanceBloc: _wrapSmartContractInvocation: $e');
      // Refresh only on error, otherwise an update will be triggered by events
      final balance = await balanceRepository.getBalance();
      add(_UpdateBalanceEvent(balance: balance));
    }
    return null;
  }

  FutureOr<void> _onBuyTokensEvent(
    BuyTokensEvent event,
    Emitter<BalanceState> emit,
  ) =>
      _wrapSmartContractInvocation(() async {
        final txHash = await balanceRepository.purchaseTokens(event.amount);
        globalEventsSink.addWeb3Event(Web3TransactionSent(txHash));
      }, emit);

  void sellTokens(BigInt amount) => add(SellTokensEvent(amount));

  FutureOr<void> _onSellTokensEvent(
    SellTokensEvent event,
    Emitter<BalanceState> emit,
  ) =>
      _wrapSmartContractInvocation(() async {
        final txHash = await balanceRepository.sellTokens(event.amount);
        globalEventsSink.addWeb3Event(Web3TransactionSent(txHash));
      }, emit);
}
