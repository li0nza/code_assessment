abstract class Failure {
  final String message;
  const Failure(this.message);
}

class FetchDataFailure extends Failure {
  const FetchDataFailure(String message) : super(message);
}