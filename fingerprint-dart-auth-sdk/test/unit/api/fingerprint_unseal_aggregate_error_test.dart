import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/api/fingerprint_unseal_aggregate_error.dart';

void main() {
  group('UnsealAggregateError', () {
    test('should correctly store message, statusCode, and errorData', () {
      final error = UnsealAggregateError(
        message: 'Failed to unseal data',
        statusCode: 500,
        errorData: {'reason': 'Invalid format'},
      );

      expect(error.message, 'Failed to unseal data');
      expect(error.statusCode, 500);
      expect(error.errorData, {'reason': 'Invalid format'});
    });

    test('should correctly format toString() with errorData', () {
      final error = UnsealAggregateError(
        message: 'Aggregation failure',
        statusCode: 400,
        errorData: {'details': 'Malformed input'},
      );

      expect(
        error.toString(),
        'UnsealAggregateError: Aggregation failure (Status Code: 400) | Error Data: {details: Malformed input}',
      );
    });

    test('should correctly format toString() without errorData', () {
      final error = UnsealAggregateError(
        message: 'Missing encryption key',
        statusCode: 403,
      );

      expect(
        error.toString(),
        'UnsealAggregateError: Missing encryption key (Status Code: 403)',
      );
    });
  });
}
