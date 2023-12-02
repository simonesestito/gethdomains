part of 'injector.dart';

class _BlocDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _BlocDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Global BLoCs are injected here
        BlocProvider(
          create: (context) => ThemeCubit(ThemeBrightness.system),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
