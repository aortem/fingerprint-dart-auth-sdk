import 'package:test/test.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitor_history_filter.dart';

void main() {
  group('VisitorHistoryFilter', () {
    test('should create an instance with valid data', () {
      final filter = VisitorHistoryFilter(
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        visitorId: 'visitor_123',
      );

      expect(filter.from, '2025-03-01T00:00:00Z');
      expect(filter.to, '2025-03-10T23:59:59Z');
      expect(filter.limit, 50);
      expect(filter.offset, 10);
      expect(filter.visitorId, 'visitor_123');
    });

    test('should convert instance to JSON correctly', () {
      final filter = VisitorHistoryFilter(
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        visitorId: 'visitor_123',
      );

      final json = filter.toJson();

      expect(json, {
        'from': '2025-03-01T00:00:00Z',
        'to': '2025-03-10T23:59:59Z',
        'limit': 50,
        'offset': 10,
        'visitorId': 'visitor_123',
      });
    });

    test('should create instance from JSON correctly', () {
      final json = {
        'from': '2025-03-01T00:00:00Z',
        'to': '2025-03-10T23:59:59Z',
        'limit': 50,
        'offset': 10,
        'visitorId': 'visitor_123',
      };

      final filter = VisitorHistoryFilter.fromJson(json);

      expect(filter.from, '2025-03-01T00:00:00Z');
      expect(filter.to, '2025-03-10T23:59:59Z');
      expect(filter.limit, 50);
      expect(filter.offset, 10);
      expect(filter.visitorId, 'visitor_123');
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'from': '2025-03-01T00:00:00Z',
        'limit': 50,
      };

      final filter = VisitorHistoryFilter.fromJson(json);

      expect(filter.from, '2025-03-01T00:00:00Z');
      expect(filter.to, isNull);
      expect(filter.limit, 50);
      expect(filter.offset, isNull);
      expect(filter.visitorId, isNull);
    });

    test('should generate correct query string', () {
      final filter = VisitorHistoryFilter(
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        visitorId: 'visitor_123',
      );

      final queryString = filter.toQueryString();

      expect(
        queryString,
        contains('from=2025-03-01T00%3A00%3A00Z'),
      );
      expect(
        queryString,
        contains('to=2025-03-10T23%3A59%3A59Z'),
      );
      expect(queryString, contains('limit=50'));
      expect(queryString, contains('offset=10'));
      expect(queryString, contains('visitorId=visitor_123'));
    });

    test('should return empty query string when no fields are set', () {
      final filter = VisitorHistoryFilter();
      expect(filter.toQueryString(), '');
    });

    test('should return correct string representation', () {
      final filter = VisitorHistoryFilter(
        from: '2025-03-01T00:00:00Z',
        to: '2025-03-10T23:59:59Z',
        limit: 50,
        offset: 10,
        visitorId: 'visitor_123',
      );

      expect(filter.toString(),
          contains('VisitorHistoryFilter(from: 2025-03-01T00:00:00Z'));
      expect(filter.toString(), contains('to: 2025-03-10T23:59:59Z'));
      expect(filter.toString(), contains('limit: 50'));
      expect(filter.toString(), contains('offset: 10'));
      expect(filter.toString(), contains('visitorId: visitor_123'));
    });
  });
}
