import 'package:fingerprint_dart_auth_sdk/src/types/fingerprint_search_events_filter.dart';
import 'package:ds_tools_testing/ds_tools_testing.dart';

void main() {
  group('SearchEventsFilter', () {
    test('should create an instance with valid data', () {
      final filter = SearchEventsFilter(
        query: 'login_attempt',
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        sort: 'desc',
      );

      expect(filter.query, 'login_attempt');
      expect(filter.from, '2025-03-01T00:00:00Z');
      expect(filter.to, '2025-03-10T23:59:59Z');
      expect(filter.limit, 50);
      expect(filter.offset, 10);
      expect(filter.sort, 'desc');
    });

    test('should convert instance to JSON correctly', () {
      final filter = SearchEventsFilter(
        query: 'login_attempt',
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        sort: 'desc',
      );

      final json = filter.toJson();

      expect(json, {
        'query': 'login_attempt',
        'from': '2025-03-01T00:00:00Z',
        'to': '2025-03-10T23:59:59Z',
        'limit': 50,
        'offset': 10,
        'sort': 'desc',
      });
    });

    test('should create instance from JSON correctly', () {
      final json = {
        'query': 'login_attempt',
        'from': '2025-03-01T00:00:00Z',
        'to': '2025-03-10T23:59:59Z',
        'limit': 50,
        'offset': 10,
        'sort': 'desc',
      };

      final filter = SearchEventsFilter.fromJson(json);

      expect(filter.query, 'login_attempt');
      expect(filter.from, '2025-03-01T00:00:00Z');
      expect(filter.to, '2025-03-10T23:59:59Z');
      expect(filter.limit, 50);
      expect(filter.offset, 10);
      expect(filter.sort, 'desc');
    });

    test('should handle missing fields in JSON', () {
      final json = {'query': 'login_attempt', 'limit': 50};

      final filter = SearchEventsFilter.fromJson(json);

      expect(filter.query, 'login_attempt');
      expect(filter.from, isNull);
      expect(filter.to, isNull);
      expect(filter.limit, 50);
      expect(filter.offset, isNull);
      expect(filter.sort, isNull);
    });

    test('should handle numeric values as strings', () {
      final json = {'query': 'login_attempt', 'limit': '50', 'offset': '10'};

      final filter = SearchEventsFilter.fromJson(json);

      expect(filter.limit, 50);
      expect(filter.offset, 10);
    });

    test('should return correct string representation', () {
      final filter = SearchEventsFilter(
        query: 'login_attempt',
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        sort: 'desc',
      );

      expect(filter.toString(), contains('query: login_attempt'));
      expect(filter.toString(), contains('from: 2025-03-01T00:00:00Z'));
      expect(filter.toString(), contains('to: 2025-03-10T23:59:59Z'));
      expect(filter.toString(), contains('limit: 50'));
      expect(filter.toString(), contains('offset: 10'));
      expect(filter.toString(), contains('sort: desc'));
    });
  });
}
