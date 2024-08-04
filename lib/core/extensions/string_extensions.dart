extension StringExtension on String {
  String pluralize(int number) {
    if (number > 1) {
      return '${this}s';
    } else {
      return this;
    }
  }

  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
