part of 'injector.dart';

class _RepositoryDependencies extends StatelessWidget {
  final WidgetBuilder builder;

  const _RepositoryDependencies({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => DomainRepository(
                  contract: context.read(),
                  ipfsCidEncoder: context.read(),
                  torAddressEncoder: context.read(),
                  domainEncoder: context.read(),
                )),
        RepositoryProvider(
            create: (context) => AuthRepository(
                  sepoliaNetworkDetector: context.read(),
                )),
        RepositoryProvider(
            create: (context) => BalanceRepository(
                  context.read(),
                )),
      ],
      child: Builder(builder: builder),
    );
  }
}
