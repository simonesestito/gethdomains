import 'package:gethdomains/bloc/settings/settings_state.dart';
import 'package:gethdomains/model/ipfs_gateway.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

export 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(ipfsGateway: IpfsGateway.ipfsGateways.first));

  void changeIpfsGateway(IpfsGateway ipfsGateway) {
    emit(state.copyWith(ipfsGateway: ipfsGateway));
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) => state.toJson();
}
