import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/repository/selling_repository.dart';

part 'domains_event.dart';
part 'domains_state.dart';

class DomainsBloc extends Bloc<DomainsEvent, DomainsState> {
  final DomainRepository domainsRepository;
  final SellingRepository sellingRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;
  String? currentUser;

  DomainsBloc({
    required this.domainsRepository,
    required this.sellingRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
    required Stream<AuthState> authStateChanges,
  }) : super(const LoadingDomainsState()) {
    on<LoadDomainsEvent>(_onLoadDomainsEvent);
    on<_UpdateDomainsEvent>(_onUpdateDomainsEvent);
    on<PurchaseDomainEvent>(_onPurchaseNewDomain);
    on<SellDomainEvent>(_onSellDomainEvent);
    on<UnlistDomainEvent>(_onUnlistDomainEvent);
    on<DomainListedForSaleEvent>(_onDomainListedForSaleEvent);
    on<EditDomainEvent>(_onEditDomainEvent);

    // Listen to the auth state changes
    // They should reset the domains status
    authStateChanges.listen((state) {
      debugPrint('DomainsBloc: authStateChanges.listen: $state');
      if (state is AuthLoggedIn) {
        currentUser = state.account.address;
        add(const LoadDomainsEvent());
      } else {
        currentUser = null;
        add(const _UpdateDomainsEvent(domains: null));
      }
    });

    // Listen to the global events of Transfers
    // They should update the domains status
    globalEventsSink.domainTransfers.map(_removeGethSuffix).listen((event) {
      debugPrint(
          'DomainsBloc: globalEventsSink.domainTransfers.listen: $event');
      add(const LoadDomainsEvent());
    });

    // Listen to the global events of DomainForSale
    // but react only to knows domains
    globalEventsSink.domainListings.map(_removeGethSuffix).listen((event) {
      debugPrint('DomainsBloc: globalEventsSink.domainListings.listen: $event');
      add(DomainListedForSaleEvent(event.domainName, event.price));
    });

    // Listen to the global events of domain edits
    // and react to my domains only
    globalEventsSink.domainEdits.map(_removeGethSuffix).listen((event) {
      if (event.owner == currentUser) {
        debugPrint('DomainsBloc: globalEventsSink.domainEdits.listen: $event');
        add(const LoadDomainsEvent());
      }
    });
  }

  FutureOr<void> _onLoadDomainsEvent(
    LoadDomainsEvent event,
    Emitter<DomainsState> emit,
  ) async {
    emit(const LoadingDomainsState());
    try {
      final domains = await domainsRepository.getMyDomains();
      emit(DomainsStateData(domains, {}));
    } catch (e) {
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
      emit(DomainsStateData(event.domains!, {}));
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

  FutureOr<void> _onPurchaseNewDomain(PurchaseDomainEvent event,
      Emitter<DomainsState> emit,) =>
      _wrapSmartContractInvocation(
              () =>
              domainsRepository.purchaseNewDomain(
                event.domainName,
                event.pointedAddress,
                event.domainType,
              ),
          emit);

  void sellDomain(String domainName, BigInt price) =>
      add(SellDomainEvent(domainName: domainName, price: price));

  FutureOr<void> _wrapSellingDomainInvocation<T>(String domainName,
      Future<String> Function() invocation,
      Emitter<DomainsState> emit,) async {
    // Don't emit a full loading state: just update a single domain
    final oldState = state;
    _emitNewLoadingDomain(domainName, emit);
    try {
      final txHash = await invocation();
      globalEventsSink.addWeb3Event(Web3TransactionSent(txHash));
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      debugPrint('DomainsBloc: _onSellDomainEvent: $e');
      if (oldState is DomainsStateData) {
        // Rollback state
        emit(oldState);
      } else {
        // Refresh only on error, otherwise an update will be triggered by events
        final domains = await domainsRepository.getMyDomains();
        add(_UpdateDomainsEvent(domains: domains));
      }
    }
  }

  FutureOr<void> _onSellDomainEvent(
    SellDomainEvent event,
    Emitter<DomainsState> emit,
  ) =>
      _wrapSellingDomainInvocation(
        event.domainName,
        () => sellingRepository.sellDomain(event.domainName, event.price),
        emit,
      );

  void unlistDomain(String domainName) =>
      add(UnlistDomainEvent(domainName: domainName));

  FutureOr<void> _onUnlistDomainEvent(
    UnlistDomainEvent event,
    Emitter<DomainsState> emit,
  ) =>
      _wrapSellingDomainInvocation(
        event.domainName,
        () => sellingRepository.unlistDomainFromSelling(event.domainName),
        emit,
      );

  Future<BigInt> estimateDomainEditFees(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) =>
      domainsRepository.estimateDomainEditFees(
        domainName,
        pointedAddress,
        domainType,
      );

  void editDomainPointer(
    String domainName,
    String pointedAddress,
    DomainType domainType,
  ) =>
      add(EditDomainEvent(
        domainName: domainName,
        pointedAddress: pointedAddress,
        domainType: domainType,
      ));

  FutureOr<void> _onEditDomainEvent(
    EditDomainEvent event,
    Emitter<DomainsState> emit,
  ) =>
      _wrapSmartContractInvocation(
        () => domainsRepository.editDomainPointer(
          event.domainName,
          event.pointedAddress,
          event.domainType,
        ),
        emit,
      );

  void _emitNewLoadingDomain(String loadingDomain, Emitter<DomainsState> emit) {
    // Add the loading state of the current domain only
    final Set<String> loadingDomains = {};
    if (state is DomainsStateData) {
      loadingDomains.addAll((state as DomainsStateData).loadingDomains);
    }
    loadingDomains.add(loadingDomain);

    final List<Domain> availableDomains =
        state is DomainsStateData ? (state as DomainsStateData).domains : [];

    emit(DomainsStateData(availableDomains, loadingDomains));
  }

  FutureOr<void> _onDomainListedForSaleEvent(
    DomainListedForSaleEvent event,
    Emitter<DomainsState> emit,
  ) {
    final oldState = state;
    if (oldState is! DomainsStateData) {
      // Reload from scratch
      add(const LoadDomainsEvent());
      return null;
    }

    final oldDomains = List<Domain>.from(oldState.domains);

    // Remove the loading state of the current domain only
    oldState.loadingDomains.remove(event.domainName);

    if (oldDomains
        .where((domain) => domain.domainName == event.domainName)
        .isEmpty) {
      // unknown domain
      debugPrint(
          'Ignored DomainListedForSaleEvent for unknown domain ${event.domainName}');
      return null;
    }

    // Replace the current domain with the loaded one
    final oldDomain = oldDomains
        .firstWhere((domain) => domain.domainName == event.domainName);
    final newDomain = oldDomain.copyWith(price: event.price);

    // Replace the current domain with the loaded one
    final newDomains = List.of([newDomain], growable: true);
    for (final domain in oldState.domains) {
      if (domain.domainName != newDomain.domainName) {
        newDomains.add(domain);
      }
    }

    emit(DomainsStateData(newDomains, oldState.loadingDomains));
  }

  T _removeGethSuffix<T extends Web3DomainEvent>(T event) {
    removeDomainName(domainName) => domainName.substring(
          0,
          domainName.length - DomainInputValidator.domainSuffix.length,
        );

    return switch (event) {
      Web3DomainListingForSale _ => event.copyWith(
          domainName: removeDomainName(event.domainName),
        ),
      Web3DomainTransfer _ => event.copyWith(
          domainName: removeDomainName(event.domainName),
        ),
      Web3DomainEdited _ => event.copyWith(
          domainName: removeDomainName(event.domainName),
        ),
      _ => throw UnimplementedError('[DomainsBloc] Unknown event type: $event'),
    } as T;
  }
}
