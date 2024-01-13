import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/repository/selling_repository.dart';
import 'package:gethdomains/utils/set_utils.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  final SellingRepository sellingRepository;
  final DomainRepository domainRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;

  // State
  final Set<Domain> domains = {};
  final Set<Domain> loadingDomains = {};

  SellingBloc({
    required this.sellingRepository,
    required this.domainRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
  }) : super(const SellingLoading()) {
    on<SellingLoad>(_onLoad);
    // on<SellingBuy>(_onBuy);
    on<SellingBought>(_onBought);
    on<SellingListed>(_onListed);

    // Start initial loading
    add(const SellingLoad());

    // Listen to global events of domain listings
    globalEventsSink.domainListings.listen((event) {
      if (event.price.compareTo(BigInt.zero) == 0) {
        // When the price is 0, it means the domain has been unlisted
        add(SellingBought(domainName: event.domainName));
      } else {
        _onDomainListed(event);
      }
    });

    // Listen to global events of domain purchases
    globalEventsSink.domainPurchases.listen((event) {
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
      emit(SellingData.fromDomainsSet(
        domains: this.domains,
        loadingDomains: loadingDomains,
      ));
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      emit(const SellingError());
    }
  }

  FutureOr<void> _onBought(SellingBought event, Emitter<SellingState> emit) {
    // A domain has been bought => remove it from the list
    domains.removeWhere((domain) => domain.domainName == event.domainName);
    loadingDomains
        .removeWhere((domain) => domain.domainName == event.domainName);
    emit(SellingData.fromDomainsSet(
      domains: domains,
      loadingDomains: loadingDomains,
    ));
  }

  FutureOr<void> _onListed(SellingListed event, Emitter<SellingState> emit) {
    // A domain has been listed => add it to the list
    domains.addOrReplace(event.domain);
    loadingDomains.remove(event.domain);
    emit(SellingData.fromDomainsSet(
      domains: domains,
      loadingDomains: loadingDomains,
    ));
  }

// FutureOr<void> _onBuy(
//   SellingBuy event,
//   Emitter<SellingState> emit,
// ) async {
//   final oldState = state;
//   if (oldState is! SellingData) {
//     add(const SellingLoad());
//     return;
//   }
//
//   // Set the domain as loading
//   final loadingDomains = Set<String>.from(oldState.loadingDomains);
//   loadingDomains.add(event.domain.domainName);
//   emit(SellingData(
//     domains: oldState.domains,
//     loadingDomains: loadingDomains,
//   ));
//
//   try {
//     final txHash = await sellingRepository.buyDomain(event.domain);
//   } catch (e) {
//     return const SellingError();
//   }
// }
}
