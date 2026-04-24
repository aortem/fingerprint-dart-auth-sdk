/// Represents the integration metadata retrieved from the FingerprintJS Pro API.
class IntegrationInfo {
  /// The name of the integration.
  final String name;

  /// The type of integration (e.g., "server", "client").
  final String type;

  /// The version of the SDK used.
  final String version;

  /// The public API key associated with the integration.
  final String publicKey;

  /// Constructor to initialize integration metadata.
  ///
  /// Requires [name], [type], [version], and [publicKey].
  IntegrationInfo({
    required this.name,
    required this.type,
    required this.version,
    required this.publicKey,
  });

  @override
  String toString() =>
      'IntegrationInfo(type: $type, version: $version, publicKey: $publicKey)';

  /// Creates an instance from a JSON object.
  ///
  factory IntegrationInfo.fromJson(Map<String, dynamic> json) {
    return IntegrationInfo(
      name: json['name'] as String? ?? '',
      type: json['type'] as String,
      version: json['version'] as String,
      publicKey: json['publicKey'] as String,
    );
  }
}
