enum Langs {
  english,
  italian,
  french,
  portuguese,
  spanish;

  String get abbr {
    switch (this) {
      case Langs.english:
        return 'en';
      case Langs.italian:
        return 'it';
      case Langs.french:
        return 'fr';
      case Langs.portuguese:
        return 'pt';
      case Langs.spanish:
        return 'es';
      default:
        return 'ptBr';
    }
  }
}
