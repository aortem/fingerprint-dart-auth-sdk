import 'package:ds_standard_features/ds_standard_features.dart' as http;
import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/core/fingerprint_sdk_setup.dart';
import '../../support/fake_http_client.dart';

void main() {
  group('FingerprintAuth', () {
    test('throws ArgumentError if API key is not provided', () {
      expect(() => FingerprintAuth(apiKey: ''), throwsArgumentError);
    });

    test('throws Exception on verification failure', () async {
      final auth = FingerprintAuth(
        apiKey: 'test_api_key',
        client: FakeHttpClient((_) async => http.Response('Error', 400)),
      );

      expect(
        () => auth.verify('{"fingerprint": "test_data"}'),
        throwsA(isA<Exception>()),
      );
    });

    test('returns decoded payload on successful verification', () async {
      final auth = FingerprintAuth(
        apiKey: 'test_api_key',
        client: FakeHttpClient(
          (_) async => http.Response('{"verified":true}', 200),
        ),
      );

      final result = await auth.verify('{"fingerprint":"test_data"}');

      expect(result['verified'], true);
    });
  });
}
