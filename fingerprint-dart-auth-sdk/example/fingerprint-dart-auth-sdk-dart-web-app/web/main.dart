import 'dart:html';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

void main() {
  final output = querySelector('#output') as DivElement;

  // Button: Init SDK
  querySelector('#btn-init')?.onClick.listen((_) {
    try {
      final auth = FingerprintAuth(apiKey: "my-secret-api-key");
      output.text = "✅ SDK Initialized with key: ${auth.apiKey}";
    } catch (e) {
      output.text = "❌ Error initializing SDK: $e";
    }
  });

  // Button: Verify (mock payload)
  querySelector('#btn-verify')?.onClick.listen((_) async {
    try {
      final auth = FingerprintAuth(apiKey: "my-secret-api-key");
      final response = await auth.verify('{"visitorId":"12345"}');
      output.text = "✅ Verify success: $response";
    } catch (e) {
      output.text = "❌ Verify failed: $e";
    }
  });
}
