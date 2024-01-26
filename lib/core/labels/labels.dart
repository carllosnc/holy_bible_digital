labels(String lang) {
  Map<String, Map<String, String>> content = {
    'en': {
      'chapter': 'Chapter',
      'old testament': 'old testament',
      'new testament': 'new testament',
      'verse': 'Verse',
      'translates': 'Translates',
      'portuguese': 'Portuguese',
      'english': 'English',
      'french': 'French',
      'italian': 'Italian',
      'spanish': 'Spanish',
      'continue': 'Continue',
      'lang changed': 'Language changed to'
    },
    'fr': {
      'chapter': 'Chapitre',
      'old testament': 'ancien testament',
      'new testament': 'nouveau testament',
      'verse': 'Verset',
      'translates': 'Traductions',
      'portuguese': 'Portugais',
      'english': 'Anglais',
      'french': 'Français',
      'italian': 'Italien',
      'spanish': 'Espagnol',
      'continue': 'Continuer',
      'lang changed': 'Langue changée à'
    },
    'it': {
      'chapter': 'Capitolo',
      'old testament': 'vecchio testamento',
      'new testament': 'nuovo testamento',
      'verse': 'Versetto',
      'translates': 'Traduzioni',
      'portuguese': 'Portoghese',
      'english': 'Inglese',
      'french': 'Francese',
      'italian': 'Italiano',
      'spanish': 'Spagnolo',
      'continue': 'Continua',
      'lang changed': 'Lingua cambiata a'
    },
    'es': {
      'chapter': 'Capítulo',
      'old testament': 'antiguo testamento',
      'new testament': 'nuevo testamento',
      'verse': 'Versículo',
      'translates': 'Traducciones',
      'portuguese': 'Portugués',
      'english': 'Inglés',
      'french': 'Francés',
      'italian': 'Italiano',
      'spanish': 'Español',
      'continue': 'Continuar',
      'lang changed': 'Idioma cambiado a'
    },
    'pt-br': {
      'chapter': 'Capítulo',
      'old testament': 'velho testamento',
      'new testament': 'novo testamento',
      'verse': 'Versículo',
      'translates': 'Traduções',
      'portuguese': 'Português',
      'english': 'Inglês',
      'french': 'Francês',
      'italian': 'Italiano',
      'spanish': 'Espanhol',
      'continue': 'Continuar',
      'lang changed': 'Idioma alterado para'
    }
  };

  return content[lang];
}
