import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/model/account.dart';
import 'package:gethdomains/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthLoggedOut()) {
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  void login() => add(const AuthLogin());

  void logout() => add(const AuthLogout());

  FutureOr<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final loginResult = await authRepository.login();
      if (loginResult != null) {
        emit(AuthLoggedIn(loginResult));
      } else {
        emit(const AuthLoggedOut());
      }
    } catch (err) {
      // TODO: Better login error handling (one-shot error message?)
      emit(const AuthLoggedOut());
    }
  }

  FutureOr<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      await authRepository.logout();
    } catch (err) {
      debugPrint('Error logging out: $err');
    }
    emit(const AuthLoggedOut());
  }
}