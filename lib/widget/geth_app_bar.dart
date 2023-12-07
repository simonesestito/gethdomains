import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/widget/action_buttons/theme_mode_button.dart';

PreferredSizeWidget gethAppBar(BuildContext context, {
  String? title,
  Color? backgroundColor,
  List<Widget>? actions,
}) {
  title ??= AppLocalizations.of(context)!.appName;

  return AppBar(
    title: Text(title),
    backgroundColor: backgroundColor,
    actions: [
      const ThemeModeIconButton(),
      if (actions != null) ...actions,
    ],
  );
}
