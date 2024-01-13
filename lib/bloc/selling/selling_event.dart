part of 'selling_bloc.dart';

sealed class SellingEvent {
  const SellingEvent();
}

class SellingLoad extends SellingEvent {
  const SellingLoad();
}

class SellingBuy extends SellingEvent {
  final Domain domain;

  const SellingBuy({
    required this.domain,
  });
}

class SellingBought extends SellingEvent {
  final Domain domain;

  const SellingBought({
    required this.domain,
  });
}

class SellingListed extends SellingEvent {
  final Domain domain;

  const SellingListed({
    required this.domain,
  });
}
