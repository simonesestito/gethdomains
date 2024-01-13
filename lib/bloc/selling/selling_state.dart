part of 'selling_bloc.dart';

sealed class SellingState {
  const SellingState();
}

class SellingLoading extends SellingState {
  const SellingLoading();
}

class SellingError extends SellingState {
  const SellingError();
}

class SellingData extends SellingState {
  final List<Domain> domains;
  final Set<Domain> loadingDomains;

  const SellingData({
    required this.domains,
    required this.loadingDomains,
  });

  factory SellingData.fromDomainsSet({
    required Set<Domain> domains,
    required Set<Domain> loadingDomains,
  }) {
    return SellingData(
      domains: domains.toList(),
      loadingDomains: loadingDomains,
    );
  }
}
