part of 'domain_search.dart';

class _DomainSearchButton extends StatelessWidget {
  final DomainSearchCallback onSubmit;

  const _DomainSearchButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DomainSearchBloc, DomainSearchState>(
        builder: (context, state) => switch (state) {
              DomainSearchStateLoading() => const CircularProgressIndicator(),
              DomainSearchStateInitial() => _buildButton(context),
        // TODO: Manage those states in a better way
          DomainSearchStateError() => const Icon(Icons.error),
              DomainSearchStateNoResults() =>
                const Icon(Icons.youtube_searched_for),
              DomainSearchStateSuccess _ => _buildButton(context),
            });
  }

  Widget _buildButton(BuildContext context) => ReactiveFormConsumer(
        builder: (context, form, _) => FloatingActionButton.extended(
          onPressed: () {
            form.markAllAsTouched();
            if (form.valid) {
              onSubmit(form.value[DomainSearchForm._kDomain].toString());
            }
          },
          label: Text(AppLocalizations.of(context)!.domainsSearchSubmitButton),
          icon: const Icon(Icons.search),
        ),
      );
}
