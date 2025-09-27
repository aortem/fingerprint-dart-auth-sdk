import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_webhook.dart';
import 'package:ds_tools_testing/ds_tools_testing.dart';
// Update with the correct import

void main() {
  group('Webhook Tests', () {
    test('should create an instance with correct values', () {
      final webhook = Webhook(
        id: '12345',
        event: 'visitor.created',
        timestamp: '2024-02-25T12:00:00Z',
        visitorId: 'visitor-abc',
        payload: {'key1': 'value1', 'key2': 42},
      );

      expect(webhook.id, equals('12345'));
      expect(webhook.event, equals('visitor.created'));
      expect(webhook.timestamp, equals('2024-02-25T12:00:00Z'));
      expect(webhook.visitorId, equals('visitor-abc'));
      expect(webhook.payload, isNotNull);
      expect(webhook.payload!['key1'], equals('value1'));
      expect(webhook.payload!['key2'], equals(42));
    });

    test('should allow a webhook instance without a payload', () {
      final webhook = Webhook(
        id: '67890',
        event: 'visitor.updated',
        timestamp: '2024-02-25T14:30:00Z',
        visitorId: 'visitor-def',
      );

      expect(webhook.id, equals('67890'));
      expect(webhook.event, equals('visitor.updated'));
      expect(webhook.timestamp, equals('2024-02-25T14:30:00Z'));
      expect(webhook.visitorId, equals('visitor-def'));
      expect(webhook.payload, isNull);
    });

    test('should correctly convert to string', () {
      final webhook = Webhook(
        id: '11111',
        event: 'visitor.deleted',
        timestamp: '2024-02-25T16:00:00Z',
        visitorId: 'visitor-xyz',
        payload: {'reason': 'manual deletion'},
      );

      expect(
        webhook.toString(),
        equals(
          'Webhook(id: 11111, event: visitor.deleted, timestamp: 2024-02-25T16:00:00Z, visitorId: visitor-xyz, payload: {reason: manual deletion})',
        ),
      );
    });
  });
}
