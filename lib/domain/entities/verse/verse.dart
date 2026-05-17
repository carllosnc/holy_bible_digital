class Verse {
  int? id;
  String title;
  String content;
  String? folderId;

  Verse({
    required this.title,
    required this.content,
    this.folderId,
    this.id,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
    title: json['title'] as String,
    content: json['content'] as String,
    folderId: json['folderId'] as String?,
    id: json['id'] as int?,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'title': title,
    'content': content,
    'folderId': folderId,
  };
}
