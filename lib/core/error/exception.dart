class DataException implements Exception {}

class ServerException implements Exception {
  final String message;

  ServerException({
    required this.message,
  });

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException({
    required this.message,
  });

  @override
  String toString() => message;
}
