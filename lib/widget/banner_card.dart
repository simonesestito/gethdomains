import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Widget content;

  const BannerCard({
    Key? key,
    required this.color,
    required this.icon,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Otherwise, background is not transparent
      color: color.withAlpha(80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 16),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
