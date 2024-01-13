import 'package:flutter/material.dart';
import 'package:gethdomains/contracts/exceptions.dart';

class BannerCard extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Widget content;
  final Widget? action;
  final int backgroundAlpha;

  const BannerCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.content,
    this.action,
    this.backgroundAlpha = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation must be zero. Otherwise, background is not transparent
      elevation: 0,
      color: _buildMixColors(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: color),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 16),
                Expanded(child: content),
              ],
            ),
          ),
          if (action != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: action,
              ),
            ),
        ],
      ),
    );
  }

  Color _buildMixColors(BuildContext context) => _mixColors(
        color,
        Theme.of(context).scaffoldBackgroundColor,
        backgroundAlpha,
      );

  Color _mixColors(Color color, Color background, int alpha) {
    final alphaPercentage = backgroundAlpha / 255;
    final red =
        (color.red * alphaPercentage + background.red * (1 - alphaPercentage))
            .round();
    final green = (color.green * alphaPercentage +
            background.green * (1 - alphaPercentage))
        .round();
    final blue =
        (color.blue * alphaPercentage + background.blue * (1 - alphaPercentage))
            .round();
    return Color.fromARGB(255, red, green, blue);
  }
}

class ErrorBannerCard extends BannerCard {
  const ErrorBannerCard({
    Key? key,
    required Widget content,
    Widget? action,
  }) : super(
          key: key,
          color: Colors.red,
          icon: const Icon(Icons.error_outline),
          content: content,
          action: action,
        );

  factory ErrorBannerCard.fromWeb3Error(Web3Exception error) {
    return ErrorBannerCard(content: Text(error.getDisplayMessage()));
  }
}
