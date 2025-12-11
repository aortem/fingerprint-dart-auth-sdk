import 'dart:convert';

/// Represents a standardized error response from the FingerprintJS Pro API.
class ErrorPlainResponse {
  /// The HTTP status code of the error response.
  final int status;

  /// A short error code or summary.
  final String error;

  /// A human-readable description of the error.
  final String message;

  /// Constructor for [ErrorPlainResponse].
  const ErrorPlainResponse({
    required this.status,
    required this.error,
    required this.message,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory ErrorPlainResponse.fromJson(Map<String, dynamic> json) {
    return ErrorPlainResponse(
      status: json['status'] as int? ?? 500,
      error: json['error'] as String? ?? 'unknown_error',
      message: json['message'] as String? ?? 'An unexpected error occurred.',
    );
  }

  /// Converts the object into a JSON representation.
  Map<String, dynamic> toJson() {
    return {'status': status, 'error': error, 'message': message};
  }

  /// Returns a string representation of the error response.
  @override
  String toString() => jsonEncode(toJson());
}
