import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ds_standard_features/ds_standard_features.dart' as http;

import '../core/aortem_fingerprint_region.dart';
import '../utils/aortem_fingerprint_get_integration_info.dart';
import '../utils/aortem_fingerprint_get_retry_after.dart';
import 'aortem_fingerprint_request_error.dart';

/// A client for interacting with the FingerprintJS Pro Server API.
class FingerprintJsServerApiClient {
  final String apiKey;
  final String baseUrl;
  final Region region;
  final Duration timeout;

  /// Creates an instance of the API client.
  ///
  /// - [apiKey]: The API key for authentication (must be provided).
  /// - [region]: The geographic region for routing requests (default: `Region.us`).
  /// - [baseUrl]: The base URL of the API (optional, defaults based on the region).
  /// - [timeout]: The request timeout duration (default: 10 seconds).
  FingerprintJsServerApiClient({
    required this.apiKey,
    this.region = Region.defaultRegion,
    String? baseUrl,
    this.timeout = const Duration(seconds: 10),
  }) : baseUrl = baseUrl ?? _getBaseUrl(region) {
    if (apiKey.isEmpty) {
      throw ArgumentError('API key must be provided.');
    }
  }

  /// Returns the base URL for the given region.
  static String _getBaseUrl(Region region) {
    switch (region) {
      case Region.eu:
        return 'https://eu.api.fingerprintjs.com';
      case Region.asia:
        return 'https://ap.api.fingerprintjs.com';
      case Region.us:
        return 'https://api.fingerprintjs.com';
    }
  }

  /// Constructs a properly encoded request path with optional query parameters.
  ///
  /// - [basePath]: The base endpoint path.
  /// - [queryParams]: Optional map of query parameters.
  ///
  /// Returns a URL-encoded request path.
  String getRequestPath(String basePath, [Map<String, dynamic>? queryParams]) {
    if (basePath.isEmpty) {
      throw ArgumentError('Base path cannot be empty.');
    }

    if (queryParams == null || queryParams.isEmpty) {
      return basePath;
    }

    final encodedQueryParams = queryParams.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    return '$basePath?$encodedQueryParams';
  }

  /// Retrieves integration metadata from the FingerprintJS Pro API.
  ///
  /// - Returns: An `IntegrationInfo` object containing integration details.
  Future<IntegrationInfo> getIntegrationInfo() async {
    return await _sendRequest<IntegrationInfo>(
      method: 'GET',
      endpoint: '/integration-info',
      parser: (data) => IntegrationInfo.fromJson(data),
    );
  }

  /// Verifies a fingerprint against the API.
  ///
  /// - [fingerprintData]: The fingerprint payload to send for verification.
  /// - Returns: A parsed response as a `Map<String, dynamic>`.
  Future<Map<String, dynamic>> verifyFingerprint(
      Map<String, dynamic> fingerprintData) async {
    final requestPath = getRequestPath('/verify');
    final url = Uri.parse('$baseUrl$requestPath');

    final response = await http
        .post(
          url,
          headers: _getHeaders(),
          body: jsonEncode(fingerprintData),
        )
        .timeout(timeout);

    return _handleResponse(response);
  }

  /// Retrieves visitor data from the API.
  ///
  /// - [visitorId]: The visitor ID to fetch data for.
  /// - Returns: A parsed response as a `Map<String, dynamic>`.
  Future<Map<String, dynamic>> getVisitorData(String visitorId) async {
    return await _sendRequest<Map<String, dynamic>>(
      method: 'GET',
      endpoint: '/visitor/$visitorId',
    );
  }

  /// Handles sending API requests with automatic retry handling for 429 errors.
  Future<T> _sendRequest<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    T Function(Map<String, dynamic>)? parser,
  }) async {
    final requestPath = getRequestPath(endpoint);
    final url = Uri.parse('$baseUrl$requestPath');

    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case 'POST':
          response = await http
              .post(url, headers: _getHeaders(), body: body)
              .timeout(timeout);
          break;
        case 'GET':
          response =
              await http.get(url, headers: _getHeaders()).timeout(timeout);
          break;
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }

      if (response.statusCode == 429) {
        final retryDuration = getRetryAfter(response.headers);
        if (retryDuration != null) {
          print(
              'Rate limit exceeded. Retrying after: ${retryDuration.inSeconds} seconds');
          await Future.delayed(retryDuration);
          return _sendRequest<T>(
              method: method, endpoint: endpoint, body: body, parser: parser);
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
  Map<String, String> _getHeaders() {
    return {
      HttpHeaders.authorizationHeader: 'Bearer $apiKey',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  /// Handles HTTP responses and converts them into readable formats.
  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw RequestError(
        message: 'API request failed',
        statusCode: response.statusCode,
        errorData: jsonDecode(response.body),
      );
    }
  }
}
