import 'package:flutter/material.dart';

class LoadingFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final ResultWidgetBuilder<T> builder;
  final Widget Function(BuildContext, Exception)? errorBuilder;

  const LoadingFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError && errorBuilder != null) {
            return errorBuilder!(context, snapshot.error as Exception);
          }

          if (snapshot.hasData) {
            return builder(context, snapshot.data as T);
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}

typedef ResultWidgetBuilder<T> = Widget Function(
    BuildContext context, T result);
