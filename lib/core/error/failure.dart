abstract class Failure {
  final String message;
  const Failure(this.message);

  // Getter untuk title
  String get title;

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});

  @override
  String get title => 'Server Error';
  @override
  String toString() {
    if (statusCode != null) {
      return '($statusCode) $message';
    }
    return message;
  }
}

class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure(super.message, {this.statusCode});

  @override
  String get title => 'Network Error';
  @override
  String toString() {
    if (statusCode != null) {
      return '($statusCode) $message';
    }
    return message;
  }
}

class CacheFailure extends Failure {
  final int? statusCode;
  const CacheFailure(super.message, {this.statusCode});

  @override
  String get title => 'Cache Error';
  @override
  String toString() {
    if (statusCode != null) {
      return '($statusCode) $message';
    }
    return message;
  }
}
