part of 'domain_search.dart';

class _DomainSearchField extends StatelessWidget {
  final String formControlName;
  final Function() onSubmit;

  const _DomainSearchField({
    required this.formControlName,
    required this.onSubmit,
  });

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
      ),
      validationMessages: DomainInputValidator.getValidationMessages(context),
      onChanged: (value) => domainSearchBloc.clear(),
      onEditingComplete: (form) {
        // Triggered when the user presses Enter on the keyboard
        debugPrint(
            'Editing complete for $formControlName with value "${form.value}"');
        onSubmit();
      },
    );
  }
}
