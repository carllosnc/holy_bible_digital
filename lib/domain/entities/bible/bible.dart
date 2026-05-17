import '/domain/domain.dart';

class Bible {
  List<Book> books;
  String lang;

  Bible({required this.books, required this.lang});

  factory Bible.fromJson(Map<String, dynamic> json) => Bible(
    books: (json['books'] as List<dynamic>).map((e) => Book.fromJson(e as Map<String, dynamic>)).toList(),
    lang: json['lang'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'books': books.map((e) => e.toJson()).toList(),
    'lang': lang,
  };
}
