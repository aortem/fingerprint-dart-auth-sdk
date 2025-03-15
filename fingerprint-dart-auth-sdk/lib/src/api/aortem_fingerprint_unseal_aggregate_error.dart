// lib/src/core/unseal_aggregate_error.dart

import 'aortem_fingerprint_request_error.dart';


/// Represents an error that occurs when unsealing aggregated response data fails.
class UnsealAggregateError extends RequestError {
  /// Optional additional error details or metadata.
  final dynamic errorData;

  /// Creates an instance of [UnsealAggregateError].
  UnsealAggregateError({
    required String message,
    required int statusCode,
    this.errorData,
  }) : super(message: message, statusCode: statusCode);

  @override
  String toString() {
    var errorString = 'UnsealAggregateError: $message (Status Code: $statusCode)';
    if (errorData != null) {
      errorString += ' | Error Data: $errorData';
    }
    return errorString;
  }
}
