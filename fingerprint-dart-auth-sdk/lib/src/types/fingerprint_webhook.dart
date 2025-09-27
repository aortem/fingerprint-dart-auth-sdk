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

  /// Constructor to initialize the Webhook.
  Webhook({
    required this.id,
    required this.event,
    required this.timestamp,
    required this.visitorId,
    this.payload,
  });

  /// Factory to create a Webhook from JSON.
  factory Webhook.fromJson(Map<String, dynamic> json) {
    return Webhook(
      id: json['id'] as String,
      event: json['event'] as String,
      timestamp: json['timestamp'] as String,
      visitorId: json['visitorId'] as String,
      payload: json['payload'] != null
          ? Map<String, dynamic>.from(json['payload'] as Map)
          : null,
    );
  }

  /// Convert Webhook instance to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event': event,
      'timestamp': timestamp,
      'visitorId': visitorId,
      'payload': payload,
    };
  }

  @override
  String toString() {
    return 'Webhook(id: $id, event: $event, timestamp: $timestamp, visitorId: $visitorId, payload: $payload)';
  }
}
