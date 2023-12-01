import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gethdomains/theme.dart';
import 'package:gethdomains/widget/theme_mode_button.dart';

PreferredSizeWidget gethAppBar(BuildContext context, {
  String? title,
  Color? backgroundColor,
  List<Widget>? actions,
}) {
  title ??= AppLocalizations.of(context)!.appName;

  IconThemeData? iconTheme;
  TextStyle? titleTextStyle;
  if (backgroundColor == Colors.transparent) {
    // Use light icons (= as on dark background)
    iconTheme = Theme.of(context).iconTheme.copyWith(
          color: appBarDarkTextColor,
        );
    titleTextStyle = const TextStyle(color: appBarDarkTextColor);
  }

  return AppBar(
    title: Text(title, style: titleTextStyle),
    backgroundColor: backgroundColor,
    iconTheme: iconTheme,
    actions: [
      const ThemeModeIconButton(),
      if (actions != null) ...actions,
    ],
  );
}
