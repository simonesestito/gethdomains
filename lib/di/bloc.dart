part of 'injector.dart';

class _BlocDependencies extends StatelessWidget {
  final Widget child;

  const _BlocDependencies({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      BlocProvider(
        create: (context) => ThemeCubit(ThemeBrightness.system),
      ),
      BlocProvider(
        create: (context) => DomainSearchBloc(domainRepository: context.read()),
      ),
    ], child: child);
  }
}
