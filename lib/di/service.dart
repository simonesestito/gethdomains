part of 'injector.dart';

class _ServiceDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _ServiceDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const GethContract()),
        RepositoryProvider(create: (_) => const GethDomainsContract()),
      ],
      child: Builder(builder: builder),
    );
  }
}
