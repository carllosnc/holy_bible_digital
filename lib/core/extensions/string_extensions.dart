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

  String formatNumbers() {
    return replaceAll('1', 'I').replaceAll('2', 'II').replaceAll('3', 'III');
  }

  String adaptName() {
    return replaceAll('Lamentações de Jeremias', 'Lamentações');
  }

  String removeDiacritics() {
    return replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('é', 'e')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ç', 'c');
  }
}
