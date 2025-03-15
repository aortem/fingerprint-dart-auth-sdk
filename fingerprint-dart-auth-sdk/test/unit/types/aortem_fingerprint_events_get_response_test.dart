import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_events_get_response.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';
// Adjust import based on your file structure

void main() {
  group('EventsGetResponse', () {
    test('should deserialize from JSON correctly', () {
      final jsonData = {
        'events': [
          {
            'id': 'event_123',
            'timestamp': '2025-03-13T12:00:00Z',
            'details': {'key': 'value'}
          }
        ],
        'meta': {'count': 1, 'page': 1, 'limit': 10}
      };

      final response = EventsGetResponse.fromJson(jsonData);

      expect(response.events.length, 1);
      expect(response.events.first.id, 'event_123');
      expect(response.events.first.timestamp, '2025-03-13T12:00:00Z');
      expect(response.events.first.details, {'key': 'value'});

      expect(response.meta.count, 1);
      expect(response.meta.page, 1);
      expect(response.meta.limit, 10);
    });

    test('should serialize to JSON correctly', () {
      final event = Event(
        id: 'event_123',
        timestamp: '2025-03-13T12:00:00Z',
        details: {'key': 'value'},
      );

      final meta = Meta(count: 1, page: 1, limit: 10);

      final response = EventsGetResponse(events: [event], meta: meta);
      final json = response.toJson();

      expect(json['events'], isA<List>());
      expect(json['events'].first['id'], 'event_123');
      expect(json['events'].first['timestamp'], '2025-03-13T12:00:00Z');
      expect(json['events'].first['details'], {'key': 'value'});

      expect(json['meta']['count'], 1);
      expect(json['meta']['page'], 1);
      expect(json['meta']['limit'], 10);
    });

    test('should throw error for missing fields in JSON', () {
      final invalidJson = {'events': []}; // Missing 'meta' key

      expect(
          () => EventsGetResponse.fromJson(invalidJson), throwsArgumentError);
    });
  });
}
