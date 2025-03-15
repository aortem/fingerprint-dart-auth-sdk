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

  IntegrationInfo({
    required this.name,
    required this.type,
    required this.version,
    required this.publicKey,
  });

  @override
  String toString() {
    return 'IntegrationInfo(name: $name, type: $type, version: $version, publicKey: $publicKey)';
  }

  /// Creates an instance from a JSON object.
  factory IntegrationInfo.fromJson(Map<String, dynamic> json) {
    return IntegrationInfo(
      name: json['name'] as String? ?? 'unknown',
      type: json['type'] as String? ?? 'unknown',
      version: json['version'] as String? ?? 'unknown',
      publicKey: json['publicKey'] as String? ?? 'unknown',
    );
  }
}
