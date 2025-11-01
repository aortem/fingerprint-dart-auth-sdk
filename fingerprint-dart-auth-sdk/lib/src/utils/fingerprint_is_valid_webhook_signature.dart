import 'dart:convert';
import 'package:jwt_generator/jwt_generator.dart';

/// Verifies the authenticity of an incoming webhook request using
/// HMAC-SHA256 via the `jwt_generator` package.
///
/// - [payload]: Raw webhook body (String)
/// - [signature]: Base64-encoded signature from the request
/// - [secret]: Secret key shared between client and server
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

  // 1. Convert secret to bytes (expected by constructor)
  final secretBytes = utf8.encode(secret);
  final verifier = HmacSignatureVerifier(secret: secretBytes);

  // 2. Pass payload as String and signature as String to verify()
  String normalizedSignature;
  try {
    // Ensure signature is valid Base64
    base64Decode(signature);
    normalizedSignature = signature;
  } catch (_) {
    throw ArgumentError('Signature must be valid Base64.');
  }

  // 3. Perform verification
  final isValid = verifier.verify(payload, normalizedSignature);

  return isValid;
}
