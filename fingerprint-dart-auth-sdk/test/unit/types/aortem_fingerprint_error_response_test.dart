import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_error_response.dart';

void main() {
  group('DefaultErrorResponse', () {
    test('should create an instance with given values', () {
      final errorResponse = DefaultErrorResponse(
        status: 400,
        error: 'bad_request',
        message: 'Invalid input parameters',
      );

      expect(errorResponse.status, equals(400));
      expect(errorResponse.error, equals('bad_request'));
      expect(errorResponse.message, equals('Invalid input parameters'));
    });

    test('should create an instance from JSON', () {
      final Map<String, dynamic> json = {
        'status': 404,
        'error': 'not_found',
        'message': 'Resource not found',
      };

      final errorResponse = DefaultErrorResponse.fromJson(json);

      expect(errorResponse.status, equals(404));
      expect(errorResponse.error, equals('not_found'));
      expect(errorResponse.message, equals('Resource not found'));
    });

    test('should throw an error when required fields are missing', () {
      final Map<String, dynamic> json = {'status': 500};

      expect(() => DefaultErrorResponse.fromJson(json), throwsArgumentError);
    });

    test('should correctly convert to JSON', () {
      final errorResponse = DefaultErrorResponse(
        status: 401,
        error: 'unauthorized',
        message: 'Access is denied',
      );

      final json = errorResponse.toJson();
      expect(json, {
        'status': 401,
        'error': 'unauthorized',
        'message': 'Access is denied',
      });
    });

    test('should return a valid JSON string from toString()', () {
      final errorResponse = DefaultErrorResponse(
        status: 403,
        error: 'forbidden',
        message: 'You do not have permission',
      );

      final jsonString = errorResponse.toString();
      expect(jsonString,
          '{"status":403,"error":"forbidden","message":"You do not have permission"}');
    });
  });
}
