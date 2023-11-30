part of 'domain_search.dart';

class _DomainSearchButton extends StatelessWidget {
  final Function() onSubmit;
  final Function() onRegister;

  const _DomainSearchButton({required this.onSubmit, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DomainSearchBloc, DomainSearchState>(
        builder: (context, state) => switch (state) {
              DomainSearchStateLoading() => const CircularProgressIndicator(),
              DomainSearchStateNoResults() => _buildRegisterButton(context),
              _ => _buildSearchButton(context),
            });
  }

  Widget _buildSearchButton(BuildContext context) => ReactiveFormConsumer(
        builder: (context, form, _) => FloatingActionButton.extended(
          onPressed: onSubmit,
          label: Text(AppLocalizations.of(context)!.domainsSearchSubmitButton),
          icon: const Icon(Icons.search),
        ),
      );

  Widget _buildRegisterButton(BuildContext context) => ReactiveFormConsumer(
        builder: (context, form, _) => FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: onRegister,
          label: Text(
            AppLocalizations.of(context)!.domainsSearchRegisterButton,
          ),
          icon: const Icon(Icons.app_registration),
        ),
      );
}
