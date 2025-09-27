import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_events_get_response.dart';

import 'aortem_fingerprint_meta.dart';

/// Represents the response from the FingerprintJS Pro API when searching for events.
class SearchEventsResponse {
  /// The list of event objects that match the search criteria.
  final List<Event> events;

  /// Metadata related to the search results (pagination details, total count, etc.).
  final Meta meta;

  /// Constructor to initialize the Search Event response.
  SearchEventsResponse({required this.events, required this.meta});

  /// Creates an instance of [SearchEventsResponse] from a JSON map.
  factory SearchEventsResponse.fromJson(Map<String, dynamic> json) {
    if (json['events'] == null) {
      throw ArgumentError('Missing required field "events" in JSON.');
    }
    if (json['meta'] == null) {
      throw ArgumentError('Missing required field "meta" in JSON.');
    }

    return SearchEventsResponse(
      events:
          (json['events'] as List<dynamic>)
              .map((e) => Event.fromJson(e as Map<String, dynamic>))
              .toList(),
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );
  }

  /// Converts this [SearchEventsResponse] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'events': events.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }

  @override
  String toString() => 'SearchEventsResponse(events: $events, meta: $meta)';
}
