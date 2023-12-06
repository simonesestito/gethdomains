part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}

class AuthLoggedIn extends AuthState {
  final UserAccount account;

  const AuthLoggedIn(this.account);
}

class AuthMissingProvider extends AuthState {
  const AuthMissingProvider();
}
