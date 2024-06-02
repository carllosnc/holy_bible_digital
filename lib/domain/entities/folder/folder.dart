import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable(explicitToJson: true)
class Folder {
  int? id;
  String name;

  Folder({
    this.id,
    required this.name,
  });

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);

  Map<String, dynamic> toJson() => _$FolderToJson(this);
}
