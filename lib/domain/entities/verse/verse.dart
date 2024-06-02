import 'package:json_annotation/json_annotation.dart';

part 'verse.g.dart';

@JsonSerializable(explicitToJson: true)
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

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

  Map<String, dynamic> toJson() => _$VerseToJson(this);
}
