import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/domain/domain.dart';

class BibleRepository {
  Future<Bible> readBibleJson() async {
    final input = await rootBundle.loadString('./assets/data/bible_pt-br.json');

    final bibleJson = json.decode(input);

    final bible = Bible.fromJson(bibleJson);

    return bible;
  }
}
