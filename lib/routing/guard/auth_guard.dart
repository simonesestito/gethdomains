import 'package:auto_route/auto_route.dart';
import 'package:gethdomains/repository/auth_repository.dart';

/// Create a routing Guard that will allow or deny access to a route,
/// based on the user's authentication status.
class AuthenticationGuard extends AutoRouteGuard {
  final AuthRepository authRepository;

  const AuthenticationGuard({required this.authRepository});

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // TODO: implement onNavigation
    resolver.next(true);
  }
}
