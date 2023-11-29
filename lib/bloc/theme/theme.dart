import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeBrightness> {
  static const _kBrightness = 'brightness';

  ThemeCubit(super.state);

  @override
  ThemeBrightness? fromJson(Map<String, dynamic> json) =>
      themeBrightnessFromJson(json[_kBrightness]);

  @override
  Map<String, dynamic>? toJson(ThemeBrightness state) => {
        _kBrightness: state.name,
      };

  void changeTheme(ThemeBrightness brightness) => emit(brightness);
}
