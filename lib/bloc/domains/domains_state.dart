part of 'domains_bloc.dart';

sealed class DomainsState {
  const DomainsState();
}

class LoadingDomainsState extends DomainsState {
  const LoadingDomainsState();
}

class DomainsStateData extends DomainsState {
  final List<Domain> domains;
  final Set<String> loadingDomains;

  const DomainsStateData(this.domains, this.loadingDomains);
}

class UnavailableDomainsState extends DomainsState {
  const UnavailableDomainsState();
}
