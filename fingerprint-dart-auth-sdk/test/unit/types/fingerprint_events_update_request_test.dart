import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/fingerprint_events_update_request.dart';
// Adjust import based on file structure

void main() {
  group('EventsUpdateRequest', () {
    test('should create an instance with valid data', () {
      final request = EventsUpdateRequest(
        eventId: 'event_123',
        updates: {'status': 'processed'},
      );

      expect(request.eventId, 'event_123');
      expect(request.updates, containsPair('status', 'processed'));
    });

    test('should throw ArgumentError if eventId is empty', () {
      expect(
        () =>
            EventsUpdateRequest(eventId: '', updates: {'status': 'processed'}),
        throwsArgumentError,
      );
    });

    test('should throw ArgumentError if updates map is empty', () {
      expect(
        () => EventsUpdateRequest(eventId: 'event_123', updates: {}),
        throwsArgumentError,
      );
    });

    test('should deserialize from JSON correctly', () {
      final jsonData = {
        'eventId': 'event_123',
        'updates': {'status': 'processed'},
      };

      final request = EventsUpdateRequest.fromJson(jsonData);

      expect(request.eventId, 'event_123');
      expect(request.updates, containsPair('status', 'processed'));
    });

    test('should serialize to JSON correctly', () {
      final request = EventsUpdateRequest(
        eventId: 'event_123',
        updates: {'status': 'processed'},
      );

      final json = request.toJson();

      expect(json['eventId'], 'event_123');
      expect(json['updates'], {'status': 'processed'});
    });

    test('should throw error for missing required fields in JSON', () {
      final invalidJson = {
        'updates': {'status': 'processed'},
      }; // Missing 'eventId'

      expect(
        () => EventsUpdateRequest.fromJson(invalidJson),
        throwsArgumentError,
      );
    });
  });
}
