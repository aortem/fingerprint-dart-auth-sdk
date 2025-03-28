import 'aortem_fingerprint_events_get_response.dart';
import 'aortem_fingerprint_events_update_request.dart';
import 'aortem_fingerprint_extract_query_params.dart';

/// Represents a request for fingerprint verification.
class VerificationRequest {
  /// The unique identifier of the visitor.
  final String visitorId;

  /// The unique identifier of the verification request.
  final String requestId;

  /// The timestamp when the verification request was made.
  final DateTime timestamp;

  /// Creates a new [VerificationRequest] instance.
  VerificationRequest({
    required this.visitorId,
    required this.requestId,
    required this.timestamp,
  });
}

/// Represents the response received after fingerprint verification.
class VerificationResponse {
  /// Indicates whether the fingerprint verification was successful.
  final bool verified;

  /// The confidence level of the verification.
  final String confidence;

  /// The unique identifier of the verified visitor.
  final String visitorId;

  /// Creates a new [VerificationResponse] instance.
  VerificationResponse({
    required this.verified,
    required this.confidence,
    required this.visitorId,
  });
}

/// Represents the response containing visitor data.
class VisitorDataResponse {
  /// The unique identifier of the visitor.
  final String visitorId;

  /// The IP address of the visitor.
  final String ip;

  /// The country associated with the visitor's IP address.
  final String country;

  /// Indicates whether the visitor is detected as a bot.
  final bool bot;

  /// Creates a new [VisitorDataResponse] instance.
  VisitorDataResponse({
    required this.visitorId,
    required this.ip,
    required this.country,
    required this.bot,
  });
}

/// Defines a unified API interface for interacting with the FingerprintJS Pro API.
abstract class FingerprintApi {
  /// Verifies a fingerprint using the given verification request.
  ///
  /// Returns a [VerificationResponse] containing the verification result.
  Future<VerificationResponse> verify(VerificationRequest request);

  /// Retrieves visitor data for a given [visitorId].
  ///
  /// Returns a [VisitorDataResponse] containing details about the visitor.
  Future<VisitorDataResponse> getVisitorData(String visitorId);

  /// Retrieves a list of events based on the provided query parameters.
  ///
  /// Accepts an [ExtractQueryParams] object and returns an [EventsGetResponse].
  Future<EventsGetResponse> getEvents(ExtractQueryParams queryParams);

  /// Updates an event using the provided update request.
  ///
  /// Accepts an [EventsUpdateRequest] and returns the updated event details.
  Future<EventsUpdateRequest> updateEvent(EventsUpdateRequest request);
}
