import 'package:auto_route/auto_route.dart';

/// Create a routing Guard that will allow or deny access to a route,
/// based on the user's authentication status.
class AuthenticationGuard extends AutoRouteGuard {
  const AuthenticationGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: implement onNavigation
    resolver.next(true);
  }
}
