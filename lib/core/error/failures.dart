abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = "Server failure"]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = "Cache failure"]) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = "Network failure"]) : super(message);
}