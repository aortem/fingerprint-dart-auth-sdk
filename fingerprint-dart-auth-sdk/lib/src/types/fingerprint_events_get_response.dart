import 'aortem_fingerprint_meta.dart';

/// Represents an individual event returned by the FingerprintJS Pro API.
class Event {
  /// Unique identifier of the event.
  final String id;

  /// Timestamp of when the event occurred.
  final String timestamp;

  /// Additional event details.
  final Map<String, dynamic> details;

  /// Constructor to initialize the Event  response.
  Event({required this.id, required this.timestamp, required this.details});

  /// Factory constructor to create an Event from a JSON object.
  factory Event.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('timestamp') ||
        !json.containsKey('details')) {
      throw ArgumentError('Missing required event fields.');
    }

    return Event(
      id: json['id'] as String,
      timestamp: json['timestamp'] as String,
      details: json['details'] as Map<String, dynamic>,
    );
  }

  /// Converts an Event instance to JSON.
  Map<String, dynamic> toJson() => {
    'id': id,
    'timestamp': timestamp,
    'details': details,
  };
}

/// Represents the response received when fetching events from the FingerprintJS Pro API.
class EventsGetResponse {
  /// A list of events.
  final List<Event> events;

  /// Metadata about the response.
  final Meta meta;

  /// Constructor to initialize the Event Get response.
  EventsGetResponse({required this.events, required this.meta});

  /// Factory constructor to create an EventsGetResponse from a JSON object.
  factory EventsGetResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('events') || !json.containsKey('meta')) {
      throw ArgumentError('Missing required EventsGetResponse fields.');
    }

    return EventsGetResponse(
      events:
          (json['events'] as List<dynamic>)
              .map((e) => Event.fromJson(e as Map<String, dynamic>))
              .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  /// Converts an EventsGetResponse instance to JSON.
  Map<String, dynamic> toJson() => {
    'events': events.map((e) => e.toJson()).toList(),
    'meta': meta.toJson(),
  };
}
