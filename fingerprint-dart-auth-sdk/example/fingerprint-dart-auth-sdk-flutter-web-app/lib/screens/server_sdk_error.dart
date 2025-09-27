import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter_application_1/utils/globals.dart';

class FingerprintSdkTestScreen extends StatefulWidget {
  const FingerprintSdkTestScreen({super.key});

  @override
  State<FingerprintSdkTestScreen> createState() =>
      _FingerprintSdkTestScreenState();
}

class _FingerprintSdkTestScreenState extends State<FingerprintSdkTestScreen> {
  final TextEditingController _visitorIdController = TextEditingController(
    text: TEST_VISITOR,
  );
  String _resultMessage = '';
  bool _isLoading = false;

  FingerprintJsServerApiClient? _client;

  @override
  void initState() {
    super.initState();
    try {
      _client = FingerprintJsServerApiClient(
        apiKey: SECRET_API_KEY, // 🔴 Leave empty to trigger SdkError
        // apiKey: 'YOUR_API_KEY_HERE', // ✅ Use this to test valid flow
      );
    } on SdkError catch (e) {
      setState(() {
        _resultMessage = "⚠️ SDK Error during initialization:\n$e";
      });
    }
  }

  Future<void> _verify() async {
    if (_client == null) {
      setState(() {
        _resultMessage =
            "⚠️ SDK is not initialized. Please fix API key configuration.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _resultMessage = '';
    });

    final payload = {"visitorId": _visitorIdController.text.trim()};

    try {
      final result = await _client!.verifyFingerprint(payload);
      setState(() {
        _resultMessage = "✅ Verification Success:\n$result";
      });
    } on RequestError catch (e) {
      setState(() {
        _resultMessage =
            "❌ RequestError caught:\nMessage: ${e.message}\nStatus: ${e.statusCode}\nErrorData: ${e.errorData}";
      });
    } on SdkError catch (e) {
      setState(() {
        _resultMessage = "⚠️ SDK Error:\n$e";
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
      appBar: AppBar(title: const Text('Fingerprint SDK Test')),
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
