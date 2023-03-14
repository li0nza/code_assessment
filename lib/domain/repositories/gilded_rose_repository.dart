import 'package:code_assesment/data/helpers/failure.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:dartz/dartz.dart';

/// Repository providing an interface for a data-layer implementation
/// for fetching the [GildedRoseModel].
abstract class GildedRoseRepository {
  Future<Either<Failure, GildedRoseModel>> getGildedRoseData({required String fileName});
}
