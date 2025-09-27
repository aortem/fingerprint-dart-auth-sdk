import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/interfaces/fingerprint_options.dart';

void main() {
  group('DefaultOptions Tests', () {
    test('Should create DefaultOptions with valid API key', () {
      final options = DefaultOptions(apiKey: 'test_api_key');

      expect(options.apiKey, equals('test_api_key'));
      expect(options.baseUrl, equals('https://api.fingerprintjs.com'));
      expect(options.timeout, equals(const Duration(seconds: 10)));
      expect(options.debug, isFalse);
    });

    test('Should throw ArgumentError if API key is empty', () {
      expect(() => DefaultOptions(apiKey: ''), throwsA(isA<ArgumentError>()));
    });

    test('Should allow customization of baseUrl, timeout, and debug', () {
      final options = DefaultOptions(
        apiKey: 'custom_key',
        baseUrl: 'https://custom-url.com',
        timeout: const Duration(seconds: 20),
        debug: true,
      );

      expect(options.apiKey, equals('custom_key'));
      expect(options.baseUrl, equals('https://custom-url.com'));
      expect(options.timeout, equals(const Duration(seconds: 20)));
      expect(options.debug, isTrue);
    });

    test('Should convert to JSON correctly', () {
      final options = DefaultOptions(apiKey: 'json_key', debug: true);
      final json = options.toJson();

      expect(json['apiKey'], equals('json_key'));
      expect(json['baseUrl'], equals('https://api.fingerprintjs.com'));
      expect(json['timeout'], equals(10)); // Timeout in seconds
      expect(json['debug'], isTrue);
    });
  });
}
