import 'package:data_encoder/data_encoder.dart';
import 'package:oracle/domain_type.dart';

class EventDecoder {
  final _ipfsCidEncoder = const IpfsCidEncoder();
  final _torAddressEncoder = const TorAddressEncoder();
  
  const EventDecoder();

  // TODO: Event decodeFromSmartContractEvent(ContractEvent smartContractEvent) {}
}

class Event {
  final BigInt domainId;
  final DomainType type;
  final String domainPointer;

  const Event({
    required this.domainId,
    required this.type,
    required this.domainPointer,
  });
}
