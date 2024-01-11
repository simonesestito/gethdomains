import 'package:flutter/material.dart';

class LoadingFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final ResultWidgetBuilder<T> builder;
  final Widget Function(BuildContext) loadingBuilder;
  final Widget Function(BuildContext, Exception) errorBuilder;

  const LoadingFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.errorBuilder = _defaultErrorBuilder,
    this.loadingBuilder = _defaultLoadingBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return errorBuilder(context, snapshot.error as Exception);
          }

          if (snapshot.hasData) {
            return builder(context, snapshot.data as T);
          }

          return loadingBuilder(context);
        });
  }

  static Widget _defaultLoadingBuilder(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  static Widget _defaultErrorBuilder(BuildContext context, Exception error) {
    return _defaultLoadingBuilder(context);
  }
}

typedef ResultWidgetBuilder<T> = Widget Function(
    BuildContext context, T result);
