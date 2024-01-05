import 'package:flutter/material.dart';

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
      elevation: 0,
      // Otherwise, background is not transparent
      color: color.withAlpha(backgroundAlpha),
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
}
