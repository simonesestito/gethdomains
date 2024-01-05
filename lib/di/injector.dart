import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/balance/balance_bloc.dart';
import 'package:gethdomains/bloc/domains/domains_bloc.dart';
import 'package:gethdomains/bloc/global_errors/global_errors.dart';
import 'package:gethdomains/bloc/sepolia/sepolia_bloc.dart';
import 'package:gethdomains/bloc/settings/settings.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:gethdomains/contracts/geth_contract.dart';
import 'package:gethdomains/repository/auth_repository.dart';
import 'package:gethdomains/repository/balance_repository.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/routing/guard/auth_guard.dart';
import 'package:gethdomains/routing/router.dart';
import 'package:gethdomains/service/sepolia_detector.dart';
import 'package:gethdomains/service/theme_updater.dart';

part 'base.dart';
part 'bloc.dart';
part 'guard.dart';
part 'repository.dart';
part 'service.dart';

class DependencyInjector extends StatelessWidget {
  final WidgetBuilder builder;

  const DependencyInjector({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _BaseDependencies(
      builder: (context) => _ServiceDependencies(
        builder: (context) => _RepositoryDependencies(
          builder: (context) => _BlocDependencies(
            builder: (context) => _GuardDependencies(
              builder: (context) => RepositoryProvider(
                create: (context) =>
                    AppRouter(authenticationGuard: context.read()),
                child: Builder(builder: builder),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
