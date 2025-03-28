/// Represents the decryption algorithm to be used for processing fingerprint data.
enum DecryptionAlgorithm {
  /// Uses the AES-256-GCM algorithm for decryption.
  aes256Gcm,

  /// Uses the RSA-OAEP algorithm for decryption.
  rsaOaep,
}
