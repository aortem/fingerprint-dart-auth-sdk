// lib/src/core/sdk_error.dart

/// A custom exception for internal SDK errors.
class SdkError implements Exception {
  /// A human-readable error message.
  final String message;

  /// An optional error code for categorizing the error.
  final String? code;

  /// Optional additional details about the error (e.g., debug info).
  final dynamic details;

  /// Creates an instance of [SdkError].
  SdkError({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() {
    var errorString = 'SdkError: $message';
    if (code != null) {
      errorString += ' (Code: $code)';
    }
    if (details != null) {
      errorString += ' | Details: $details';
    }
    return errorString;
  }
}
