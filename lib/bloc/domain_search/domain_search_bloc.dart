import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_events.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';

part 'domain_search_event.dart';
part 'domain_search_state.dart';

class DomainSearchBloc extends Bloc<DomainSearchEvent, DomainSearchState> {
  final DomainRepository domainRepository;
  final GlobalEventsSink globalEventsSink;

  DomainSearchBloc({
    required this.domainRepository,
    required this.globalEventsSink,
  }) : super(const DomainSearchStateInitial()) {
    on<DomainSearchEventSearch>(_onSearch);
    on<DomainSearchEventClear>(_onClear);

    // Listen for events in domains
    globalEventsSink.domainTransfers.listen((event) {
      debugPrint('[DomainSearchBloc] transfer event received: $event');
      debugPrint(
          '[DomainSearchBloc] last searched domain: ${_getLastSearchedDomain()}');
      debugPrint('[DomainSearchBloc] event domain: ${event.domainName}');

      if (_getLastSearchedDomain() == event.domainName) {
        // Reload the domain
        search(event.domainName);
      }
    });
  }

  void search(String domain) => add(DomainSearchEventSearch(domain));

  void clear() => add(const DomainSearchEventClear());

  FutureOr<void> _onSearch(
    DomainSearchEventSearch event,
    Emitter<DomainSearchState> emit,
  ) async {
    emit(const DomainSearchStateLoading());

    try {
      final domain = await domainRepository.searchDomain(event.domainName);

      if (domain != null) {
        emit(DomainSearchStateSuccess(domain));
      } else {
        emit(DomainSearchStateNoResults(event.domainName));
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      emit(DomainSearchStateError(
        errorMessage: e.toString(),
        domainName: event.domainName,
      ));
    }
  }

  FutureOr<void> _onClear(
    DomainSearchEventClear event,
    Emitter<DomainSearchState> emit,
  ) async {
    emit(const DomainSearchStateInitial());
  }

  String? _getLastSearchedDomain() => switch (state) {
        DomainSearchStateInitial() => null,
        DomainSearchStateLoading() => null,
        DomainSearchStateNoResults state => state.domainName,
        DomainSearchStateSuccess state => state.domainSearchResult.domainName,
        DomainSearchStateError state => state.domainName,
      };
}
