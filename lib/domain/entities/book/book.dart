class Book {
  String abbrev;
  List<List<String>> chapters;
  String name;

  Book({
    required this.abbrev,
    required this.chapters,
    required this.name,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    abbrev: json['abbrev'] as String,
    chapters: (json['chapters'] as List<dynamic>).map((e) => (e as List<dynamic>).map((e) => e as String).toList()).toList(),
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'abbrev': abbrev,
    'chapters': chapters,
    'name': name,
  };
}
