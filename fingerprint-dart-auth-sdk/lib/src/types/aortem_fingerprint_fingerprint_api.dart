import 'aortem_fingerprint_events_get_response.dart';
import 'aortem_fingerprint_events_update_request.dart';
import 'aortem_fingerprint_extract_query_params.dart';

class VerificationRequest {
  final String visitorId;
  final String requestId;
  final DateTime timestamp;

  VerificationRequest({
    required this.visitorId,
    required this.requestId,
    required this.timestamp,
  });
}

class VerificationResponse {
  final bool verified;
  final String confidence;
  final String visitorId;

  VerificationResponse({
    required this.verified,
    required this.confidence,
    required this.visitorId,
  });
}

class VisitorDataResponse {
  final String visitorId;
  final String ip;
  final String country;
  final bool bot;

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
  Future<VerificationResponse> verify(VerificationRequest request);

  /// Retrieves visitor data for a given [visitorId].
  Future<VisitorDataResponse> getVisitorData(String visitorId);

  /// Retrieves a list of events based on the provided query parameters.
  Future<EventsGetResponse> getEvents(ExtractQueryParams queryParams);

  /// Updates an event using the provided update request.
  Future<EventsUpdateRequest> updateEvent(EventsUpdateRequest request);
}
