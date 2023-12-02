import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gethdomains/bloc/settings/ipfs_gateway.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required IpfsGateway ipfsGateway,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
