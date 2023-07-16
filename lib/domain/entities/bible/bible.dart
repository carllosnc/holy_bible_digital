import 'package:json_annotation/json_annotation.dart';
import '/domain/domain.dart';

part 'bible.g.dart';

@JsonSerializable(explicitToJson: true)
class Bible {
  List<Book> books;

  Bible({required this.books});

  factory Bible.fromJson(Map<String, dynamic> json) => _$BibleFromJson(json);

  Map<String, dynamic> toJson() => _$BibleToJson(this);
}
