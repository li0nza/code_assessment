import 'dart:convert';
import 'dart:io';

import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_gilded_rose_model.dart';

Future<void> main() async {

  GildedRoseModel tGildedRoseModel = TestGildedRoseModel.tGildedRoseModel;

  group('From json', () {
    test(
      'Should return a valid model from json',
      () async {
        final File dummyJsonFile = File('test/data/dummy_data/gilded_rose_data.json');
        final Map<String, dynamic> jsonMap = jsonDecode(dummyJsonFile.readAsStringSync());

        final result = GildedRoseModel.fromJson(jsonMap);

        expect(result, equals(tGildedRoseModel));
      },
    );
  });
}
