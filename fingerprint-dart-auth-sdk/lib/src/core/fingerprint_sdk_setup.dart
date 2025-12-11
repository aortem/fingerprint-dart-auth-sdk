// import 'dart:io';
import 'dart:convert';
import 'package:ds_standard_features/ds_standard_features.dart' as http;

/// FingerprintAuth handles fingerprint authentication using the FingerprintJS API.
/// It allows verifying fingerprint payloads by making HTTP requests to the API.
class FingerprintAuth {
  /// API key used for authentication with FingerprintJS.
  late final String apiKey;

  /// Base URL for the FingerprintJS API.
  final String baseUrl;

  /// Constructor to initialize API key and base URL.
  ///
  /// The API key can be provided directly, via an environment variable,
  /// or by setting the `FINGERPRINTJS_API_KEY` in the system environment.
  FingerprintAuth({
    String? apiKey,
    String? envVar,
    this.baseUrl = 'https://api.fingerprintjs.com',
  }) : apiKey =
           apiKey ??
           envVar ??
           //  Platform.environment['FINGERPRINTJS_API_KEY'] ??
           '' {
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
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey', // ✅ Fixed string interpolation
        'Content-Type': 'application/json',
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      return response.body.isNotEmpty
          ? jsonDecode(response.body) as Map<String, dynamic>
          : {};
    } else {
      throw Exception('Verification failed: ${response.body}');
    }
  }
}
