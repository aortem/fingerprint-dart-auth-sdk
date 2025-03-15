
/// Represents the request payload for updating an event in the FingerprintJS Pro API.
class EventsUpdateRequest {
  /// The unique identifier of the event to be updated.
  final String eventId;

  /// A key-value map representing the fields and values to update.
  final Map<String, dynamic> updates;

  EventsUpdateRequest({
    required this.eventId,
    required this.updates,
  }) {
    if (eventId.isEmpty) {
      throw ArgumentError('eventId cannot be empty.');
    }
    if (updates.isEmpty) {
      throw ArgumentError('updates must contain at least one key-value pair.');
    }
  }

  /// Factory constructor to create an EventsUpdateRequest from a JSON object.
  factory EventsUpdateRequest.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('eventId') || !json.containsKey('updates')) {
      throw ArgumentError('Missing required EventsUpdateRequest fields.');
    }

    return EventsUpdateRequest(
      eventId: json['eventId'] as String,
      updates: json['updates'] as Map<String, dynamic>,
    );
  }

  /// Converts an EventsUpdateRequest instance to JSON.
  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'updates': updates,
      };
}
