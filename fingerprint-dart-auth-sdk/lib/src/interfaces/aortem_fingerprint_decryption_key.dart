/// Represents the decryption key information required for unsealing operations.
abstract class DecryptionKey {
  /// A unique identifier for the decryption key.
  String get id;

  /// The decryption key material (e.g., the key as a string).
  String get key;
}

/// A data class that implements the [DecryptionKey] interface.
class DefaultDecryptionKey implements DecryptionKey {
  @override
  final String id;

  @override
  final String key;

  /// Constructor to initialize the Decryption Key response.
  DefaultDecryptionKey({required this.id, required this.key}) {
    if (id.isEmpty) {
      throw ArgumentError('DecryptionKey id cannot be empty.');
    }
    if (key.isEmpty) {
      throw ArgumentError('DecryptionKey key cannot be empty.');
    }
  }

  /// Converts the decryption key to a JSON format.
  Map<String, dynamic> toJson() {
    return {'id': id, 'key': key};
  }
}
