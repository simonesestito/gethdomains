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
  final Set<String> loadingDomains;

  const SellingData({
    required this.domains,
    required this.loadingDomains,
  });
}
