// lib/src/core/request_error.dart

/// A custom exception for handling errors during API requests.
class RequestError implements Exception {
  /// A human-readable error message.
  final String message;

  /// The HTTP status code returned by the API.
  final int statusCode;

  /// Optional additional error data provided by the API.
  final dynamic errorData;

  /// Creates an instance of [RequestError].
  RequestError({
    required this.message,
    required this.statusCode,
    this.errorData,
  });

  @override
  String toString() {
    return 'RequestError: $message (Status Code: $statusCode, Error Data: ${errorData ?? 'N/A'})';
  }
}
