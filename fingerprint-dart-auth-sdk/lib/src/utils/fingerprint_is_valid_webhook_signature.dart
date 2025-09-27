import 'dart:convert';
import 'package:ds_standard_features/ds_standard_features.dart';

/// Verifies the authenticity of an incoming webhook request.
///
/// - [payload]: The raw body of the webhook request.
/// - [signature]: The signature provided in the webhook request headers.
/// - [secret]: The secret key used for HMAC hashing.
///
/// Returns `true` if the computed signature matches the provided signature, otherwise `false`.
///
/// Throws [ArgumentError] if any parameter is missing or invalid.
bool isValidWebhookSignature({
  required String payload,
  required String signature,
  required String secret,
}) {
  if (payload.isEmpty) {
    throw ArgumentError('Payload cannot be empty.');
  }
  if (signature.isEmpty) {
    throw ArgumentError('Signature cannot be empty.');
  }
  if (secret.isEmpty) {
    throw ArgumentError('Secret key cannot be empty.');
  }

  // Compute HMAC SHA256 hash
  final hmac = Hmac(sha256, utf8.encode(secret));
  final digest = hmac.convert(utf8.encode(payload));

  // Convert computed digest to hex string
  final computedSignature = digest.toString();

  // Use constant-time comparison to prevent timing attacks
  return _secureCompare(computedSignature, signature);
}

/// Performs a constant-time string comparison to prevent timing attacks.
bool _secureCompare(String a, String b) {
  if (a.length != b.length) return false;

  int result = 0;
  for (int i = 0; i < a.length; i++) {
    result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return result == 0;
}
