enum ExceptionType { normal, unAuthorized,canceled }

class ServerException implements Exception {
  final String? message;
  final ExceptionType? exceptionType;

  ServerException({
    this.message = "Something bad Happened please try again later!",
    this.exceptionType = ExceptionType.normal,
  });
}

class CacheException implements Exception {}
