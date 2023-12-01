import 'package:flutter/widgets.dart';

extension ColumnGap on List<Widget> {
  List<Widget> withColumnGap([double gap = 16.0]) {
    final widgets = <Widget>[];
    for (var i = 0; i < length; i++) {
      widgets.add(this[i]);
      if (i < length - 1) {
        widgets.add(SizedBox(height: gap));
      }
    }
    return widgets;
  }
}
