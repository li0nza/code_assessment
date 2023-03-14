import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/domain/usecases/get_gilded_rose_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_gilded_rose_model.dart';
import '../../helpers/test_helper.mocks.dart';

Future<void> main() async {
  late MockGildedRoseRepository mockGildedRoseRepository;
  late GetGildedRoseData usecase;

  setUp(() {
    mockGildedRoseRepository = MockGildedRoseRepository();
    usecase = GetGildedRoseData(mockGildedRoseRepository);
  });

  GildedRoseModel tGildedRoseModel = TestGildedRoseModel.tGildedRoseModel;

  test(
    'Get GildedRoseModel data from repository',
    () async {
      // arrange
      when(mockGildedRoseRepository.getGildedRoseData(fileName: 'gilded_rose_data')).thenAnswer((_) async => Right(tGildedRoseModel));

      // act
      final result = await usecase.execute(fileName: 'gilded_rose_data');

      // assert
      expect(result, equals(Right(tGildedRoseModel)));
    },
  );
}
