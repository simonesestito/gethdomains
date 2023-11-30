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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: _DomainSearchField(formControlName: _kDomain)),
              const SizedBox(width: 16),
              _DomainSearchButton(onSubmit: onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
