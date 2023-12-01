import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:gethdomains/repository/auth_repository.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/routing/guard/auth_guard.dart';
import 'package:gethdomains/routing/router.dart';
import 'package:gethdomains/service/theme_updater.dart';

part 'base.dart';
part 'bloc.dart';
part 'guard.dart';
part 'repository.dart';

class DependencyInjector extends StatelessWidget {
  final WidgetBuilder builder;

  const DependencyInjector({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _BaseDependencies(
      builder: (_) => _RepositoryDependencies(
        builder: (_) => _GuardDependencies(
          builder: (_) => _BlocDependencies(
            builder: builder,
          ),
        ),
      ),
    );
  }
}
