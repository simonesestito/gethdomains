part of 'injector.dart';

class _BlocDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _BlocDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AppRouter(authenticationGuard: context.read()),
        ),
        // Global BLoCs are injected here
        BlocProvider(
          create: (context) => ThemeCubit(ThemeBrightness.system),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: context.read(),
          ),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
