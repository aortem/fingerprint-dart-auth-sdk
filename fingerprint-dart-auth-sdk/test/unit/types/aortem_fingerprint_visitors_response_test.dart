import 'package:test/test.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitor.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_visitors_response.dart';

void main() {
  group('Visitor', () {
    test('should create a valid Visitor instance', () {
      final visitor = Visitor(
        id: 'visitor_123',
        fingerprint: 'abc123xyz',
        ip: '192.168.1.1',
        userAgent: 'Mozilla/5.0',
        timestamp: '2025-03-13T12:00:00Z',
      );

      expect(visitor.id, 'visitor_123');
      expect(visitor.fingerprint, 'abc123xyz');
      expect(visitor.ip, '192.168.1.1');
      expect(visitor.userAgent, 'Mozilla/5.0');
      expect(visitor.timestamp, '2025-03-13T12:00:00Z');
    });

    test('should return correct string representation', () {
      final visitor = Visitor(
        id: 'visitor_123',
        fingerprint: 'abc123xyz',
        ip: '192.168.1.1',
        userAgent: 'Mozilla/5.0',
        timestamp: '2025-03-13T12:00:00Z',
      );

      expect(visitor.toString(), contains('visitor_123'));
      expect(visitor.toString(), contains('abc123xyz'));
      expect(visitor.toString(), contains('192.168.1.1'));
    });
  });

  group('VisitorsResponse', () {
    test('should create a valid VisitorsResponse instance', () {
      final visitors = [
        Visitor(
          id: 'visitor_1',
          fingerprint: 'abc123xyz',
          ip: '192.168.1.1',
          userAgent: 'Mozilla/5.0',
          timestamp: '2025-03-13T12:00:00Z',
        ),
        Visitor(
          id: 'visitor_2',
          fingerprint: 'xyz789abc',
          ip: '192.168.1.2',
          userAgent: 'Mozilla/5.0',
          timestamp: '2025-03-13T13:00:00Z',
        ),
      ];

      final meta = Meta(count: 2, page: 1, limit: 10);
      final response = VisitorsResponse(visitors: visitors, meta: meta);

      expect(response.visitors.length, 2);
      expect(response.visitors[0].id, 'visitor_1');
      expect(response.visitors[1].ip, '192.168.1.2');
      expect(response.meta.count, 2);
    });

    test('should return correct string representation', () {
      final visitors = [
        Visitor(
          id: 'visitor_1',
          fingerprint: 'abc123xyz',
          ip: '192.168.1.1',
          userAgent: 'Mozilla/5.0',
          timestamp: '2025-03-13T12:00:00Z',
        ),
      ];

      final meta = Meta(count: 1, page: 1, limit: 10);
      final response = VisitorsResponse(visitors: visitors, meta: meta);

      expect(response.toString(), contains('VisitorsResponse(visitors:'));
      expect(response.toString(), contains('visitor_1'));
      expect(response.toString(),
          contains('meta: Meta(count: 1, page: 1, limit: 10)'));
    });
  });
}
