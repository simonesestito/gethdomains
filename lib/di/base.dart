part of 'injector.dart';

class _BaseDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _BaseDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => const ThemeUpdater()),
        RepositoryProvider(create: (_) => GlobalErrorsSink()),
        RepositoryProvider(create: (_) => GlobalEventsSink()),
        RepositoryProvider(create: (_) => SepoliaNetworkDetector()),
        RepositoryProvider(create: (_) => const IpfsCidEncoder()),
        RepositoryProvider(create: (_) => const TorAddressEncoder()),
        RepositoryProvider(create: (_) => const DomainEncoder()),
      ],
      child: Builder(builder: builder),
    );
  }
}
