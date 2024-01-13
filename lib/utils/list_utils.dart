import 'package:gethdomains/model/domain.dart';

extension DomainsListUtils on List<Domain> {
  void addOrReplace(Domain element) {
    final index = indexWhere((e) => e.domainName == element.domainName);
    if (index == -1) {
      add(element);
    } else {
      this[index] = element;
    }
  }

  void addAllOrReplace(Iterable<Domain> elements) {
    for (final element in elements) {
      addOrReplace(element);
    }
  }
}
