import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'package:flutter_application_1/utils/globals.dart';

class FingerprintSDKerror extends StatefulWidget {
  const FingerprintSDKerror({super.key});

  @override
  State<FingerprintSDKerror> createState() => _FingerprintSDKerrorState();
}

class _FingerprintSDKerrorState extends State<FingerprintSDKerror> {
  final TextEditingController _visitorIdController = TextEditingController()
    ..text = TEST_VISITOR;
  bool _isLoading = false;
  String _resultMessage = '';

  late FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(
      apiKey: SECRET_API_KEY, // ⚠️ replace with valid API key
    );
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
    } on RequestError catch (e) {
      setState(() {
        _resultMessage =
            "❌ RequestError caught:\nMessage: ${e.message}\nStatus: ${e.statusCode}\nErrorData: ${e.errorData}";
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
      appBar: AppBar(title: const Text('FingerprintJS Dart SDK Test')),
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
            Text(_resultMessage, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
