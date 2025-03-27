import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitors_response.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitor.dart';

void main() {
  group('Meta', () {
    test('should create an instance with valid data', () {
      final meta = Meta(count: 100, page: 2, limit: 50);

      expect(meta.count, 100);
      expect(meta.page, 2);
      expect(meta.limit, 50);
    });

    test('should convert Meta to JSON correctly', () {
      final meta = Meta(count: 100, page: 2, limit: 50);
      final json = meta.toJson();

      expect(json, {'count': 100, 'page': 2, 'limit': 50});
    });

    test('should create Meta from JSON correctly', () {
      final json = {'count': 100, 'page': 2, 'limit': 50};
      final meta = Meta.fromJson(json);

      expect(meta.count, 100);
      expect(meta.page, 2);
      expect(meta.limit, 50);
    });

    test('should handle invalid JSON values gracefully', () {
      final json = {'count': '100', 'page': '2', 'limit': '50'};
      final meta = Meta.fromJson(json);

      expect(meta.count, 100);
      expect(meta.page, 2);
      expect(meta.limit, 50);
    });

    test('should throw error if required fields are missing', () {
      final json = {'count': 100, 'limit': 50};

      expect(() => Meta.fromJson(json), throwsArgumentError);
    });

    test('should return correct string representation', () {
      final meta = Meta(count: 100, page: 2, limit: 50);

      expect(meta.toString(), 'Meta(count: 100, page: 2, limit: 50)');
    });
  });

  group('Visitor', () {
    test('should create an instance with valid data', () {
      final visitor = Visitor(
        id: 'visitor_123',
        fingerprint: 'abc123',
        ip: '192.168.1.1',
        userAgent: 'Mozilla/5.0',
        timestamp: '2025-03-13T12:00:00Z',
      );

      expect(visitor.id, 'visitor_123');
      expect(visitor.fingerprint, 'abc123');
      expect(visitor.ip, '192.168.1.1');
      expect(visitor.userAgent, 'Mozilla/5.0');
      expect(visitor.timestamp, '2025-03-13T12:00:00Z');
    });

    test('should return correct string representation', () {
      final visitor = Visitor(
        id: 'visitor_123',
        fingerprint: 'abc123',
        ip: '192.168.1.1',
        userAgent: 'Mozilla/5.0',
        timestamp: '2025-03-13T12:00:00Z',
      );

      expect(visitor.toString(), contains('Visitor(id: visitor_123'));
      expect(visitor.toString(), contains('fingerprint: abc123'));
      expect(visitor.toString(), contains('ip: 192.168.1.1'));
      expect(visitor.toString(), contains('userAgent: Mozilla/5.0'));
      expect(visitor.toString(), contains('timestamp: 2025-03-13T12:00:00Z'));
    });
  });

  group('VisitorsResponse', () {
    test('should create an instance with valid visitor data', () {
      final visitors = [
        Visitor(
          id: 'visitor_1',
          fingerprint: 'fingerprint_1',
          ip: '192.168.1.1',
          userAgent: 'Mozilla/5.0',
          timestamp: '2025-03-13T12:00:00Z',
        ),
        Visitor(
          id: 'visitor_2',
          fingerprint: 'fingerprint_2',
          ip: '192.168.1.2',
          userAgent: 'Chrome/110.0',
          timestamp: '2025-03-13T13:00:00Z',
        ),
      ];

      final meta = Meta(count: 2, page: 1, limit: 10);
      final response = VisitorsResponse(visitors: visitors, meta: meta);

      expect(response.visitors.length, 2);
      expect(response.visitors[0].id, 'visitor_1');
      expect(response.visitors[1].fingerprint, 'fingerprint_2');
      expect(response.visitors[1].userAgent, 'Chrome/110.0');
      expect(response.meta.count, 2);
    });

    test('should return correct string representation', () {
      final visitors = [
        Visitor(
          id: 'visitor_1',
          fingerprint: 'fingerprint_1',
          ip: '192.168.1.1',
          userAgent: 'Mozilla/5.0',
          timestamp: '2025-03-13T12:00:00Z',
        ),
      ];

      final meta = Meta(count: 1, page: 1, limit: 10);
      final response = VisitorsResponse(visitors: visitors, meta: meta);

      expect(response.toString(), contains('VisitorsResponse(visitors:'));
      expect(response.toString(), contains('visitor_1'));
      expect(
        response.toString(),
        contains('meta: Meta(count: 1, page: 1, limit: 10)'),
      );
    });
  });
}
