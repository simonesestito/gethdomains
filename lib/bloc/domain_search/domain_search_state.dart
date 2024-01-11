part of 'domain_search_bloc.dart';

sealed class DomainSearchState {
  const DomainSearchState();
}

class DomainSearchStateInitial extends DomainSearchState {
  const DomainSearchStateInitial();
}

class DomainSearchStateLoading extends DomainSearchState {
  const DomainSearchStateLoading();
}

class DomainSearchStateNoResults extends DomainSearchState {
  final String domainName;

  const DomainSearchStateNoResults(this.domainName);
}

class DomainSearchStateSuccess extends DomainSearchState {
  final Domain domainSearchResult;

  const DomainSearchStateSuccess(this.domainSearchResult);
}

class DomainSearchStateError extends DomainSearchState {
  final String errorMessage;
  final String? domainName;

  const DomainSearchStateError({
    required this.errorMessage,
    this.domainName,
  });
}