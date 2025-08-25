enum Langs {
  portuguese,
  english,
  italian,
  french,
  spanish;

  String get abbr {
    switch (this) {
      case Langs.portuguese:
        return 'pt-br';
      case Langs.english:
        return 'en';
      case Langs.italian:
        return 'it';
      case Langs.french:
        return 'fr';
      case Langs.spanish:
        return 'es';
    }
  }
}
