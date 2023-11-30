import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/auth/auth_bloc.dart';
import 'package:gethdomains/bloc/domain_search/domain_search_bloc.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:gethdomains/repository/domain_repository.dart';
import 'package:gethdomains/service/theme_updater.dart';

part 'base.dart';

part 'repository.dart';

part 'bloc.dart';

class DependencyInjector extends StatelessWidget {
  final WidgetBuilder builder;

  const DependencyInjector({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return _BaseDependencies(
      child: _RepositoryDependencies(
        child: _BlocDependencies(
          child: Builder(builder: builder),
        ),
      ),
    );
  }
}
