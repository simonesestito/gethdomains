part of 'injector.dart';

class _BlocDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _BlocDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc(authRepository: context.read());

    return MultiRepositoryProvider(
      providers: [
        // Global BLoCs are injected here
        BlocProvider(
          create: (context) => ThemeCubit(ThemeBrightness.system),
        ),
        BlocProvider.value(value: authBloc),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
        BlocProvider(
          create: (context) => SepoliaNetworkBloc(
            sepoliaNetworkDetector: context.read(),
          ),
        ),
        BlocProvider(
          create: (context) => BalanceBloc(
            balanceRepository: context.read(),
            globalErrorsSink: context.read(),
            authStateChanges: authBloc.stream,
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DomainsBloc(
            domainsRepository: context.read(),
            authStateChanges: authBloc.stream,
          ),
          lazy: false,
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
