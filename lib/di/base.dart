part of 'injector.dart';

class _BaseDependencies extends StatelessWidget {
  final Widget child;

  const _BaseDependencies({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (_) => const ThemeUpdater()),
    ], child: child);
  }
}