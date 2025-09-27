import 'aortem_fingerprint_request_error.dart';

/// Represents an error that occurs when unsealing aggregated response data fails.
class UnsealAggregateError extends RequestError {
  /// Creates an instance of [UnsealAggregateError].
  UnsealAggregateError({
    required super.message,
    required super.statusCode,
    super.errorData, // Pass errorData to the parent class
  });

  @override
  String toString() {
    var errorString =
        'UnsealAggregateError: $message (Status Code: $statusCode)';
    if (errorData != null) {
      errorString += ' | Error Data: $errorData';
    }
    return errorString;
  }
}
