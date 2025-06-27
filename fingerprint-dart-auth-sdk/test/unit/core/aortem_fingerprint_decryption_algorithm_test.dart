import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/core/aortem_fingerprint_decryption_algorithm.dart';

void main() {
  group('DecryptionAlgorithm', () {
    test('should have correct enum values', () {
      expect(
        DecryptionAlgorithm.aes256Gcm.toString(),
        'DecryptionAlgorithm.aes256Gcm',
      );
      expect(
        DecryptionAlgorithm.rsaOaep.toString(),
        'DecryptionAlgorithm.rsaOaep',
      );
    });

    test('should convert from string to enum', () {
      expect(
        DecryptionAlgorithm.values.byName('aes256Gcm'),
        DecryptionAlgorithm.aes256Gcm,
      );
      expect(
        DecryptionAlgorithm.values.byName('rsaOaep'),
        DecryptionAlgorithm.rsaOaep,
      );
    });

    test('should throw an error for invalid name', () {
      expect(
        () => DecryptionAlgorithm.values.byName('invalid'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
