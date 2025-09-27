import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

/// Dummy processor that simulates aggregate unsealing.
class AggregateDataProcessor {
  Map<String, dynamic> unsealData(String sealedData) {
    try {
      // Simulate malformed JSON to trigger error
      throw FormatException("Malformed aggregate data");
    } catch (e) {
      throw UnsealAggregateError(
        message: "Failed to unseal aggregate data",
        statusCode: 500,
        errorData: e.toString(),
      );
    }
  }
}

class UnsealAggregateTestScreen extends StatefulWidget {
  const UnsealAggregateTestScreen({super.key});

  @override
  State<UnsealAggregateTestScreen> createState() =>
      _UnsealAggregateTestScreenState();
}

class _UnsealAggregateTestScreenState extends State<UnsealAggregateTestScreen> {
  final processor = AggregateDataProcessor();
  String _result = "Press the button to test unseal.";

  void _testUnseal() {
    const invalidSealedData = '{"invalidJson":}'; // triggers error
    try {
      final data = processor.unsealData(invalidSealedData);
      setState(() {
        _result = "✅ Unsealed successfully: $data";
      });
    } on UnsealAggregateError catch (e) {
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
      appBar: AppBar(title: const Text("UnsealAggregateError Test")),
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
