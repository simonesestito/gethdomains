part of 'injector.dart';

class _RepositoryDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _RepositoryDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const DomainRepository()),
        RepositoryProvider(create: (_) => AuthRepository()),
      ],
      child: Builder(builder: builder),
    );
  }
}
