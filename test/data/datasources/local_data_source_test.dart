import 'dart:convert';
import 'dart:io';

import 'package:code_assesment/data/datasources/local_data_source.dart';
import 'package:code_assesment/data/helpers/exceptions.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockLocalDataClient mockLocalDataClient;
  late LocalDataSourceImpl dataSource;

  setUp(() {
    mockLocalDataClient = MockLocalDataClient();
    dataSource = LocalDataSourceImpl(client: mockLocalDataClient);
  });

  group('Local data source tests', () {
    String fileUri = 'test/data/dummy_data/gilded_rose_data.json';
    final String dummyString = File(fileUri).readAsStringSync();
    final tGildedRoseModel = GildedRoseModel.fromJson(
      jsonDecode(dummyString),
    );

    test(
      'Should return a string that parses into a GildedRoseModel when the fetch succeeds',
      () async {
        // arrange
        when(mockLocalDataClient.get(fileName: 'gilded_rose_data')).thenAnswer(
          (_) async => dummyString,
        );

        // act
        final result = await dataSource.get(fileName: 'gilded_rose_data');

        // assert
        expect(GildedRoseModel.fromJson(jsonDecode(result)), equals(tGildedRoseModel));
      },
    );

    test(
      'Should throw a [FetchDataException] when the file is not found',
      () async {
        // arrange
        when(
          mockLocalDataClient.get(fileName: 'asdf'),
        ).thenThrow(
          (_) async => throw FetchDataException(),
        );

        // act
        final call = dataSource.get(fileName: 'asdf');

        // assert
        expect(() => call, throwsA(isA<FetchDataException>()));
      },
    );
  });
}
