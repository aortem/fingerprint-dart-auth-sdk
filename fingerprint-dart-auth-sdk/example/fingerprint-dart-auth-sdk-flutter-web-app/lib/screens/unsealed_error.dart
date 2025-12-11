import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

/// Dummy unsealer that simulates single element unsealing.
class DataUnsealer {
  Map<String, dynamic> unseal(String sealedData) {
    try {
      // Simulate failure (malformed JSON in this example).
      throw FormatException("Malformed sealed data");
    } catch (e) {
      throw UnsealError(
        message: "Failed to unseal data",
        errorData: e.toString(),
      );
    }
  }
}

class UnsealErrorTestScreen extends StatefulWidget {
  const UnsealErrorTestScreen({super.key});

  @override
  State<UnsealErrorTestScreen> createState() => _UnsealErrorTestScreenState();
}

class _UnsealErrorTestScreenState extends State<UnsealErrorTestScreen> {
  final _unsealer = DataUnsealer();
  String _result = "Press the button to test unseal.";

  void _testUnseal() {
    const malformedData = '{"invalidJson":}'; // triggers error
    try {
      final data = _unsealer.unseal(malformedData);
      setState(() {
        _result = "✅ Unsealed successfully: $data";
      });
    } on UnsealError catch (e) {
      setState(() {
        _result = "❌ Error: ${e.toString()}";
      });
    } catch (e) {
      setState(() {
        _result = "⚠️ Unexpected error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UnsealError Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _testUnseal,
              child: const Text("Test Unseal Operation"),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
