extension StringFormatting on String {
  String capitalizeFirst() {
    if (isEmpty) return this;

    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get humanized {
    return replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word.capitalizeFirst())
        .join(' ');
  }
}
