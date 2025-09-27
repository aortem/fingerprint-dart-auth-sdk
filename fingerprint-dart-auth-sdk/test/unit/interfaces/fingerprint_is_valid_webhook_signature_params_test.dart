import 'package:ds_tools_testing/ds_tools_testing.dart';
import 'package:fingerprint_dart_auth_sdk/src/interfaces/aortem_fingerprint_is_valid_webhook_signature_params.dart';

void main() {
  group('DefaultWebhookSignatureParams', () {
    test('should create a valid instance', () {
      final params = DefaultWebhookSignatureParams(
        payload: 'test-payload',
        signature: 'test-signature',
        secret: 'test-secret',
      );

      expect(params.payload, 'test-payload');
      expect(params.signature, 'test-signature');
      expect(params.secret, 'test-secret');
    });

    test('should throw ArgumentError if payload is empty', () {
      expect(
        () => DefaultWebhookSignatureParams(
          payload: '',
          signature: 'valid-signature',
          secret: 'valid-secret',
        ),
        throwsArgumentError,
      );
    });

    test('should throw ArgumentError if signature is empty', () {
      expect(
        () => DefaultWebhookSignatureParams(
          payload: 'valid-payload',
          signature: '',
          secret: 'valid-secret',
        ),
        throwsArgumentError,
      );
    });

    test('should throw ArgumentError if secret is empty', () {
      expect(
        () => DefaultWebhookSignatureParams(
          payload: 'valid-payload',
          signature: 'valid-signature',
          secret: '',
        ),
        throwsArgumentError,
      );
    });

    test('should convert to JSON correctly', () {
      final params = DefaultWebhookSignatureParams(
        payload: 'test-payload',
        signature: 'test-signature',
        secret: 'test-secret',
      );

      expect(params.toJson(), {
        'payload': 'test-payload',
        'signature': 'test-signature',
        'secret': 'test-secret',
      });
    });
  });
}
