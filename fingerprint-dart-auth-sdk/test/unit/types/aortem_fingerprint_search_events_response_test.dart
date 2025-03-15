import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_search_events_response.dart';
import 'package:test/test.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_events_get_response.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';

void main() {
  group('Meta', () {
    test('should create an instance with valid data', () {
      final meta = Meta(count: 50, page: 2, limit: 10);

      expect(meta.count, 50);
      expect(meta.page, 2);
      expect(meta.limit, 10);
    });

    test('should convert Meta to JSON correctly', () {
      final meta = Meta(count: 50, page: 2, limit: 10);
      final json = meta.toJson();

      expect(json, {'count': 50, 'page': 2, 'limit': 10});
    });

    test('should create Meta from JSON correctly', () {
      final json = {'count': 50, 'page': 2, 'limit': 10};
      final meta = Meta.fromJson(json);

      expect(meta.count, 50);
      expect(meta.page, 2);
      expect(meta.limit, 10);
    });

    test('should handle invalid JSON values gracefully', () {
      final json = {'count': '50', 'page': '2', 'limit': '10'};
      final meta = Meta.fromJson(json);

      expect(meta.count, 50);
      expect(meta.page, 2);
      expect(meta.limit, 10);
    });

    test('should throw error if required fields are missing', () {
      final json = {'count': 50, 'limit': 10};

      expect(() => Meta.fromJson(json), throwsArgumentError);
    });

    test('should return correct string representation', () {
      final meta = Meta(count: 50, page: 2, limit: 10);

      expect(meta.toString(), 'Meta(count: 50, page: 2, limit: 10)');
    });
  });

  group('Event', () {
    test('should create an instance with valid data', () {
      final event = Event(
        id: 'event_123',
        timestamp: '2025-03-13T12:00:00Z',
        details: {'type': 'login', 'status': 'success'},
      );

      expect(event.id, 'event_123');
      expect(event.timestamp, '2025-03-13T12:00:00Z');
      expect(event.details['type'], 'login');
      expect(event.details['status'], 'success');
    });

    test('should convert Event to JSON correctly', () {
      final event = Event(
        id: 'event_123',
        timestamp: '2025-03-13T12:00:00Z',
        details: {'type': 'login', 'status': 'success'},
      );

      final json = event.toJson();

      expect(json, {
        'id': 'event_123',
        'timestamp': '2025-03-13T12:00:00Z',
        'details': {'type': 'login', 'status': 'success'},
      });
    });

    test('should create Event from JSON correctly', () {
      final json = {
        'id': 'event_123',
        'timestamp': '2025-03-13T12:00:00Z',
        'details': {'type': 'login', 'status': 'success'},
      };

      final event = Event.fromJson(json);

      expect(event.id, 'event_123');
      expect(event.timestamp, '2025-03-13T12:00:00Z');
      expect(event.details['type'], 'login');
      expect(event.details['status'], 'success');
    });

    test('should throw error if required fields are missing', () {
      final json = {'id': 'event_123', 'timestamp': '2025-03-13T12:00:00Z'};

      expect(() => Event.fromJson(json), throwsArgumentError);
    });

    test('should return correct string representation', () {
      final event = Event(
        id: 'event_123',
        timestamp: '2025-03-13T12:00:00Z',
        details: {'type': 'login', 'status': 'success'},
      );

      expect(event.toString(), contains('event_123'));
      expect(event.toString(), contains('login'));
      expect(event.toString(), contains('success'));
    });
  });

  group('SearchEventsResponse', () {
    test('should create an instance with valid event data', () {
      final events = [
        Event(
          id: 'event_1',
          timestamp: '2025-03-13T12:00:00Z',
          details: {'type': 'login', 'status': 'success'},
        ),
        Event(
          id: 'event_2',
          timestamp: '2025-03-13T13:00:00Z',
          details: {'type': 'logout', 'status': 'success'},
        ),
      ];

      final meta = Meta(count: 2, page: 1, limit: 10);
      final response = SearchEventsResponse(events: events, meta: meta);

      expect(response.events.length, 2);
      expect(response.events[0].id, 'event_1');
      expect(response.events[1].details['type'], 'logout');
      expect(response.meta.count, 2);
    });

    test('should convert SearchEventsResponse to JSON correctly', () {
      final events = [
        Event(
          id: 'event_1',
          timestamp: '2025-03-13T12:00:00Z',
          details: {'type': 'login', 'status': 'success'},
        ),
      ];

      final meta = Meta(count: 1, page: 1, limit: 10);
      final response = SearchEventsResponse(events: events, meta: meta);
      final json = response.toJson();

      expect(json['events'], isList);
      expect(json['meta'], isNotNull);
      expect(json['events'][0]['id'], 'event_1');
      expect(json['meta']['count'], 1);
    });

    test('should create SearchEventsResponse from JSON correctly', () {
      final json = {
        'events': [
          {
            'id': 'event_1',
            'timestamp': '2025-03-13T12:00:00Z',
            'details': {'type': 'login', 'status': 'success'},
          }
        ],
        'meta': {'count': 1, 'page': 1, 'limit': 10},
      };

      final response = SearchEventsResponse.fromJson(json);

      expect(response.events.length, 1);
      expect(response.events[0].id, 'event_1');
      expect(response.events[0].details['type'], 'login');
      expect(response.meta.count, 1);
    });

    test('should throw error if required fields are missing', () {
      final json = {
        'meta': {'count': 1, 'page': 1, 'limit': 10}
      };

      expect(() => SearchEventsResponse.fromJson(json), throwsArgumentError);
    });

    test('should return correct string representation', () {
      final events = [
        Event(
          id: 'event_1',
          timestamp: '2025-03-13T12:00:00Z',
          details: {'type': 'login', 'status': 'success'},
        ),
      ];

      final meta = Meta(count: 1, page: 1, limit: 10);
      final response = SearchEventsResponse(events: events, meta: meta);

      expect(response.toString(), contains('SearchEventsResponse(events:'));
      expect(response.toString(), contains('event_1'));
      expect(response.toString(),
          contains('meta: Meta(count: 1, page: 1, limit: 10)'));
    });
  });
}
