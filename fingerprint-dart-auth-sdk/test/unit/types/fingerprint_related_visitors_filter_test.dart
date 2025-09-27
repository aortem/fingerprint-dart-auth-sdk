import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_related_visitors_filter.dart';

void main() {
  group('RelatedVisitorsFilter', () {
    test('should create an instance with valid data', () {
      final filter = RelatedVisitorsFilter(
        from: '2025-03-10T00:00:00Z',
        to: '2025-03-13T23:59:59Z',
        limit: 10,
        visitorId: 'visitor_123',
        distinctId: 'distinct_456',
      );

      expect(filter.from, '2025-03-10T00:00:00Z');
      expect(filter.to, '2025-03-13T23:59:59Z');
      expect(filter.limit, 10);
      expect(filter.visitorId, 'visitor_123');
      expect(filter.distinctId, 'distinct_456');
    });

    test('should convert instance to JSON correctly', () {
      final filter = RelatedVisitorsFilter(
        from: '2025-03-10T00:00:00Z',
        to: '2025-03-13T23:59:59Z',
        limit: 10,
        visitorId: 'visitor_123',
        distinctId: 'distinct_456',
      );

      final json = filter.toJson();

      expect(json, {
        'from': '2025-03-10T00:00:00Z',
        'to': '2025-03-13T23:59:59Z',
        'limit': 10,
        'visitorId': 'visitor_123',
        'distinctId': 'distinct_456',
      });
    });

    test('should create instance from JSON correctly', () {
      final json = {
        'from': '2025-03-10T00:00:00Z',
        'to': '2025-03-13T23:59:59Z',
        'limit': 10,
        'visitorId': 'visitor_123',
        'distinctId': 'distinct_456',
      };

      final filter = RelatedVisitorsFilter.fromJson(json);

      expect(filter.from, '2025-03-10T00:00:00Z');
      expect(filter.to, '2025-03-13T23:59:59Z');
      expect(filter.limit, 10);
      expect(filter.visitorId, 'visitor_123');
      expect(filter.distinctId, 'distinct_456');
    });

    test('should handle optional fields correctly', () {
      final filter = RelatedVisitorsFilter();

      expect(filter.from, isNull);
      expect(filter.to, isNull);
      expect(filter.limit, isNull);
      expect(filter.visitorId, isNull);
      expect(filter.distinctId, isNull);
    });

    test('should generate correct query string', () {
      final filter = RelatedVisitorsFilter(
        from: '2025-03-10T00:00:00Z',
        to: '2025-03-13T23:59:59Z',
        limit: 10,
        visitorId: 'visitor_123',
        distinctId: 'distinct_456',
      );

      final queryString = filter.toQueryString();

      expect(
        queryString,
        '?from=2025-03-10T00%3A00%3A00Z&to=2025-03-13T23%3A59%3A59Z&limit=10&visitorId=visitor_123&distinctId=distinct_456',
      );
    });

    test('should return empty string when no parameters are set', () {
      final filter = RelatedVisitorsFilter();
      expect(filter.toQueryString(), '');
    });
  });
}
