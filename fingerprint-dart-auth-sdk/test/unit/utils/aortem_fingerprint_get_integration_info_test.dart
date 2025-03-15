import 'package:fingerprint_dart_auth_sdk/src/utils/aortem_fingerprint_get_integration_info.dart';
import 'package:test/test.dart';

void main() {
  group('IntegrationInfo Tests', () {
    test('should create an instance with correct values', () {
      final integration = IntegrationInfo(
        type: 'server',
        version: '1.0.0',
        publicKey: 'public-key-123',
        name: '',
      );

      expect(integration.type, equals('server'));
      expect(integration.version, equals('1.0.0'));
      expect(integration.publicKey, equals('public-key-123'));
    });

    test('should correctly convert to string', () {
      final integration = IntegrationInfo(
        type: 'client',
        version: '2.1.0',
        publicKey: 'public-key-456',
        name: '',
      );

      expect(
          integration.toString(),
          equals(
              'IntegrationInfo(type: client, version: 2.1.0, publicKey: public-key-456)'));
    });

    test('should create an instance from JSON', () {
      final json = {
        'type': 'server',
        'version': '3.0.0',
        'publicKey': 'public-key-789',
      };

      final integration = IntegrationInfo.fromJson(json);

      expect(integration.type, equals('server'));
      expect(integration.version, equals('3.0.0'));
      expect(integration.publicKey, equals('public-key-789'));
    });

    test('should throw an error if required fields are missing in JSON', () {
      final json = {
        'type': 'server',
        // 'version' is missing
        'publicKey': 'public-key-xyz',
      };

      expect(() => IntegrationInfo.fromJson(json), throwsA(isA<TypeError>()));
    });
  });
}
