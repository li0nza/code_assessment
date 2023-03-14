import 'dart:convert';
import 'dart:io';

import 'package:code_assesment/data/helpers/exceptions.dart';
import 'package:code_assesment/data/helpers/failure.dart';
import 'package:code_assesment/data/repositories/gilded_rose_repository_impl.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_gilded_rose_model.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockLocalDataSource mockLocalDataSource;
  late GildedRoseRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = GildedRoseRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  GildedRoseModel tGildedRoseModel = TestGildedRoseModel.tGildedRoseModel;

  group('Get GildedRoseModel', () {
    test(
      'Should return a String that parses into a GildedRoseModel when the call to the data source is successful',
      () async {
        // arrange
        when(mockLocalDataSource.get(fileName: 'gilded_rose_data'))
            .thenAnswer((_) async => jsonEncode(tGildedRoseModel.toJson()));

        // act
        final result = await repository.getGildedRoseData(fileName: 'gilded_rose_data');

        // assert
        verify(mockLocalDataSource.get(fileName: 'gilded_rose_data'));
        expect(result, equals(Right(tGildedRoseModel)));
      },
    );

    test(
      'Should return a failure when the file is not found',
      () async {
        // arrange
        when(mockLocalDataSource.get(fileName: 'gilded_rose_dataa')).thenThrow(FetchDataException());

        // act
        final result = await repository.getGildedRoseData(fileName: 'gilded_rose_dataa');

        // assert
        verify(mockLocalDataSource.get(fileName: 'gilded_rose_dataa'));
        expect(
          result.fold(
            (failure) => failure,
            (data) => null,
          ),
          (isA<FetchDataFailure>()),
        );
      },
    );
  });
}
