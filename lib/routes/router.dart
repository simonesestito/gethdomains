import 'package:auto_route/auto_route.dart';
import 'package:gethdomains/routes/home.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page),
  ];
}