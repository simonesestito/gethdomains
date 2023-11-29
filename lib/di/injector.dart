import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/bloc/theme/theme.dart';

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
      ],
      child: Builder(builder: builder),
    );
  }
}
