import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/contracts/exceptions.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/selling_repository.dart';

part 'selling_event.dart';
part 'selling_state.dart';

class SellingBloc extends Bloc<SellingEvent, SellingState> {
  final SellingRepository sellingRepository;
  final GlobalErrorsSink globalErrorsSink;
  final GlobalEventsSink globalEventsSink;

  SellingBloc({
    required this.sellingRepository,
    required this.globalErrorsSink,
    required this.globalEventsSink,
  }) : super(const SellingLoading()) {
    on<SellingLoad>(_onLoad);
    // on<SellingBuy>(_onBuy);
    // on<SellingBought>(_onBought);
    // on<SellingListed>(_onListed);

    add(const SellingLoad());
  }

  FutureOr<void> _onLoad(
    SellingLoad event,
    Emitter<SellingState> emit,
  ) async {
    emit(const SellingLoading());
    try {
      final domains = await sellingRepository.getDomainsForSale();
      emit(SellingData(domains: domains, loadingDomains: {}));
    } on Web3Exception catch (e) {
      globalErrorsSink.addWeb3Error(e);
      emit(const SellingError());
    }
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
