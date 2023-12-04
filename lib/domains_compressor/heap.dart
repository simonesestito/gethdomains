class Heap {
  late final List<int> _heap;

  Heap([Iterable<int>? data]) {
    _heap = data == null ? [] : List<int>.from(data);
    _heapify();
  }

  int? pop() {
    if (_heap.isEmpty) {
      return null;
    }

    final min = _heap[0];
    final last = _heap.removeLast();
    if (_heap.isNotEmpty) {
      _heap[0] = last;
      _innerHeapify(0);
    }

    return min;
  }

  void push(int value) {
    _heap.add(value);

    // Bubble up
    var i = _heap.length - 1;
    while (i > 0 && _heap[i] < _heap[(i - 1) ~/ 2]) {
      final temp = _heap[i];
      _heap[i] = _heap[(i - 1) ~/ 2];
      _heap[(i - 1) ~/ 2] = temp;

      i = (i - 1) ~/ 2;
    }
  }

  void _heapify() {
    for (var i = (_heap.length / 2).floor(); i >= 0; i--) {
      _innerHeapify(i);
    }
  }

  void _innerHeapify(int i) {
    final left = 2 * i + 1;
    final right = 2 * i + 2;

    var smallest = i;
    if (left < _heap.length && _heap[left] < _heap[smallest]) {
      smallest = left;
    }
    if (right < _heap.length && _heap[right] < _heap[smallest]) {
      smallest = right;
    }
    if (smallest != i) {
      final temp = _heap[i];
      _heap[i] = _heap[smallest];
      _heap[smallest] = temp;

      _innerHeapify(smallest);
    }
  }
}
