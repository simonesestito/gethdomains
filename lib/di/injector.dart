import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:gethdomains/service/theme_updater.dart';
import 'package:provider/provider.dart';

class DependencyInjector extends StatelessWidget {
  final WidgetBuilder builder;

  const DependencyInjector({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(ThemeBrightness.system),
        ),
        Provider(create: (_) => const ThemeUpdater()),
      ],
      child: Builder(builder: builder),
    );
  }
}
