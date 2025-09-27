import 'dart:convert';

import 'package:ds_standard_features/ds_standard_features.dart';
import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/utils/aortem_fingerprint_is_valid_webhook_signature.dart';
// Update with the correct import path

void main() {
  group('isValidWebhookSignature', () {
    const String payload = '{"event": "user.login", "userId": "12345"}';
    const String secret = 'super-secret-key';

    // Generate a valid signature for testing
    String generateSignature(String payload, String secret) {
      final hmac = Hmac(sha256, utf8.encode(secret));
      final digest = hmac.convert(utf8.encode(payload));
      return digest.toString();
    }

    test('should return true for a valid signature', () {
      final validSignature = generateSignature(payload, secret);

      final result = isValidWebhookSignature(
        payload: payload,
        signature: validSignature,
        secret: secret,
      );

      expect(result, isTrue);
    });

    test('should return false for an invalid signature', () {
      final invalidSignature = 'invalid-signature-123';

      final result = isValidWebhookSignature(
        payload: payload,
        signature: invalidSignature,
        secret: secret,
      );

      expect(result, isFalse);
    });

    test('should throw ArgumentError if payload is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: '',
          signature: generateSignature(payload, secret),
          secret: secret,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError if signature is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: payload,
          signature: '',
          secret: secret,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should throw ArgumentError if secret key is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: payload,
          signature: generateSignature(payload, secret),
          secret: '',
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should return false if signature length is incorrect', () {
      final invalidLengthSignature = generateSignature(
        payload,
        secret,
      ).substring(0, 10);

      final result = isValidWebhookSignature(
        payload: payload,
        signature: invalidLengthSignature,
        secret: secret,
      );

      expect(result, isFalse);
    });

    test('should return false for completely different payloads', () {
      const differentPayload = '{"event": "user.logout", "userId": "54321"}';
      final validSignature = generateSignature(differentPayload, secret);

      final result = isValidWebhookSignature(
        payload: payload,
        signature: validSignature,
        secret: secret,
      );

      expect(result, isFalse);
    });
  });
}
