part of 'domain_search_bloc.dart';

sealed class DomainSearchEvent {
  const DomainSearchEvent();
}

class DomainSearchEventSearch extends DomainSearchEvent {
  final String domainName;

  const DomainSearchEventSearch(this.domainName);
}

class DomainSearchEventClear extends DomainSearchEvent {
  const DomainSearchEventClear();
}