import 'package:auto_route/auto_route.dart';
import 'package:gethdomains/routes/home.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    RedirectRoute(path: '/', redirectTo: '/home'),
    AutoRoute(path: '/home', page: HomeRoute.page),
  ];
}