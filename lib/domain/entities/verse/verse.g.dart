// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Verse _$VerseFromJson(Map<String, dynamic> json) => Verse(
      title: json['title'] as String,
      content: json['content'] as String,
      folderId: json['folderId'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$VerseToJson(Verse instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'folderId': instance.folderId,
    };
