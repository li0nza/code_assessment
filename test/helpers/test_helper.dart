import 'package:code_assesment/data/datasources/local_data_source.dart';
import 'package:code_assesment/data/helpers/local_data_client.dart';
import 'package:code_assesment/domain/repositories/gilded_rose_repository.dart';
import 'package:code_assesment/domain/usecases/get_gilded_rose_data.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GildedRoseRepository,
  GetGildedRoseData,
  LocalDataSource,
  LocalDataClient,
])
void main() {}
