part of 'domain_search.dart';

class DomainSearchForm extends StatelessWidget {
  static const _kDomain = 'domain';

  final DomainSearchCallback onSubmit;

  final form = FormGroup({
    _kDomain: FormControl<String>(
      validators: [
        Validators.required,
        DomainInputValidator(),
        Validators.minLength(3+'.eth'.length),
      ],
    ),
  });

  DomainSearchForm({required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _DomainSearchField(formControlName: _kDomain),
          const SizedBox(width: 16),
          _DomainSearchButton(onSubmit: onSubmit),
        ],
      ),
    );
  }
}
