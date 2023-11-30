part of 'domain_search_bloc.dart';

sealed class DomainSearchEvent {}

class DomainSearchEventSearch extends DomainSearchEvent {
  final String domainName;

  DomainSearchEventSearch(this.domainName);
}

class DomainSearchEventClear extends DomainSearchEvent {}