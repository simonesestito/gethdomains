import 'package:flutter/material.dart';
import 'package:gethdomains/bloc/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeModeIconButton extends StatelessWidget {
  const ThemeModeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeBrightness = context.watch<ThemeCubit>().state;

    return PopupMenuButton(
      icon: _getIcon(themeBrightness),
      itemBuilder: (context) => _getBrightnessOptions(context),
      onSelected: (ThemeBrightness value) {
        context.read<ThemeCubit>().changeTheme(value);
      },
    );
  }

  List<PopupMenuEntry<ThemeBrightness>> _getBrightnessOptions(
      BuildContext context) {
    return [
      for (final themeBrightness in ThemeBrightness.values)
        PopupMenuItem(
          value: themeBrightness,
          child: Text(_getLocalizedName(context, themeBrightness)),
        ),
    ];
  }

  String _getLocalizedName(
    BuildContext context,
    ThemeBrightness themeBrightness,
  ) =>
      switch (themeBrightness) {
        ThemeBrightness.dark =>
          AppLocalizations.of(context)!.themeBrightnessDark,
        ThemeBrightness.light =>
          AppLocalizations.of(context)!.themeBrightnessLight,
        ThemeBrightness.system =>
          AppLocalizations.of(context)!.themeBrightnessSystem,
      };

  Widget _getIcon(ThemeBrightness themeBrightness) => switch (themeBrightness) {
        ThemeBrightness.dark => const Icon(Icons.dark_mode),
        ThemeBrightness.light => const Icon(Icons.light_mode),
        ThemeBrightness.system => const Icon(Icons.brightness_auto),
      };
}
