import 'dart:convert';

import 'package:code_assesment/data/datasources/local_data_source.dart';
import 'package:code_assesment/data/helpers/failure.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/domain/repositories/gilded_rose_repository.dart';
import 'package:dartz/dartz.dart';

/// Implements [GildedRoseRepository], requires a [LocalDataSource]
class GildedRoseRepositoryImpl implements GildedRoseRepository {
  final LocalDataSource localDataSource;

  GildedRoseRepositoryImpl({required this.localDataSource});

  /// [getGildedRoseData] requires a `fileName` then makes a call to the `LocalDataSource`
  /// Returns a [GildedRoseModel]
  @override
  Future<Either<Failure, GildedRoseModel>> getGildedRoseData({required String fileName}) async {
    try {
      final result = await localDataSource.get(fileName: fileName);
      final GildedRoseModel gildedRoseData = GildedRoseModel.fromJson(jsonDecode(result));
      return Right(gildedRoseData);
    } catch (e) {
      return Left(FetchDataFailure(e.toString()));
    }
  }
}
