extension TitleCaseExtension on String {
  String toTitleCase() =>
      split(" ").map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase()).join(" ");
}
