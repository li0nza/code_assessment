import 'package:code_assesment/data/helpers/failure.dart';
import 'package:code_assesment/domain/entities/gilded_rose_model.dart';
import 'package:code_assesment/domain/repositories/gilded_rose_repository.dart';
import 'package:dartz/dartz.dart';

/// Usecase that interacts with the [GildedRoseRepository], used to fetch a [GildedRoseModel]
class GetGildedRoseData {
  final GildedRoseRepository repository;

  GetGildedRoseData(this.repository);

  Future<Either<Failure, GildedRoseModel>> execute({required String fileName}) {
    return repository.getGildedRoseData(fileName: fileName);
  }
}
