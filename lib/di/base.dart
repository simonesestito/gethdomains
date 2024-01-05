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
        RepositoryProvider(create: (_) => SepoliaNetworkDetector()),
      ],
      child: Builder(builder: builder),
    );
  }
}
