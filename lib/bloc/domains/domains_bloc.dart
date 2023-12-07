import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/model/domain.dart';
import 'package:gethdomains/repository/domain_repository.dart';

part 'domains_event.dart';
part 'domains_state.dart';

class DomainsBloc extends Bloc<DomainsEvent, DomainsState> {
  final DomainRepository domainsRepository;

  DomainsBloc({
    required this.domainsRepository,
    required Stream<AuthState> authStateChanges,
  }) : super(const LoadingDomainsState()) {
    // TODO: Add a listener for events from the smart contract, propagated through the repository
    on<LoadDomainsEvent>(_onLoadDomainsEvent);
    on<_UpdateDomainsEvent>(_onUpdateDomainsEvent);

    // Listen to the auth state changes
    // They should reset the domains status
    authStateChanges.listen((state) {
      debugPrint('DomainsBloc: authStateChanges.listen: $state');
      if (state is AuthLoggedIn) {
        add(LoadDomainsEvent(ownerAddress: state.account.address));
      } else {
        add(const _UpdateDomainsEvent(domains: null));
      }
    });
  }

  FutureOr<void> _onLoadDomainsEvent(
    LoadDomainsEvent event,
    Emitter<DomainsState> emit,
  ) async {
    emit(const LoadingDomainsState());
    try {
      final domains = await domainsRepository.getDomainsOf(event.ownerAddress);
      emit(DomainsStateData(domains));
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
      emit(DomainsStateData(event.domains!));
    }
  }
}