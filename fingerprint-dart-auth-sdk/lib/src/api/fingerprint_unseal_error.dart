import 'fingerprint_request_error.dart';

/// A custom exception for errors occurring during the unsealing of a single sealed data element.
class UnsealError implements RequestError {
  /// A human-readable description of the unsealing error.
  @override
  final String message;

  /// The HTTP status code (defaulting to 400).
  @override
  final int statusCode;

  /// Optional additional details or metadata about the error.
  @override
  final dynamic errorData;

  /// Creates an `UnsealError` instance with a message and optional error details.
  UnsealError({
    required this.message,
    this.statusCode = 400, // Default status code
    this.errorData,
  });

  @override
  String toString() {
    var errorString = 'UnsealError: $message (Status Code: $statusCode)';
    if (errorData != null) {
      errorString += ' | Details: $errorData';
    }
    return errorString;
  }
}
