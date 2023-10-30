import 'package:meta/meta.dart';

class ApiClientException implements Exception {
  final int statusCode;
  final String message;

  ApiClientException({
    @required this.statusCode,
    @required this.message,
  });
}
