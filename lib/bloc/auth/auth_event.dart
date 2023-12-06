part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthLogin extends AuthEvent {
  const AuthLogin();
}

class AuthLogout extends AuthEvent {
  const AuthLogout();
}

class AuthLoadCurrentUser extends AuthEvent {
  const AuthLoadCurrentUser();
}