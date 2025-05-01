extension EmptyAsNullExtension on String {
  String? get emptyAsNull => isEmpty ? null : this;
}
