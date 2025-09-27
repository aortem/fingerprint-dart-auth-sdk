// Adjust import based on actual file structure

import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_extract_query_params.dart';

void main() {
  group('ExtractQueryParams', () {
    test('should create an instance with valid parameters', () {
      final queryParams = ExtractQueryParams(
        params: {'name': 'John', 'age': '25'},
      );

      expect(queryParams.params, containsPair('name', 'John'));
      expect(queryParams.params, containsPair('age', '25'));
    });

    test('should throw ArgumentError if params map is empty', () {
      expect(() => ExtractQueryParams(params: {}), throwsArgumentError);
    });

    test('should convert parameters to a query string correctly', () {
      final queryParams = ExtractQueryParams(
        params: {'name': 'John', 'age': '25'},
      );

      final queryString = queryParams.toQueryString();

      expect(queryString, contains('name=John'));
      expect(queryString, contains('age=25'));
    });

    test('should correctly parse a valid query string', () {
      final queryString = 'name=John&age=25';
      final queryParams = ExtractQueryParams.fromQueryString(queryString);

      expect(queryParams.params, containsPair('name', 'John'));
      expect(queryParams.params, containsPair('age', '25'));
    });

    test('should throw ArgumentError if query string is empty', () {
      expect(() => ExtractQueryParams.fromQueryString(''), throwsArgumentError);
    });

    test('should throw FormatException for malformed query string', () {
      expect(
        () => ExtractQueryParams.fromQueryString('invalidQuery'),
        throwsFormatException,
      );
      expect(
        () => ExtractQueryParams.fromQueryString('keyWithoutValue='),
        throwsFormatException,
      );
    });

    test('should correctly serialize to JSON', () {
      final queryParams = ExtractQueryParams(
        params: {'name': 'John', 'age': '25'},
      );

      final json = queryParams.toJson();

      expect(json, containsPair('name', 'John'));
      expect(json, containsPair('age', '25'));
    });
  });
}
