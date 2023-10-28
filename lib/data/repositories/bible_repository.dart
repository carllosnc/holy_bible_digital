import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import '/domain/domain.dart';

Future<Bible> readBibleJson(String lang) async {
  // read gzipped file
  final input = await rootBundle.load('assets/data/bible_$lang.gz');

  // convert to bytes and decode
  final bytes = GZipCodec().decoder.convert(input.buffer.asUint8List());

  // convert to json and decode
  final jsonDecoded = json.decode(utf8.decode(bytes));

  Bible bible = Bible.fromJson(jsonDecoded);

  return bible;
}
