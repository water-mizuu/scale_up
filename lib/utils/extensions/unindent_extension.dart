extension UnindentExtension on String {
  String unindent() {
    final lines = split("\n");
    final minIndent = lines
        .skip(1)
        .where((line) => line.isNotEmpty)
        .map((line) => line.length - line.trimLeft().length)
        .reduce((a, b) => a < b ? a : b);

    return lines
        .map((line) => line.length < minIndent ? line : line.substring(minIndent))
        .join("\n");
  }
}
