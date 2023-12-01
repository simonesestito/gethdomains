import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/routing/router.dart';

/// Create a routing Guard that will allow or deny access to a route,
/// based on the user's authentication status.
class AuthenticationGuard extends AutoRouteGuard {
  final AuthBloc authBloc;

  const AuthenticationGuard({required this.authBloc});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final currentAuthState = authBloc.state;
    if (currentAuthState is AuthLoading) {
      // The auth status is still unknown, so we wait.
      // The AuthBloc will emit a new state when it knows the auth status.
      StreamSubscription? subscription;
      subscription = authBloc.stream.listen((authState) {
        subscription?.cancel();
        _handleNavigationWithKnownAuthStatus(resolver, router, authState);
      });
    } else {
      _handleNavigationWithKnownAuthStatus(resolver, router, currentAuthState);
    }
  }

  void _handleNavigationWithKnownAuthStatus(
    NavigationResolver resolver,
    StackRouter router,
    AuthState authState,
  ) {
    if (authState is AuthLoggedIn) {
      resolver.next(true);
    } else if (authState is AuthLoggedOut) {
      resolver
          .redirect(LoginStatusRoute(popAfterLogin: true))
          .then((loginResult) => resolver.next(loginResult == true));
    }
  }
}
