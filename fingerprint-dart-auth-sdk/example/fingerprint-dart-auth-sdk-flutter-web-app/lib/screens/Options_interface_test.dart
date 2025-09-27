import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class SdkFeatureTestScreen extends StatefulWidget {
  const SdkFeatureTestScreen({super.key});

  @override
  State<SdkFeatureTestScreen> createState() => _SdkFeatureTestScreenState();
}

class _SdkFeatureTestScreenState extends State<SdkFeatureTestScreen> {
  late final FingerprintJsServerApiClient _client;
  String _result = "Press the button to test the SDK feature.";

  @override
  void initState() {
    super.initState();

    // Create DefaultOptions for SDK configuration.
    final options = DefaultOptions(
      apiKey: "YOUR_API_KEY_HERE", // Replace with real API key
      debug: true,
    );

    // Initialize client with options
    _client = FingerprintJsServerApiClient(apiKey: options.apiKey);
  }

  Future<void> _testSdkFeature() async {
    setState(() {
      _result = "⏳ Verifying fingerprint...";
    });

    try {
      // Example payload for testing
      final payload = {'visitorId': 'unique-visitor-id'};

      final result = await _client.verifyFingerprint(payload);
      setState(() {
        _result = "✅ Verification Result: $result";
      });
    } catch (e) {
      setState(() {
        _result = "❌ Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SDK Feature Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _testSdkFeature,
              child: const Text("Run Fingerprint Verification"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: Text(
                _result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
