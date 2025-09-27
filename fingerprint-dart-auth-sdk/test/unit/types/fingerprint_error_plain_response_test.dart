import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_error_plain_response.dart';

void main() {
  group('ErrorPlainResponse', () {
    test('should create an instance with given values', () {
      final errorResponse = ErrorPlainResponse(
        status: 404,
        error: 'not_found',
        message: 'Resource not found',
      );

      expect(errorResponse.status, equals(404));
      expect(errorResponse.error, equals('not_found'));
      expect(errorResponse.message, equals('Resource not found'));
    });

    test('should create an instance from JSON', () {
      final Map<String, dynamic> json = {
        'status': 400,
        'error': 'bad_request',
        'message': 'Invalid request parameters',
      };
      final errorResponse = ErrorPlainResponse.fromJson(json);

      expect(errorResponse.status, equals(400));
      expect(errorResponse.error, equals('bad_request'));
      expect(errorResponse.message, equals('Invalid request parameters'));
    });

    test('should handle missing fields with default values', () {
      final Map<String, dynamic> json = {};
      final errorResponse = ErrorPlainResponse.fromJson(json);

      expect(errorResponse.status, equals(500));
      expect(errorResponse.error, equals('unknown_error'));
      expect(errorResponse.message, equals('An unexpected error occurred.'));
    });

    test('should convert to JSON correctly', () {
      final errorResponse = ErrorPlainResponse(
        status: 401,
        error: 'unauthorized',
        message: 'Access denied',
      );

      final Map<String, dynamic> json = errorResponse.toJson();
      expect(json, {
        'status': 401,
        'error': 'unauthorized',
        'message': 'Access denied',
      });
    });

    test('should correctly parse JSON from a dynamic Map', () {
      final dynamic jsonRaw = {
        'status': 500,
        'error': 'server_error',
        'message': 'Internal server error',
      };

      // Ensure it converts properly to Map<String, dynamic>
      final Map<String, dynamic> json = Map<String, dynamic>.from(jsonRaw);

      final errorResponse = ErrorPlainResponse.fromJson(json);
      expect(errorResponse.status, equals(500));
      expect(errorResponse.error, equals('server_error'));
      expect(errorResponse.message, equals('Internal server error'));
    });
  });
}
