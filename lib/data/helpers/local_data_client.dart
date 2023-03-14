import 'package:code_assesment/data/helpers/exceptions.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// [LocalDataClient] used to fetch data from JSON files on disk
class LocalDataClient {
  LocalDataClient();

  /// `Folder Uri` for the json files, should be moved to `config`.
  final String _folderUri = 'test/data/dummy_data/';

  /// [get] uses `rootBundle` to do a file read at `_folderUri` + `filename`
  ///
  /// [String] is returned, or [FetchDataException] if the file is not found
  Future<String> get({required String fileName}) async {
    final String fileUri = '$_folderUri$fileName.json';
    try {
      final String dummyString = await rootBundle.loadString(fileUri);
      return dummyString;
    } catch (e) {
      throw FetchDataException('Error occured while fetching data from $fileUri');
    }
  }
}
