extension BatchExtension<T> on Iterable<T> {
  Iterable<List<T>> batch(int numberOfElementPerBatch) sync* {
    Iterator<T> iter = iterator;
    List<T> values = [];
    while (iter.moveNext()) {
      values.add(iter.current);

      if (values.length == numberOfElementPerBatch) {
        yield values;
        values = [];
      }
    }

    if (values.length <= numberOfElementPerBatch) {
      yield values;
      values = [];
    }
  }
}
