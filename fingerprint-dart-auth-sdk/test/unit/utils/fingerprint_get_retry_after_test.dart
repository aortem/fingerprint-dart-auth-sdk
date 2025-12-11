import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/utils/fingerprint_get_retry_after.dart';

import 'dart:io'; // Update path as needed

void main() {
  group('getRetryAfter tests', () {
    test('should return duration for Retry-After in seconds', () {
      final Map<String, String> headers = {HttpHeaders.retryAfterHeader: '10'};

      final result = getRetryAfter(headers);

      expect(result, equals(Duration(seconds: 10)));
    });

    test('should return duration for Retry-After as a valid HTTP date', () {
      final futureTime = DateTime.now().toUtc().add(Duration(seconds: 30));
      final httpDate = HttpDate.format(futureTime);

      final Map<String, String> headers = {
        HttpHeaders.retryAfterHeader: httpDate,
      };

      final result = getRetryAfter(headers);

      expect(result, isNotNull);
      expect(result!.inSeconds, closeTo(30, 2)); // Allow small time drift
    });

    test('should return null for missing Retry-After header', () {
      final Map<String, String> headers = {}; // No Retry-After header

      final result = getRetryAfter(headers);

      expect(result, isNull);
    });

    test('should return null for invalid Retry-After value', () {
      final Map<String, String> headers = {
        HttpHeaders.retryAfterHeader: 'invalid_value',
      };

      final result = getRetryAfter(headers);

      expect(result, isNull);
    });

    test('should return null if Retry-After date is in the past', () {
      final pastTime = DateTime.now().toUtc().subtract(Duration(seconds: 30));
      final httpDate = HttpDate.format(pastTime);

      final Map<String, String> headers = {
        HttpHeaders.retryAfterHeader: httpDate,
      };

      final result = getRetryAfter(headers);

      expect(result, isNull);
    });
  });
}
