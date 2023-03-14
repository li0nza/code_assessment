class AppException implements Exception {
  final String _message;
  final String _prefix;

  AppException([this._message = '', this._prefix = '']);

  @override
  String toString() {
    return '$_prefix $_message';
  }
}

/// [FetchDataException] accepts a `message` to be thrown
class FetchDataException extends AppException {
  FetchDataException([String message = 'Unknown FetchDataException']) : super(message, "Error while fetching data: ");
}