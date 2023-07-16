// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bible _$BibleFromJson(Map<String, dynamic> json) => Bible(
      books: (json['books'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibleToJson(Bible instance) => <String, dynamic>{
      'books': instance.books.map((e) => e.toJson()).toList(),
    };
