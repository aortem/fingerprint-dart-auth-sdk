import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

import 'package:flutter_application_1/utils/globals.dart';

class FingerprintRateLimitTestScreen extends StatefulWidget {
  const FingerprintRateLimitTestScreen({super.key});

  @override
  State<FingerprintRateLimitTestScreen> createState() =>
      _FingerprintRateLimitTestScreenState();
}

class _FingerprintRateLimitTestScreenState
    extends State<FingerprintRateLimitTestScreen> {
  final TextEditingController _visitorIdController = TextEditingController(
    text: TEST_VISITOR,
  );
  String _resultMessage = '';
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    // ⚠️ Replace with your real API key
    _client = FingerprintJsServerApiClient(apiKey: SECRET_API_KEY);
  }

  Future<void> _verify() async {
    setState(() {
      _isLoading = true;
      _resultMessage = '';
    });

    final payload = {"visitorId": _visitorIdController.text.trim()};

    try {
      final result = await _client.verifyFingerprint(payload);
      setState(() {
        _resultMessage = "✅ Verification Success:\n$result";
      });
    } on TooManyRequestsError catch (e) {
      setState(() {
        _resultMessage =
            "⏳ Rate Limit Exceeded:\n${e.message}\nStatus: ${e.statusCode}\n"
            "Retry After: ${e.retryAfter?.inSeconds ?? 0}s\nErrorData: ${e.errorData}";
      });
    } on RequestError catch (e) {
      setState(() {
        _resultMessage =
            "❌ RequestError:\nMessage: ${e.message}\nStatus: ${e.statusCode}\nErrorData: ${e.errorData}";
      });
    } catch (e) {
      setState(() {
        _resultMessage = "⚠️ Unexpected Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fingerprint Rate Limit Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Visitor ID",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _visitorIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g., unique-visitor-id",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _verify,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Verify Fingerprint"),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _resultMessage,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
