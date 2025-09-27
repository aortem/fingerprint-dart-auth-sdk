import 'package:fingerprint_dart_auth_sdk/src/api/fingerprint_sdk_error.dart';
import 'package:ds_tools_testing/ds_tools_testing.dart';

void main() {
  group('SdkError', () {
    test('should correctly store message, code, and details', () {
      final error = SdkError(
        message: 'An unexpected error occurred',
        code: 'SDK_001',
        details: {'info': 'Debug details'},
      );

      expect(error.message, 'An unexpected error occurred');
      expect(error.code, 'SDK_001');
      expect(error.details, {'info': 'Debug details'});
    });

    test('should correctly format toString() with all fields', () {
      final error = SdkError(
        message: 'Invalid configuration',
        code: 'CONFIG_ERROR',
        details: 'Missing API key',
      );

      expect(
        error.toString(),
        'SdkError: Invalid configuration (Code: CONFIG_ERROR) | Details: Missing API key',
      );
    });

    test('should correctly format toString() without code and details', () {
      final error = SdkError(message: 'Unknown error');

      expect(error.toString(), 'SdkError: Unknown error');
    });
  });
}
