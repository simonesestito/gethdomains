part of 'domains_bloc.dart';

sealed class DomainsEvent {
  const DomainsEvent();
}

/// Used only by the bloc to update the domains
class _UpdateDomainsEvent extends DomainsEvent {
  final List<Domain>? domains;

  const _UpdateDomainsEvent({required this.domains});
}

class LoadDomainsEvent extends DomainsEvent {
  const LoadDomainsEvent();
}

class PurchaseDomainEvent extends DomainsEvent {
  final String domainName;
  final String pointedAddress;
  final DomainType domainType;

  const PurchaseDomainEvent({
    required this.domainName,
    required this.pointedAddress,
    required this.domainType,
  });
}