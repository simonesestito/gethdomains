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
      color: color.withOpacity(0.3),
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
