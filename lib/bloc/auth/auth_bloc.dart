import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/model/account.dart';
import 'package:gethdomains/repository/auth_repository.dart';
import 'package:gethdomains/utils/bloc_loading_debounce.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthLoading()) {
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
    on<AuthLoadCurrentUser>(_loadCurrentUser);

    // Initial load of current user
    add(const AuthLoadCurrentUser());
  }

  void login() => add(const AuthLogin());

  void logout() => add(const AuthLogout());

  String? getCurrentUserAddress() {
    final state = this.state;
    if (state is AuthLoggedIn) {
      return state.account.address;
    }
    return null;
  }

  FutureOr<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    if (!await authRepository.canLogin()) {
      emit(const AuthMissingProvider());
      return;
    }

    try {
      final loginResult = await delayLoading(
        action: authRepository.login,
        emitLoading: () => emit(const AuthLoading()),
      );
      if (loginResult != null) {
        emit(AuthLoggedIn(loginResult));
      } else {
        emit(const AuthLoggedOut());
      }
    } catch (err) {
      emit(const AuthLoggedOut());
    }
  }

  FutureOr<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    await delayLoading(
      action: authRepository.logout,
      emitLoading: () => emit(const AuthLoading()),
    );
    emit(const AuthLoggedOut());
  }

  FutureOr<void> _loadCurrentUser(
    AuthLoadCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    final shouldFetchUser = await authRepository.wasLoggedIn();
    debugPrint('Should fetch user: $shouldFetchUser');
    if (!shouldFetchUser) {
      emit(const AuthLoggedOut());
    } else {
      // Try to recover the current user
      emit(const AuthLoading());

      try {
        final currentUser = await authRepository.getCurrentUser();
        debugPrint(
            'Current user: $currentUser (type: ${currentUser.runtimeType})');
        if (currentUser != null) {
          emit(AuthLoggedIn(currentUser));
        } else {
          emit(const AuthLoggedOut());
        }
      } catch (err) {
        debugPrint('Error loading current user: $err');
        emit(const AuthLoggedOut());
      }
    }
  }
}
