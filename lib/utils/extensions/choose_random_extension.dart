import "dart:math";

extension ChooseRandomExtension<T> on List<T> {
  /// Returns a random element from the list.
  T chooseRandom() {
    if (isEmpty) {
      throw Exception("Cannot choose a random element from an empty list");
    }

    return this[Random().nextInt(length)];
  }
}
