import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/utils/fingerprint_get_request_path.dart';

void main() {
  group('getRequestPath tests', () {
    test('should return base path when no query parameters are provided', () {
      const basePath = '/api/v1/resource';

      final result = getRequestPath(basePath);

      expect(result, equals(basePath));
    });

    test('should throw an error when base path is empty', () {
      expect(() => getRequestPath(''), throwsA(isA<ArgumentError>()));
    });

    test('should append a single query parameter', () {
      const basePath = '/api/v1/resource';
      final queryParams = {'key': 'value'};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals('/api/v1/resource?key=value'));
    });

    test('should append multiple query parameters', () {
      const basePath = '/api/v1/resource';
      final queryParams = {'key1': 'value1', 'key2': 'value2'};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals('/api/v1/resource?key1=value1&key2=value2'));
    });

    test('should URL encode special characters in query parameters', () {
      const basePath = '/api/v1/resource';
      final queryParams = {'key': 'value with spaces'};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals('/api/v1/resource?key=value%20with%20spaces'));
    });

    test(
      'should URL encode special characters like "&" and "=" in query parameters',
      () {
        const basePath = '/api/v1/resource';
        final queryParams = {'key': 'value&with=special characters'};

        final result = getRequestPath(basePath, queryParams);

        expect(
          result,
          equals('/api/v1/resource?key=value%26with%3Dspecial%20characters'),
        );
      },
    );

    test('should handle numeric query parameters correctly', () {
      const basePath = '/api/v1/resource';
      final queryParams = {'count': 10};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals('/api/v1/resource?count=10'));
    });

    test('should handle boolean query parameters correctly', () {
      const basePath = '/api/v1/resource';
      final queryParams = {'enabled': true};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals('/api/v1/resource?enabled=true'));
    });

    test('should handle empty query parameters correctly', () {
      const basePath = '/api/v1/resource';
      final queryParams = <String, String>{};

      final result = getRequestPath(basePath, queryParams);

      expect(result, equals(basePath));
    });
  });
}
