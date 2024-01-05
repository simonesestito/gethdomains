import 'package:flutter/material.dart';

class LoadingFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final ResultWidgetBuilder<T> builder;

  const LoadingFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) => snapshot.hasData && snapshot.data != null
          ? builder(context, snapshot.data as T)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

typedef ResultWidgetBuilder<T> = Widget Function(
    BuildContext context, T result);
