import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/core/aortem_fingerprint_authentication_mode.dart';

void main() {
  group('AuthenticationMode', () {
    test('should have correct enum values', () {
      expect(AuthenticationMode.strict.toString(), 'AuthenticationMode.strict');
      expect(AuthenticationMode.standard.toString(),
          'AuthenticationMode.standard');
    });

    test('should convert from string to enum', () {
      expect(AuthenticationMode.values.byName('strict'),
          AuthenticationMode.strict);
      expect(AuthenticationMode.values.byName('standard'),
          AuthenticationMode.standard);
    });

    test('should throw an error for invalid name', () {
      expect(() => AuthenticationMode.values.byName('invalid'),
          throwsA(isA<ArgumentError>()));
    });
  });
}
