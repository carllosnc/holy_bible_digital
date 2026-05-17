class Folder {
  int? id;
  String name;

  Folder({
    this.id,
    required this.name,
  });

  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
    id: json['id'] as int?,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
  };
}
