part of 'sepolia_bloc.dart';

sealed class SepoliaChangeEvent {
  const SepoliaChangeEvent();
}

class SepoliaChangeEventRequest extends SepoliaChangeEvent {
  const SepoliaChangeEventRequest();
}

class _SepoliaStartDetection extends SepoliaChangeEvent {
  const _SepoliaStartDetection();
}
