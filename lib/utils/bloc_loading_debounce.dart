Future<T> delayLoading<T>({
  required Future<T> Function() action,
  required void Function() emitLoading,
  Duration duration = const Duration(milliseconds: 500),
}) async {
  // Start the action, then:
  // - if after the duration the action is still running, emit the loading state
  // - if the action finishes before the duration, do nothing and return the result

  // Start the action
  bool isActionDone = false;
  final actionFuture = action().whenComplete(() {
    isActionDone = true;
  });

  // Wait for the duration
  final waitFuture = Future.delayed(duration);
  await Future.any([actionFuture, waitFuture]);

  // At this point, either the action is done or the wait is done
  if (!isActionDone) {
    // If the action is not done, emit the loading state and wait for the action
    emitLoading();
  }
  
  return actionFuture;
}
