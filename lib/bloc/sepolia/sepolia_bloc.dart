import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gethdomains/service/sepolia_detector.dart';

part 'sepolia_event.dart';
part 'sepolia_state.dart';

class SepoliaNetworkBloc extends Bloc<SepoliaChangeEvent, SepoliaState> {
  final SepoliaNetworkDetector sepoliaNetworkDetector;

  SepoliaNetworkBloc({required this.sepoliaNetworkDetector})
      : super(SepoliaState.ok()) {
    on<SepoliaChangeEventRequest>(_onSwitchToSepolia);
    on<_SepoliaStartDetection>(_detectSepoliaNetwork);

    // Initial load of current state
    add(const _SepoliaStartDetection());
  }

  void switchToSepolia() => add(const SepoliaChangeEventRequest());

  FutureOr<void> _onSwitchToSepolia(
    SepoliaChangeEventRequest event,
    Emitter<SepoliaState> emit,
  ) async {
    final switched = await sepoliaNetworkDetector.useSepoliaNetwork();
    emit(SepoliaState(isUsingSepolia: switched));
  }

  FutureOr<void> _detectSepoliaNetwork(
    _SepoliaStartDetection event,
    Emitter<SepoliaState> emit,
  ) async {
    final isUsingSepolia = await sepoliaNetworkDetector.isSepoliaNetwork();
    emit(SepoliaState(isUsingSepolia: isUsingSepolia));
  }
}
