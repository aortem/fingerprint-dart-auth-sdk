import 'dart:html';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

void main() {
  final output = querySelector('#output') as DivElement;

  // Test Initialization
  querySelector('#btn-init')?.onClick.listen((_) {
    print("Initializing SDK...");
    try {
      final auth = FingerprintAuth(apiKey: "my-secret-api-key");
      output.text = "✅ SDK Initialized with key: ${auth.apiKey}";
    } catch (e) {
      output.text = "❌ Error initializing SDK: $e";
    }
  });

  // Test Verify
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
