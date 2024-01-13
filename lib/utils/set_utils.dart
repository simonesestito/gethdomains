extension SetUtils<E> on Set<E> {
  void addOrReplace(E element) {
    if (contains(element)) {
      remove(element);
    }
    add(element);
  }

  void addAllOrReplace(Iterable<E> elements) {
    for (final element in elements) {
      addOrReplace(element);
    }
  }
}

extension IterableUtils<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
