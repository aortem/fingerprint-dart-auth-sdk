import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_events_get_response.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_events_update_request.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_extract_query_params.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_fingerprint_api.dart';
import 'package:fingerprint_dart_auth_sdk/src/types/aortem_fingerprint_meta.dart';

void main() {
  group('VerificationRequest', () {
    test('should create an instance with valid data', () {
      final request = VerificationRequest(
        visitorId: 'visitor_123',
        requestId: 'request_456',
        timestamp: DateTime.utc(2025, 3, 13),
      );

      expect(request.visitorId, 'visitor_123');
      expect(request.requestId, 'request_456');
      expect(request.timestamp, DateTime.utc(2025, 3, 13));
    });
  });

  group('VerificationResponse', () {
    test('should create an instance with valid data', () {
      final response = VerificationResponse(
        verified: true,
        confidence: 'high',
        visitorId: 'visitor_123',
      );

      expect(response.verified, true);
      expect(response.confidence, 'high');
      expect(response.visitorId, 'visitor_123');
    });
  });

  group('VisitorDataResponse', () {
    test('should create an instance with valid data', () {
      final visitorData = VisitorDataResponse(
        visitorId: 'visitor_789',
        ip: '192.168.1.1',
        country: 'US',
        bot: false,
      );

      expect(visitorData.visitorId, 'visitor_789');
      expect(visitorData.ip, '192.168.1.1');
      expect(visitorData.country, 'US');
      expect(visitorData.bot, false);
    });
  });

  group('FingerprintApi', () {
    test('should mock verify method and return expected response', () async {
      final api = _MockFingerprintApi();
      final request = VerificationRequest(
        visitorId: 'visitor_123',
        requestId: 'request_456',
        timestamp: DateTime.now(),
      );

      final response = await api.verify(request);

      expect(response.verified, true);
      expect(response.confidence, 'high');
      expect(response.visitorId, 'visitor_123');
    });

    test('should mock getVisitorData method and return expected response',
        () async {
      final api = _MockFingerprintApi();
      final response = await api.getVisitorData('visitor_789');

      expect(response.visitorId, 'visitor_789');
      expect(response.ip, '192.168.1.1');
      expect(response.country, 'US');
      expect(response.bot, false);
    });

    test('should mock getEvents method and return expected response', () async {
      final api = _MockFingerprintApi();
      final queryParams = ExtractQueryParams(params: {'limit': '10'});

      final response = await api.getEvents(queryParams);

      expect(response.events.length, 1);
      expect(response.meta.count, 1);
    });

    test('should mock updateEvent method and return expected request object',
        () async {
      final api = _MockFingerprintApi();
      final request = EventsUpdateRequest(
          eventId: 'event_001', updates: {'status': 'updated'});

      final response = await api.updateEvent(request);

      expect(response.eventId, 'event_001');
      expect(response.updates['status'], 'updated');
    });
  });
}

/// Mock implementation of FingerprintApi for testing.
class _MockFingerprintApi implements FingerprintApi {
  @override
  Future<VerificationResponse> verify(VerificationRequest request) async {
    return VerificationResponse(
      verified: true,
      confidence: 'high',
      visitorId: request.visitorId,
    );
  }

  @override
  Future<VisitorDataResponse> getVisitorData(String visitorId) async {
    return VisitorDataResponse(
      visitorId: visitorId,
      ip: '192.168.1.1',
      country: 'US',
      bot: false,
    );
  }

  @override
  Future<EventsGetResponse> getEvents(ExtractQueryParams queryParams) async {
    return EventsGetResponse(
      events: [
        Event(
            id: 'event_001',
            timestamp: '2025-03-13T12:00:00Z',
            details: {'action': 'login'}),
      ],
      meta: Meta(count: 1, page: 1, limit: 10),
    );
  }

  @override
  Future<EventsUpdateRequest> updateEvent(EventsUpdateRequest request) async {
    return request;
  }
}
