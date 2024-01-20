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

class SellDomainEvent extends DomainsEvent {
  final String domainName;
  final BigInt price;

  const SellDomainEvent({
    required this.domainName,
    required this.price,
  });
}

class UnlistDomainEvent extends DomainsEvent {
  final String domainName;

  const UnlistDomainEvent({
    required this.domainName,
  });
}

class DomainListedForSaleEvent extends DomainsEvent {
  final String domainName;
  final BigInt price; // Price is zero if the domain is not listed for sale

  const DomainListedForSaleEvent(this.domainName, this.price);
}

// DomainSold is not used by the bloc, because it already updates with the Transfer

class EditDomainEvent extends DomainsEvent {
  final String domainName;
  final String pointedAddress;
  final DomainType domainType;

  const EditDomainEvent({
    required this.domainName,
    required this.pointedAddress,
    required this.domainType,
  });
}