class ServerException implements Exception {
  final String errorMessage;
  final num statusCode;
  const ServerException({required this.statusCode, required this.errorMessage});

  @override
  String toString() {
    return 'ServerException(statusCode: $statusCode, errorMessage: $errorMessage)';
  }
}

class DioExceptions implements Exception {
  final String errorMessage;
  final num statusCode;
  const DioExceptions({required this.statusCode, required this.errorMessage});

  @override
  String toString() {
    return 'DioExceptions(statusCode: $statusCode, errorMessage: $errorMessage)';
  }
}

class ParsingException implements Exception {
  final String errorMessage;
  final num statusCode;
  const ParsingException(
      {required this.statusCode, required this.errorMessage});
  @override
  String toString() {
    return 'ParsingException(statusCode: $statusCode, errorMessage: $errorMessage)';
  }
}
