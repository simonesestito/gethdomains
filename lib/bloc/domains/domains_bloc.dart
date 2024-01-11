import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';

part 'domains_event.dart';
part 'domains_state.dart';

class DomainsBloc extends Bloc<DomainsEvent, DomainsState> {
  final DomainRepository domainsRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;

  DomainsBloc({
    required this.domainsRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
    required Stream<AuthState> authStateChanges,
  }) : super(const LoadingDomainsState()) {
    on<LoadDomainsEvent>(_onLoadDomainsEvent);
    on<_UpdateDomainsEvent>(_onUpdateDomainsEvent);
    on<PurchaseDomainEvent>(_onPurchaseNewDomain);

    // Listen to the auth state changes
    // They should reset the domains status
    authStateChanges.listen((state) {
      debugPrint('DomainsBloc: authStateChanges.listen: $state');
      if (state is AuthLoggedIn) {
        add(const LoadDomainsEvent());
      } else {
        add(const _UpdateDomainsEvent(domains: null));
      }
    });

    // Listen to the global events of Transfers
    // They should update the domains status
    globalEventsSink.domainTransfers.listen((event) {
      debugPrint(
          'DomainsBloc: globalEventsSink.domainTransfers.listen: $event');
      add(const LoadDomainsEvent());
    });
  }

  FutureOr<void> _onLoadDomainsEvent(
    LoadDomainsEvent event,
    Emitter<DomainsState> emit,
  ) async {
    emit(const LoadingDomainsState());
    try {
      final domains = await domainsRepository.getMyDomains();
      emit(DomainsStateData(domains));
    } catch (e, stackTrace) {
      emit(const UnavailableDomainsState());
    }
  }

  /// Handle the event _UpdateDomainsEvent, which is private.
  /// So, the data it gives can be trusted (not coming from outside classes).
  FutureOr<void> _onUpdateDomainsEvent(
    _UpdateDomainsEvent event,
    Emitter<DomainsState> emit,
  ) async {
    if (event.domains == null) {
      emit(const UnavailableDomainsState());
    } else {
      emit(DomainsStateData(event.domains!));
    }
  }

  Future<void> _wrapSmartContractInvocation<T>(
    Future<String> Function() invocation,
    Emitter<DomainsState> emit,
  ) async {
    emit(const LoadingDomainsState());
    try {
      final txHash = await invocation();
      globalEventsSink.addWeb3Event(Web3TransactionSent(txHash));
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      debugPrint('DomainsBloc: _wrapSmartContractInvocation: $e');
      // Refresh only on error, otherwise an update will be triggered by events
      final domains = await domainsRepository.getMyDomains();
      add(_UpdateDomainsEvent(domains: domains));
    }
  }

  Future<BigInt> estimatePurchaseFees(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) =>
      domainsRepository.predictDomainPurchaseFees(
        domainName,
        pointedAddress,
        domainType,
      );

  void purchaseNewDomain(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) =>
      add(PurchaseDomainEvent(
        domainName: domainName,
        pointedAddress: pointedAddress,
        domainType: domainType,
      ));

  FutureOr<void> _onPurchaseNewDomain(
    PurchaseDomainEvent event,
    Emitter<DomainsState> emit,
  ) =>
      _wrapSmartContractInvocation(
          () => domainsRepository.purchaseNewDomain(
                event.domainName,
                event.pointedAddress,
                event.domainType,
              ),
          emit);
}
