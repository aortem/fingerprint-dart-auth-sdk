import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/api/aortem_fingerprint_too_many_requests_error.dart';

void main() {
  group('TooManyRequestsError', () {
    test(
      'should correctly store message, statusCode, retryAfter, and errorData',
      () {
        final error = TooManyRequestsError(
          message: 'Rate limit exceeded',
          retryAfter: Duration(seconds: 30),
          errorData: {'limit': 1000, 'remaining': 0},
        );

        expect(error.message, 'Rate limit exceeded');
        expect(error.statusCode, 429);
        expect(error.retryAfter, Duration(seconds: 30));
        expect(error.errorData, {'limit': 1000, 'remaining': 0});
      },
    );

    test('should correctly format toString() with retryAfter', () {
      final error = TooManyRequestsError(
        message: 'Too many requests, try again later',
        retryAfter: Duration(seconds: 60),
      );

      expect(
        error.toString(),
        'TooManyRequestsError: Too many requests, try again later (Status Code: 429) | Retry After: 60 seconds',
      );
    });

    test('should correctly format toString() without retryAfter', () {
      final error = TooManyRequestsError(message: 'Too many requests');

      expect(
        error.toString(),
        'TooManyRequestsError: Too many requests (Status Code: 429)',
      );
    });
  });
}
