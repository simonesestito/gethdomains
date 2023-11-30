part of 'domain_search.dart';

class DomainSearchForm extends StatelessWidget {
  static const _kDomain = 'domain';

  final DomainSearchCallback onSubmit;
  final DomainSearchCallback onRegister;

  final form = FormGroup({
    _kDomain: FormControl<String>(
      validators: [
        Validators.required,
        DomainInputValidator(),
        Validators.minLength(3 + '.eth'.length),
      ],
    ),
  });

  DomainSearchForm({
    required this.onSubmit,
    required this.onRegister,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: _DomainSearchField(
                    formControlName: _kDomain,
                    onSubmit: _onFormSubmit,
                  )),
                  const SizedBox(width: 16),
                  _DomainSearchButton(
                    onSubmit: _onFormSubmit,
                    onRegister: _onRegistrationRequest,
                  ),
                ],
              ),
              const SizedBox(width: 16),
              const DomainSearchErrorBanner(),
            ],
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() {
    form.markAllAsTouched();
    if (form.valid) {
      onSubmit(form.control(_kDomain).value);
    }
  }

  void _onRegistrationRequest() {
    if (form.valid) {
      onRegister(form.control(_kDomain).value);
    }
  }
}
