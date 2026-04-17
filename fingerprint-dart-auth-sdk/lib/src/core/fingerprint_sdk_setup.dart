import 'dart:convert';

import 'package:ds_standard_features/ds_standard_features.dart' as http;

/// FingerprintAuth handles fingerprint authentication using the FingerprintJS API.
/// It allows verifying fingerprint payloads by making HTTP requests to the API.
class FingerprintAuth {
  /// API key used for authentication with FingerprintJS.
  late final String apiKey;

  /// Base URL for the FingerprintJS API.
  final String baseUrl;

  /// HTTP client used for verification requests.
  final http.Client client;

  /// Constructor to initialize API key, base URL, and optional client.
  ///
  /// The API key can be provided directly or via an environment variable.
  FingerprintAuth({
    String? apiKey,
    String? envVar,
    this.baseUrl = 'https://api.fingerprintjs.com',
    http.Client? client,
  }) : apiKey = apiKey ?? envVar ?? '',
       client = client ?? http.Client() {
    if (this.apiKey.isEmpty) {
      throw ArgumentError(
        'API key must be provided either directly or via environment variables.',
      );
    }
  }

  /// Verifies a fingerprint payload by sending an HTTP request.
  ///
  /// Takes a [payload] as a JSON string and returns the response as a Map.
  /// Throws an exception if the verification request fails.
  Future<Map<String, dynamic>> verify(String payload) async {
    final url = Uri.parse('$baseUrl/verify');
    final response = await client.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      return response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : {};
    }

    throw Exception('Verification failed: ${response.body}');
  }
}
