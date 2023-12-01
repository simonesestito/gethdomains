part of 'injector.dart';

class _BlocDependencies extends StatelessWidget {
  final Widget child;

  const _BlocDependencies({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      // Global BLoCs are injected here
      BlocProvider(
        create: (context) => ThemeCubit(ThemeBrightness.system),
      ),
      BlocProvider(
        create: (context) => AuthBloc(
          authRepository: context.read(),
        ),
      ),
    ], child: child);
  }
}
