import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/api/aortem_fingerprint_unseal_error.dart';

void main() {
  group('UnsealError', () {
    test('should correctly store message, statusCode, and errorData', () {
      final error = UnsealError(
        message: 'Decryption failed',
        statusCode: 401,
        errorData: {'reason': 'Invalid key'},
      );

      expect(error.message, 'Decryption failed');
      expect(error.statusCode, 401);
      expect(error.errorData, {'reason': 'Invalid key'});
    });

    test('should correctly format toString() with errorData', () {
      final error = UnsealError(
        message: 'Data integrity check failed',
        statusCode: 422,
        errorData: {'hash_mismatch': true},
      );

      expect(
        error.toString(),
        'UnsealError: Data integrity check failed (Status Code: 422) | Details: {hash_mismatch: true}',
      );
    });

    test('should correctly format toString() without errorData', () {
      final error = UnsealError(message: 'Invalid encryption format');

      expect(
        error.toString(),
        'UnsealError: Invalid encryption format (Status Code: 400)',
      );
    });
  });
}
