import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/repository/balance_repository.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final BalanceRepository balanceRepository;

  BalanceBloc({
    required this.balanceRepository,
    required Stream<AuthState> authStateChanges,
  }) : super(const LoadingBalanceState()) {
    // TODO: Add a listener for events from the smart contract, propagated through the repository
    on<LoadBalanceEvent>(_onLoadBalanceEvent);
    on<_UpdateBalanceEvent>(_onUpdateBalanceEvent);

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
  }

  FutureOr<void> _onLoadBalanceEvent(
    LoadBalanceEvent event,
    Emitter<BalanceState> emit,
  ) async {
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
}
