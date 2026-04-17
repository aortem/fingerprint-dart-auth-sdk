import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Verifies the authenticity of an incoming webhook request using HMAC-SHA256.
///
/// - [payload]: Raw webhook body.
/// - [signature]: Hex-encoded HMAC digest from the request.
/// - [secret]: Secret key shared between client and server.
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

  final hmac = Hmac(sha256, utf8.encode(secret));
  final digest = hmac.convert(utf8.encode(payload)).toString();

  return _secureCompare(digest, signature);
}

bool _secureCompare(String a, String b) {
  if (a.length != b.length) {
    return false;
  }

  var result = 0;
  for (var i = 0; i < a.length; i++) {
    result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return result == 0;
}
