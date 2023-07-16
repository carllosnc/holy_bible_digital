//extend object string to format book name
extension StringExtension on String {
  String formatNumbers() {
    return replaceAll('1', 'I').replaceAll('2', 'II').replaceAll('3', 'III');
  }

  String adaptName() {
    return replaceAll('Lamentações de Jeremias', 'Lamentações');
  }
}
