import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/core/aortem_fingerprint_sdk_setup.dart';

import 'package:ds_standard_features/ds_standard_features.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('AortemFingerprintAuth', () {
    late MockHttpClient mockHttpClient;
    late AortemFingerprintAuth auth;

    setUp(() {
      mockHttpClient = MockHttpClient();
      auth = AortemFingerprintAuth(apiKey: 'test_api_key');
    });

    test('should throw ArgumentError if API key is not provided', () {
      expect(() => AortemFingerprintAuth(apiKey: ''), throwsArgumentError);
    });

    test('should verify fingerprint successfully', () async {
      const responseBody = '{"success": true}';
      final url = Uri.parse('${auth.baseUrl}/verify');

      when(() => mockHttpClient.post(
            url,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(responseBody, 200));

      final response = await auth.verify('{"fingerprint": "test_data"}');

      expect(response, isA<Map<String, dynamic>>());
      expect(response['success'], true);
    });

    test('should throw Exception on verification failure', () async {
      final url = Uri.parse('${auth.baseUrl}/verify');

      when(() => mockHttpClient.post(
            url,
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () => auth.verify('{"fingerprint": "test_data"}'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
