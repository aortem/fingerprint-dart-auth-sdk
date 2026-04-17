import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/utils/fingerprint_is_valid_webhook_signature.dart';

void main() {
  group('isValidWebhookSignature', () {
    const payload = '{"event": "user.login", "userId": "12345"}';
    const secret = 'super-secret-key';

    String generateSignature(String payload, String secret) {
      final hmac = Hmac(sha256, utf8.encode(secret));
      final digest = hmac.convert(utf8.encode(payload));
      return digest.toString();
    }

    test('returns true for a valid signature', () {
      final validSignature = generateSignature(payload, secret);

      final result = isValidWebhookSignature(
        payload: payload,
        signature: validSignature,
        secret: secret,
      );

      expect(result, isTrue);
    });

    test('returns false for an invalid signature', () {
      final result = isValidWebhookSignature(
        payload: payload,
        signature: 'invalid-signature-123',
        secret: secret,
      );

      expect(result, isFalse);
    });

    test('throws ArgumentError if payload is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: '',
          signature: generateSignature(payload, secret),
          secret: secret,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError if signature is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: payload,
          signature: '',
          secret: secret,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError if secret key is empty', () {
      expect(
        () => isValidWebhookSignature(
          payload: payload,
          signature: generateSignature(payload, secret),
          secret: '',
        ),
        throwsArgumentError,
      );
    });

    test('returns false if signature length is incorrect', () {
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

    test('returns false for completely different payloads', () {
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
