part of 'domain_search.dart';

class _DomainSearchButton extends StatelessWidget {
  final DomainSearchCallback onSubmit;

  const _DomainSearchButton({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConsumer(
      builder: (context, form, _) => FloatingActionButton.extended(
        onPressed: () {
          form.markAllAsTouched();
          if (form.valid) {
            onSubmit(form.value[DomainSearchForm._kDomain].toString());
          }
        },
        label: const Text('Search'),
        icon: const Icon(Icons.search),
      ),
    );
  }
}
