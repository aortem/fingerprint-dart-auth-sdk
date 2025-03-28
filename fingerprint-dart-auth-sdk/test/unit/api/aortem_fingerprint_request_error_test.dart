import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/api/aortem_fingerprint_request_error.dart';

void main() {
  group('RequestError Tests', () {
    test('should create an instance with correct values', () {
      final error = RequestError(
        message: 'Unauthorized',
        statusCode: 401,
        errorData: {'error': 'Invalid API key'},
      );

      expect(error.message, equals('Unauthorized'));
      expect(error.statusCode, equals(401));
      expect(error.errorData, isNotNull);
      expect(error.errorData, containsPair('error', 'Invalid API key'));
    });

    test('should allow creating an error without additional errorData', () {
      final error = RequestError(
        message: 'Not Found',
        statusCode: 404,
      );

      expect(error.message, equals('Not Found'));
      expect(error.statusCode, equals(404));
      expect(error.errorData, isNull);
    });

    test('should correctly convert to string', () {
      final error = RequestError(
        message: 'Internal Server Error',
        statusCode: 500,
        errorData: {'reason': 'Database connection failed'},
      );

      expect(
        error.toString(),
        equals(
          'RequestError: Internal Server Error (Status Code: 500, Error Data: {reason: Database connection failed})',
        ),
      );
    });

    test('should handle errorData being null gracefully', () {
      final error = RequestError(
        message: 'Bad Request',
        statusCode: 400,
      );

      expect(
        error.toString(),
        equals('RequestError: Bad Request (Status Code: 400, Error Data: N/A)'),
      );
    });
  });
}
