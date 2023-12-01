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

    return AppReactiveTextField<String>(
      formControlName: DomainSearchForm._kDomain,
      hintText: AppLocalizations.of(context)!.domainsSearchInputHint,
      onChanged: (_) => domainSearchBloc.clear(),
      onSubmit: (_) {
        // Triggered when the user presses Enter on the keyboard
        onSubmit();
      },
    );
  }
}
