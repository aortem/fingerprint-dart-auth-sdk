import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ds_standard_features/ds_standard_features.dart' as http;
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

import '../core/fingerprint_region.dart';
//import '../utils/fingerprint_get_integration_info.dart';
//import '../utils/fingerprint_get_retry_after.dart';
//import 'fingerprint_request_error.dart';

/// A client for interacting with the FingerprintJS Pro Server API.
class FingerprintJsServerApiClient {
  /// The API key for authentication.
  final String apiKey;

  /// The base URL of the API (determined by region if not provided).
  final String baseUrl;

  /// The geographic region for routing requests.
  final Region region;

  /// The request timeout duration.
  final Duration timeout;

  /// HTTP client (allows dependency injection for testing).
  final http.Client client;

  /// Creates an instance of the API client.
  FingerprintJsServerApiClient({
    required this.apiKey,
    this.region = Region.defaultRegion,
    String? baseUrl,
    this.timeout = const Duration(seconds: 10),
    http.Client? client, // Dependency injection for testability
  }) : baseUrl = baseUrl ?? _getBaseUrl(region),
       client = client ?? http.Client() {
    if (apiKey.isEmpty) {
      throw SdkError(
        message: 'API key must be provided',
        code: 'EMPTY_API_KEY',
        details:
            'Ensure that a valid API key is provided during SDK initialization.',
      );
    }
  }

  /// Returns the base URL for the given region.
  // static String _getBaseUrl(Region region) {
  //   switch (region) {
  //     case Region.eu:
  //       return 'https://eu.api.fingerprintjs.com';
  //     case Region.asia:
  //       return 'https://ap.api.fingerprintjs.com';
  //     case Region.us:
  //       return 'https://api.fingerprintjs.com';
  //   }
  // }

  static String _getBaseUrl(Region region) {
    switch (region) {
      case Region.eu:
        return 'https://eu.api.fpjs.io';
      case Region.asia:
        return 'https://ap.api.fpjs.io';
      case Region.us:
        return 'https://api.fpjs.io';
    }
  }

  /// Constructs a properly encoded request path with optional query parameters.
  String getRequestPath(String basePath, [Map<String, dynamic>? queryParams]) {
    if (basePath.isEmpty) {
      throw SdkError(
        message: 'Base path cannot be empty.',
        code: 'EMPTY_BASE_PATH',
        details: 'Ensure a valid base path is provided.',
      );
    }

    if (queryParams == null || queryParams.isEmpty) {
      return basePath;
    }

    final encodedQueryParams = queryParams.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    return '$basePath?$encodedQueryParams';
  }

  /// Retrieves integration metadata from the FingerprintJS Pro API.
  Future<IntegrationInfo> getIntegrationInfo() async {
    return await _sendRequest<IntegrationInfo>(
      method: 'GET',
      endpoint: '/integration-info',
      parser: (data) => IntegrationInfo.fromJson(data),
    );
  }

  /// Verifies a fingerprint against the API.
  Future<Map<String, dynamic>> verifyFingerprint(
    Map<String, dynamic> fingerprintData,
  ) async {
    return await _sendRequest<Map<String, dynamic>>(
      method: 'POST',
      endpoint: '/verify',
      body: fingerprintData,
    );
  }

  /// Retrieves visitor data from the API.
  Future<Map<String, dynamic>> getVisitorData(String visitorId) async {
    return await _sendRequest<Map<String, dynamic>>(
      method: 'GET',
      endpoint: '/visitors/$visitorId',
      queryParameters: {'api_key': apiKey},
      includeHeaders: false,
    );
  }

  /// Handles sending API requests with automatic retry handling for 429 errors.
  Future<T> _sendRequest<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? parser,
    bool includeHeaders = true,
  }) async {
    final requestPath = getRequestPath(endpoint);
    //final url = Uri.parse('$baseUrl$requestPath');
    // final url = Uri.https(baseUrl, requestPath, queryParameters ?? {});
    final url = Uri.parse(
      '$baseUrl$requestPath',
    ).replace(queryParameters: queryParameters ?? {});

    late http.Response response;

    try {
      switch (method.toUpperCase()) {
        case 'POST':
          response = await client
              .post(url, headers: _getHeaders(), body: jsonEncode(body))
              .timeout(timeout);
          break;
        case 'GET':
          response = await client
              .get(url, headers: includeHeaders ? _getHeaders() : null)
              .timeout(timeout);
          break;
        default:
          throw SdkError(
            message: 'Unsupported HTTP method: $method',
            code: 'INVALID_HTTP_METHOD',
            details:
                'Please ensure the HTTP method entered is either GET or POST.',
          );
      }

      if (response.statusCode == 429) {
        final retryDuration = getRetryAfter(response.headers);
        if (retryDuration != null) {
          print(
            'Rate limit exceeded. Retrying after: ${retryDuration.inSeconds} seconds',
          );
          await Future.delayed(retryDuration);
          return _sendRequest<T>(
            method: method,
            endpoint: endpoint,
            body: body,
            parser: parser,
          );
        } else {
          final errorData = response.body.isNotEmpty
              ? jsonDecode(response.body)
              : null;
          throw TooManyRequestsError(
            message: 'Too many requests. Please slow down.',
            statusCode: response.statusCode,
            errorData: errorData,
          );
        }
      }

      final data = _handleResponse(response);
      return parser != null ? parser(data) : data as T;
    } on SocketException {
      throw RequestError(message: 'Network error occurred', statusCode: 0);
    } on TimeoutException {
      throw RequestError(message: 'Request timed out', statusCode: 408);
    }
  }

  /// Returns common headers for API requests.
  // Map<String, String> _getHeaders() {
  //   return {
  //     HttpHeaders.authorizationHeader: '$apiKey',
  //     HttpHeaders.contentTypeHeader: 'application/json',
  //   };
  // }

  Map<String, String> _getHeaders() {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $apiKey',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  /// Handles HTTP responses and converts them into readable formats.
  Map<String, dynamic> _handleResponse(http.Response response) {
    try {
      final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return decodedBody;
      } else {
        throw RequestError(
          message: 'API request failed',
          statusCode: response.statusCode,
          errorData: decodedBody,
        );
      }
    } catch (e) {
      throw UnsealAggregateError(
        message: 'Failed to unseal response data',
        statusCode: response.statusCode,
        errorData: e.toString(),
      );
    }
  }

  /// Update events using event ID and updates
  Future<Map<String, dynamic>> updateEvent(EventsUpdateRequest request) async {
    final url = Uri.parse('$baseUrl/events/${request.eventId}');
    final response = await http
        .put(
          url,
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(request.toJson()),
        )
        .timeout(timeout);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to update event: ${response.body}');
    }
  }

  /// Fetch events using query parameters
  Future<Map<String, dynamic>> getEvents(ExtractQueryParams queryParams) async {
    final url = Uri.parse('$baseUrl/events?${queryParams.toQueryString()}');
    final response = await http
        .get(
          url,
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        )
        .timeout(timeout);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch events: ${response.body}');
    }
  }

  /// Fetches related visitors data based on the provided [filter].
  Future<Map<String, dynamic>> getRelatedVisitors(
    RelatedVisitorsFilter filter,
  ) async {
    final queryParameters = filter.toJson();
    final queryString = queryParameters.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    final url = Uri.parse('$baseUrl/related-visitors?$queryString');
    final response = await http
        .get(
          url,
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        )
        .timeout(timeout);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch related visitors: ${response.body}');
    }
  }

  /// Search events with a [SearchEventsFilter].
  Future<Map<String, dynamic>> searchEvents(SearchEventsFilter filter) async {
    final queryString = filter
        .toJson()
        .entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    final url = Uri.parse('$baseUrl/events/search?$queryString');

    final response = await http
        .get(
          url,
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        )
        .timeout(timeout);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to search events [${response.statusCode}]: ${response.body}',
      );
    }
  }

  /// Fetches visitor history using the provided [VisitorHistoryFilter].
  Future<Map<String, dynamic>> getVisitorHistory(
    VisitorHistoryFilter filter,
  ) async {
    if (filter.visitorId == null || filter.visitorId!.isEmpty) {
      throw SdkError(
        message: 'Visitor ID is required to fetch history',
        code: 'MISSING_VISITOR_ID',
        details: 'Pass a valid visitorId in VisitorHistoryFilter.',
      );
    }

    final queryParameters = filter.toJson()
      ..remove('visitorId'); // don't duplicate visitorId in query params

    final queryString = queryParameters.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    final url = Uri.parse(
      '$baseUrl/visitors/${filter.visitorId}/history?$queryString',
    );

    final response = await http
        .get(
          url,
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
        )
        .timeout(timeout);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to fetch visitor history [${response.statusCode}]: ${response.body}',
      );
    }
  }

  /// Retrieves all visitors (paginated) from the API.
  Future<VisitorsResponse> getVisitors({int limit = 10, int offset = 0}) async {
    final response = await _sendRequest<Map<String, dynamic>>(
      method: 'GET',
      endpoint: '/visitors',
      queryParameters: {
        'limit': limit.toString(),
        'offset': offset.toString(),
        'api_key': apiKey,
      },
    );
    return response as VisitorsResponse;
  }
}
