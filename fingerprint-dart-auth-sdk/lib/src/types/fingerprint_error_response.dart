import 'dart:convert';

/// Abstract class representing a standardized error response.
abstract class ErrorResponse {
  /// The HTTP status code of the error response.
  int get status;

  /// A short error code or summary.
  String get error;

  /// A detailed human-readable error message.
  String get message;

  /// Converts the error response into a JSON object.
  Map<String, dynamic> toJson();

  /// String representation of the error response.
  @override
  String toString() => jsonEncode(toJson());
}

/// A concrete implementation of [ErrorResponse].
class DefaultErrorResponse implements ErrorResponse {
  @override
  final int status;

  @override
  final String error;

  @override
  final String message;

  /// Constructor for [DefaultErrorResponse].
  DefaultErrorResponse({
    required this.status,
    required this.error,
    required this.message,
  });

  /// Factory constructor to create an instance from a JSON object.
  factory DefaultErrorResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('status') ||
        !json.containsKey('error') ||
        !json.containsKey('message')) {
      throw ArgumentError('Missing required error response fields.');
    }

    return DefaultErrorResponse(
      status: json['status'] as int,
      error: json['error'] as String,
      message: json['message'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'status': status, 'error': error, 'message': message};
  }
}
