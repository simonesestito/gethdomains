import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/model/account.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthLoggedOut()) {
    on<AuthLogin>(_onLogin);
    on<AuthLogout>(_onLogout);
  }

  void login() => add(const AuthLogin());

  void logout() => add(const AuthLogout());

  FutureOr<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    // TODO: Use a repository
    emit(const AuthLoading());
    emit(const AuthLoggedIn(UserAccount(address: '0x000000')));
  }

  FutureOr<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    // TODO: Use a repository
    emit(const AuthLoading());
    emit(const AuthLoggedOut());
  }
}