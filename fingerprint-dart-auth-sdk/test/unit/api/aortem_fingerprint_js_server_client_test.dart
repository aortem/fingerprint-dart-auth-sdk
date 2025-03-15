import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/api/aortem_fingerprint_js_server_client.dart';

import 'dart:convert';
import 'dart:io';
import 'package:ds_standard_features/ds_standard_features.dart' as http;
import 'package:fingerprint_dart_auth_sdk/src/api/aortem_fingerprint_request_error.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('FingerprintJsServerApiClient Tests', () {
    late FingerprintJsServerApiClient apiClient;
    late MockHttpClient mockHttpClient;
    const String apiKey = 'test_api_key';

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiClient = FingerprintJsServerApiClient(apiKey: apiKey);
    });

    test('getIntegrationInfo returns valid IntegrationInfo', () async {
      final mockResponse = {
        'name': 'FingerprintJS',
        'version': '1.0.0',
      };

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await apiClient.getIntegrationInfo();
      expect(result.name, equals('FingerprintJS'));
      expect(result.version, equals('1.0.0'));
    });

    test('verifyFingerprint returns expected response', () async {
      final mockFingerprintData = {'fingerprint': 'test_fingerprint'};
      final mockResponse = {'verified': true};

      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: any(named: 'body'),
              ))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await apiClient.verifyFingerprint(mockFingerprintData);
      expect(result['verified'], isTrue);
    });

    test('getVisitorData returns visitor information', () async {
      final visitorId = 'test_visitor';
      final mockResponse = {'visitorId': visitorId, 'browser': 'Chrome'};

      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(mockResponse), 200));

      final result = await apiClient.getVisitorData(visitorId);
      expect(result['visitorId'], equals(visitorId));
      expect(result['browser'], equals('Chrome'));
    });

    test('Handles API rate limits (429 error)', () async {
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('', 429, headers: {
                HttpHeaders.retryAfterHeader: '2',
              }));

      final visitorId = 'test_visitor';

      expect(() async => await apiClient.getVisitorData(visitorId),
          throwsA(isA<RequestError>()));
    });
  });
}
