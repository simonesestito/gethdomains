part of 'sepolia_bloc.dart';

class SepoliaState {
  final bool isUsingSepolia;

  const SepoliaState({required this.isUsingSepolia});

  factory SepoliaState.ok() => const SepoliaState(isUsingSepolia: true);

  factory SepoliaState.notOk() => const SepoliaState(isUsingSepolia: false);
}
