import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:gethdomains/pages/domain_registration.dart';
import 'package:gethdomains/pages/domain_editing.dart';
import 'package:gethdomains/pages/home.dart';
import 'package:gethdomains/pages/login_status.dart';
import 'package:gethdomains/pages/settings.dart';
import 'package:gethdomains/routing/guard/auth_guard.dart';
import 'package:gethdomains/model/domain.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthenticationGuard authenticationGuard;

  AppRouter({required this.authenticationGuard});

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes =>
      [
        RedirectRoute(path: '/', redirectTo: '/home'),
        AutoRoute(path: '/home', page: HomeRoute.page),
        AutoRoute(
          path: '/domainRegistration',
          page: DomainRegistrationRoute.page,
          guards: [authenticationGuard],
        ),
        AutoRoute(
          path: '/domainEditing',
          page: DomainEditingRoute.page,
          guards: [authenticationGuard],
        ),
        AutoRoute(path: '/loginStatus', page: LoginStatusRoute.page),
        AutoRoute(path: '/settings', page: SettingsRoute.page),
      ];
}
