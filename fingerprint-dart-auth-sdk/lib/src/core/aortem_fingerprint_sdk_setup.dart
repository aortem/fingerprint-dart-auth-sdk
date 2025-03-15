import 'dart:io';
import 'package:ds_standard_features/ds_standard_features.dart' as http;

class AortemFingerprintAuth {
  late final String apiKey;
  final String baseUrl;

  /// Constructor to initialize API key and base URL.
  AortemFingerprintAuth({
    String? apiKey,
    String? envVar,
    String baseUrl = 'https://api.fingerprintjs.com',
  })  : baseUrl = baseUrl,  // ✅ Initialize `baseUrl` here
        apiKey = apiKey ?? envVar ?? Platform.environment['FINGERPRINTJS_API_KEY'] ?? '' {
    if (this.apiKey.isEmpty) {
      throw ArgumentError('API key must be provided either directly or via environment variables.');
    }
  }

  /// Verifies a fingerprint payload.
  Future<Map<String, dynamic>> verify(String payload) async {
    final url = Uri.parse('$baseUrl/verify');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',  // ✅ Fixed string interpolation
        'Content-Type': 'application/json',
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      return response.body.isNotEmpty ? response.body as Map<String, dynamic> : {};
    } else {
      throw Exception('Verification failed: ${response.body}');
    }
  }
}
