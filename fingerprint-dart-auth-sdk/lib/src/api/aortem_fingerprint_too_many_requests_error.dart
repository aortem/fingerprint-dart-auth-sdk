import 'aortem_fingerprint_request_error.dart';

/// A custom exception for handling HTTP 429 Too Many Requests errors.
class TooManyRequestsError implements RequestError {
  /// A human-readable error message.
  @override
  final String message;

  /// The HTTP status code (should be 429).
  @override
  final int statusCode;

  /// Optional duration indicating how long to wait before retrying.
  final Duration? retryAfter;

  /// Optional additional error data (inherited from RequestError).
  @override
  final dynamic errorData;

  /// Creates an instance of [TooManyRequestsError].
  TooManyRequestsError({
    required this.message,
    this.statusCode = 429,
    this.retryAfter,
    this.errorData, // Ensure errorData is included
  });

  @override
  String toString() {
    var errorString = 'TooManyRequestsError: $message (Status Code: $statusCode)';
    if (retryAfter != null) {
      errorString += ' | Retry After: ${retryAfter!.inSeconds} seconds';
    }
    return errorString;
  }
}
