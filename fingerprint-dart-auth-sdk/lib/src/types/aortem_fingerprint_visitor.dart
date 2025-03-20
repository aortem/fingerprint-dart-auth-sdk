/// Represents an individual visitor returned by the FingerprintJS Pro API.
class Visitor {
  /// The unique identifier of the visitor.
  final String id;

  /// The fingerprint hash of the visitor.
  final String fingerprint;

  /// The IP address of the visitor.
  final String ip;

  /// The user agent string of the visitor's device.
  final String userAgent;

  /// The timestamp when the visitor was recorded.
  final String timestamp;

  /// Constructor to initialize a Visitor instance.
  Visitor({
    required this.id,
    required this.fingerprint,
    required this.ip,
    required this.userAgent,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Visitor(id: $id, fingerprint: $fingerprint, ip: $ip, userAgent: $userAgent, timestamp: $timestamp)';
  }
}
