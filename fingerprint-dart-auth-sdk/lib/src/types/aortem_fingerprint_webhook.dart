/// Represents a webhook event payload received from the FingerprintJS Pro API.
class Webhook {
  /// Unique identifier for the webhook event.
  final String id;

  /// Event type identifier (e.g., "visitor.created", "visitor.updated").
  final String event;

  /// The ISO8601 timestamp when the event occurred.
  final String timestamp;

  /// The visitor identifier associated with the event.
  final String visitorId;

  /// Additional event-specific data (optional).
  final Map<String, dynamic>? payload;

  Webhook({
    required this.id,
    required this.event,
    required this.timestamp,
    required this.visitorId,
    this.payload,
  });

  @override
  String toString() {
    return 'Webhook(id: $id, event: $event, timestamp: $timestamp, visitorId: $visitorId, payload: $payload)';
  }
}
