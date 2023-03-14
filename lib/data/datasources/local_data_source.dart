import 'package:code_assesment/data/helpers/exceptions.dart';
import 'package:code_assesment/data/helpers/local_data_client.dart';

abstract class LocalDataSource {
  Future<String> get({required String fileName});
}

class LocalDataSourceImpl implements LocalDataSource {
  // Usually we would require a client to interact with the local DB, but we
  // are just reading data from a json file, so we do that in the get.
  LocalDataClient client;
  LocalDataSourceImpl({required this.client});

  /// Basic [get] used to fetch data from json file.
  ///
  /// Returns a [String], or handles the error if one occurs, throwing a
  /// [FetchDataException]
  @override
  Future<String> get({required String fileName}) async {
    try {
      return client.get(fileName: fileName);
    } catch (_) {
      throw FetchDataException('Error occured while fetching data from $fileName');
    }
  }
}
