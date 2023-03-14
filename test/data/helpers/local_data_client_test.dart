import 'dart:io';

import 'package:code_assesment/data/helpers/exceptions.dart';
import 'package:code_assesment/data/helpers/local_data_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockLocalDataClient extends Mock implements LocalDataClient {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late LocalDataClient localDataClient;
  late MockLocalDataClient mockLocalDataClient;

  setUp(() {
    mockLocalDataClient = MockLocalDataClient();
    localDataClient = LocalDataClient();
  });

  group('Local data client tests', () {
    final String dummyString =
        File('test/data/dummy_data/gilded_rose_data.json').readAsStringSync();

    test(
      'Should return a json string when the file is opened and read',
      () async {
        // arrange
        when(() => mockLocalDataClient.get(fileName: 'gilded_rose_data'))
            .thenAnswer((_) async => dummyString);

        // act
        final result = await localDataClient.get(fileName: 'gilded_rose_data');

        // assert
        expect(result == dummyString, true);
      },
    );

    test(
      'Should return a [FetchDataException] if the file is not found',
      () async {
        // arrange
        when(() => mockLocalDataClient.get(fileName: 'gilded_rose_dataa'))
            .thenThrow(FetchDataException());

        // act and assert
        expect(() async => await localDataClient.get(fileName: 'gilded_rose_dataa'),
            throwsA(isA<FetchDataException>()));
      },
    );
  });
}
