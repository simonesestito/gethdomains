import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/input/validators/domain_input.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/repository/selling_repository.dart';
import 'package:gethdomains/utils/list_utils.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  final SellingRepository sellingRepository;
  final DomainRepository domainRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;

  // State
  final List<Domain> domains = List.empty(growable: true);
  final Set<String> loadingDomains = {};

  SellingBloc({
    required this.sellingRepository,
    required this.domainRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
  }) : super(const SellingLoading()) {
    on<SellingLoad>(_onLoad);
    on<SellingBuy>(_onBuy);
    on<SellingBought>(_onBought);
    on<SellingListed>(_onListed);

    // Start initial loading
    add(const SellingLoad());

    // Listen to global events of domain listings
    globalEventsSink.domainListings.map(_removeGethSuffix).listen((event) {
      if (event.price.compareTo(BigInt.zero) == 0) {
        // When the price is 0, it means the domain has been unlisted
        add(SellingBought(domainName: event.domainName));
      } else {
        _onDomainListed(event);
      }
    });

    // Listen to global events of domain purchases
    globalEventsSink.domainPurchases.map(_removeGethSuffix).listen((event) {
      add(SellingBought(domainName: event.domainName));
    });
  }

  void _onDomainListed(Web3DomainListingForSale event) async {
    // When the price is not 0, it means the domain has been listed
    assert(event.price.compareTo(BigInt.zero) != 0);

    // Obtain the full domain object
    final domain = await domainRepository.searchDomain(event.domainName);
    if (domain != null) {
      add(SellingListed(domain: domain));
    }
  }

  FutureOr<void> _onLoad(SellingLoad event, Emitter<SellingState> emit) async {
    emit(const SellingLoading());
    try {
      final domains = await sellingRepository.getDomainsForSale();
      this.domains.addAllOrReplace(domains);
      emit(SellingData(domains: this.domains, loadingDomains: loadingDomains));
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      emit(const SellingError());
    }
  }

  FutureOr<void> _onBought(SellingBought event, Emitter<SellingState> emit) {
    // A domain has been bought => remove it from the list
    domains.removeWhere((domain) => domain.domainName == event.domainName);
    loadingDomains.remove(event.domainName);
    emit(SellingData(domains: domains, loadingDomains: loadingDomains));
  }

  FutureOr<void> _onListed(SellingListed event, Emitter<SellingState> emit) {
    // A domain has been listed => add it to the list
    domains.addOrReplace(event.domain);
    loadingDomains.removeWhere((domain) => domain == event.domain.domainName);
    emit(SellingData(domains: domains, loadingDomains: loadingDomains));
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
      Web3DomainSold _ => event.copyWith(
          domainName: removeDomainName(event.domainName),
        ),
      _ => throw UnimplementedError('[SellingBloc] Unknown event type: $event'),
    } as T;
  }

  void buy(Domain domain) => add(SellingBuy(domain: domain));

  FutureOr<void> _onBuy(
    SellingBuy event,
    Emitter<SellingState> emit,
  ) async {
    // Set the domain as loading
    loadingDomains.add(event.domain.domainName);
    emit(SellingData(domains: domains, loadingDomains: loadingDomains));

    try {
      final txHash = await sellingRepository.buyDomain(event.domain);
      globalEventsSink.addWeb3Event(Web3TransactionSent(txHash));
      // No need for more updates, since an event will do the job
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);

      // Error: restore old state
      loadingDomains.remove(event.domain.domainName);
      emit(SellingData(domains: domains, loadingDomains: loadingDomains));
    }
  }
}
