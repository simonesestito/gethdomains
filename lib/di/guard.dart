part of 'injector.dart';

class _GuardDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _GuardDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthenticationGuard(authRepository: context.read()),
        ),
      ],
      child: Builder(builder: builder),
    );
  }
}
