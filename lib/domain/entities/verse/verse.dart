import 'package:json_annotation/json_annotation.dart';

part 'verse.g.dart';

@JsonSerializable(explicitToJson: true)
class Verse {
  String title;
  String content;

  Verse({
    required this.title,
    required this.content,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => _$VerseFromJson(json);

  Map<String, dynamic> toJson() => _$VerseToJson(this);
}
