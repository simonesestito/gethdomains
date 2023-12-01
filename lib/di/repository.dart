part of 'injector.dart';

class _RepositoryDependencies extends StatelessWidget {
  final Widget child;

  const _RepositoryDependencies({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (_) => const DomainRepository()),
      RepositoryProvider(create: (_) => const AuthRepository()),
    ], child: child);
  }
}