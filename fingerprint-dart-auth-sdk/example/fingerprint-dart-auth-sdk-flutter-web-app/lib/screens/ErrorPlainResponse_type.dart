import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class ErrorPlainResponseTestScreen extends StatefulWidget {
  const ErrorPlainResponseTestScreen({super.key});

  @override
  State<ErrorPlainResponseTestScreen> createState() =>
      _ErrorPlainResponseTestScreenState();
}

class _ErrorPlainResponseTestScreenState
    extends State<ErrorPlainResponseTestScreen> {
  late final FingerprintJsServerApiClient _client;
  String _result = "Press a button to test the SDK feature.";

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(
      apiKey: "YOUR_API_KEY_HERE", // replace with real key
    );
  }

  Future<void> _testSuccessCase() async {
    setState(() {
      _result = "⏳ Sending request...";
    });

    try {
      const payload = {'visitorId': 'valid-visitor-id'}; // expected success
      final result = await _client.verifyFingerprint(payload);
      setState(() {
        _result = "✅ Success:\n$result";
      });
    } catch (e) {
      setState(() {
        _result = "❌ Error:\n$e";
      });
    }
  }

  Future<void> _testErrorCase() async {
    setState(() {
      _result = "⏳ Sending invalid request...";
    });

    try {
      const payload = {'invalidField': 'oops'}; // expected to trigger error
      final result = await _client.verifyFingerprint(payload);
      setState(() {
        _result = "✅ Unexpected Success:\n$result";
      });
    } catch (e) {
      setState(() {
        // Try to extract ErrorPlainResponse from exception message
        if (e.toString().contains('ErrorPlainResponse')) {
          _result = "❌ Structured Error:\n$e";
        } else {
          _result = "⚠️ Unexpected error:\n$e";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ErrorPlainResponse Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _testSuccessCase,
              child: const Text("Test Success Case"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testErrorCase,
              child: const Text("Test Error Case"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 500,
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
