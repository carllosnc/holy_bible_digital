import '/domain/domain.dart';

class BibleService {
  static final BibleService _bibleService = BibleService._internal();

  factory BibleService() {
    return _bibleService;
  }

  BibleService._internal();

  Bible bible = Bible(books: []);
}
