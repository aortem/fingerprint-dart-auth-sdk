/// Represents configuration options for the Fingerprint Dart Auth SDK.
abstract class Options {
  /// The API key used for authentication with the FingerprintJS Pro API.
  String get apiKey;

  /// The base URL for API requests. Defaults to 'https://api.fingerprintjs.com'.
  String get baseUrl;

  /// The timeout duration for HTTP requests.
  Duration get timeout;

  /// A flag indicating whether debug logging is enabled.
  bool get debug;
}

/// A default implementation of the [Options] interface.
class DefaultOptions implements Options {
  @override
  final String apiKey;
  @override
  final String baseUrl;
  @override
  final Duration timeout;
  @override
  final bool debug;

  /// Constructor with default values for optional parameters.
  DefaultOptions({
    required this.apiKey,
    this.baseUrl = 'https://api.fingerprintjs.com',
    this.timeout = const Duration(seconds: 10),
    this.debug = false,
  }) {
    if (apiKey.isEmpty) {
      throw ArgumentError('API key cannot be empty.');
    }
  }

  /// Converts the object into a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'baseUrl': baseUrl,
      'timeout': timeout.inSeconds,
      'debug': debug,
    };
  }
}
