part of 'domain_search.dart';

class _DomainSearchField extends StatelessWidget {
  final String formControlName;

  const _DomainSearchField({required this.formControlName});

  @override
  Widget build(BuildContext context) {
    final domainSearchBloc = context.read<DomainSearchBloc>();

    return ReactiveTextField<String>(
      formControlName: DomainSearchForm._kDomain,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.domainsSearchInputHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
        // prefixIcon: const Icon(Icons.search),
        // prefixIconColor: Theme.of(context).iconTheme.color,
      ),
      validationMessages: {
        ValidationMessage.required: (_) =>
        AppLocalizations.of(context)!.inputErrorRequired,
        ValidationMessage.minLength: (_) =>
        AppLocalizations.of(context)!.inputErrorDomainTooShort,
        ValidationMessage.pattern: (_) =>
        AppLocalizations.of(context)!.inputErrorDomainInvalid,
      },
      onChanged: (value) => domainSearchBloc.clear(),
    );
  }
}
