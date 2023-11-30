import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';

part 'domain_search_event.dart';

part 'domain_search_state.dart';

class DomainSearchBloc extends Bloc<DomainSearchEvent, DomainSearchState> {
  final DomainRepository domainRepository;

  DomainSearchBloc({required this.domainRepository})
      : super(const DomainSearchStateInitial()) {
    on<DomainSearchEventSearch>(_onSearch);
    on<DomainSearchEventClear>(_onClear);
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
        emit(const DomainSearchStateNoResults());
      }
    } catch (e) {
      emit(DomainSearchStateError(e.toString()));
    }
  }

  FutureOr<void> _onClear(
    DomainSearchEventClear event,
    Emitter<DomainSearchState> emit,
  ) async {
    emit(const DomainSearchStateInitial());
  }
}
