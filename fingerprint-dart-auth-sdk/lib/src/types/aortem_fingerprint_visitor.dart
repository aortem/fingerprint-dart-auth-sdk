/// Represents an individual visitor returned by the FingerprintJS Pro API.
class Visitor {
  final String id;
  final String fingerprint;
  final String ip;
  final String userAgent;
  final String timestamp;

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
