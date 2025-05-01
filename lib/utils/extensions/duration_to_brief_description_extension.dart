extension DurationToBriefDescriptionExtension on Duration {
  (int quantity, String unit) get description {
    if (inHours case var hours && > 0) {
      return (hours, "hr");
    }

    if (inMinutes case var minutes && > 0) {
      return (minutes, "min");
    }

    if (inSeconds case var seconds && > 0) {
      return (seconds, "s");
    }

    if (inMilliseconds case var ms && > 0) {
      return (ms, "ms");
    }

    if (inMicroseconds case var us && > 0) {
      return (us, "μs");
    }

    return (0, "");
  }
}
