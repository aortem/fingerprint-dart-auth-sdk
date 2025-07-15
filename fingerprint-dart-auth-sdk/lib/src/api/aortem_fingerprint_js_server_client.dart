import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ds_standard_features/ds_standard_features.dart' as http;
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

import '../core/aortem_fingerprint_region.dart';
import '../utils/aortem_fingerprint_get_integration_info.dart';
import '../utils/aortem_fingerprint_get_retry_after.dart';
import 'aortem_fingerprint_request_error.dart';

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
      include_headers: false,
    );
  }

  /// Handles sending API requests with automatic retry handling for 429 errors.
  Future<T> _sendRequest<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic>)? parser,
    bool include_headers = true,
  }) async {
    final requestPath = getRequestPath(endpoint);
    //final url = Uri.parse('$baseUrl$requestPath');
    final url = Uri.https(baseUrl, requestPath, queryParameters ?? {});

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
              .get(url, headers: include_headers ? _getHeaders() : null)
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
  Map<String, String> _getHeaders() {
    return {
      HttpHeaders.authorizationHeader: '$apiKey',
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
}
