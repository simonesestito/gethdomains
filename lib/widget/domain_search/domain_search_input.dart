part of 'domain_search.dart';

class _DomainSearchField extends StatelessWidget {
  final String formControlName;

  const _DomainSearchField({required this.formControlName});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final minWidth = constraints.maxWidth * 0.8;
      const maxWidth = 600.0;

      return ConstrainedBox(
        constraints: BoxConstraints(maxWidth: min(maxWidth, minWidth)),
        child: ReactiveTextField<String>(
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
        ),
      );
    });
  }
}
