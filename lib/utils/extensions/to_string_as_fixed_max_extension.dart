extension ToStringAsFixedMaxExtension on num {
  String toStringAsFixedMax(int fractionDigits) {
    var string = toStringAsFixed(fractionDigits).split("");
    var r = string.length - 1;
    while (string.length - r >= 0 && string[r] == "0") {
      r--;
    }

    if (string[r] == ".") {
      r--;
    }

    return string.sublist(0, r + 1).join("");
  }
}
