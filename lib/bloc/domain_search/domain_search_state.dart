part of 'domain_search_bloc.dart';

sealed class DomainSearchState {}

class DomainSearchStateInitial extends DomainSearchState {}

class DomainSearchStateLoading extends DomainSearchState {}

class DomainSearchStateNoResults extends DomainSearchState {}

class DomainSearchStateSuccess extends DomainSearchState {
  final Domain domainSearchResult;

  DomainSearchStateSuccess(this.domainSearchResult);
}

class DomainSearchStateError extends DomainSearchState {
  final String errorMessage;

  DomainSearchStateError(this.errorMessage);
}