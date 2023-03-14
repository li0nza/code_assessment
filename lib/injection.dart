import 'package:code_assesment/data/datasources/local_data_source.dart';
import 'package:code_assesment/data/helpers/local_data_client.dart';
import 'package:code_assesment/data/repositories/gilded_rose_repository_impl.dart';
import 'package:code_assesment/domain/repositories/gilded_rose_repository.dart';
import 'package:code_assesment/domain/usecases/get_gilded_rose_data.dart';
import 'package:code_assesment/presentation/bloc/items/gilded_rose_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // cubits
  locator.registerFactory(() => GildedRoseCubit(locator()));

  // use cases
  locator.registerLazySingleton(() => GetGildedRoseData(locator()));

  // repositories
  locator.registerLazySingleton<GildedRoseRepository>(
    () => GildedRoseRepositoryImpl(
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(client: locator()),
  );

  //other
  locator.registerLazySingleton<LocalDataClient>(
    () => LocalDataClient(),
  );
}
