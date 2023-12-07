part of 'domains_bloc.dart';

sealed class DomainsState {
  const DomainsState();
}

class LoadingDomainsState extends DomainsState {
  const LoadingDomainsState();
}

class DomainsStateData extends DomainsState {
  final List<Domain> domains;

  const DomainsStateData(this.domains);
}

class UnavailableDomainsState extends DomainsState {
  const UnavailableDomainsState();
}
