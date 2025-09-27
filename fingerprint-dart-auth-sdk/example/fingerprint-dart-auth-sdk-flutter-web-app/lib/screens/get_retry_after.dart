import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class RetryAfterTestScreen extends StatefulWidget {
  const RetryAfterTestScreen({super.key});

  @override
  State<RetryAfterTestScreen> createState() => _RetryAfterTestScreenState();
}

class _RetryAfterTestScreenState extends State<RetryAfterTestScreen> {
  final TextEditingController _headerValueController = TextEditingController();
  String _result = "";

  void _testRetryAfter() {
    final headerValue = _headerValueController.text.trim();

    if (headerValue.isEmpty) {
      setState(() {
        _result = "Please enter a Retry-After header value.";
      });
      return;
    }
    final headers = {'retry-after': headerValue}; // lowercase

    final duration = getRetryAfter(headers);

    setState(() {
      if (duration != null) {
        _result = "Retry after: ${duration.inSeconds} seconds";
      } else {
        _result = "Invalid or no Retry-After value.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Retry-After Test")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Retry-After header value:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _headerValueController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. 120 or Wed, 21 Oct 2015 07:28:00 GMT",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testRetryAfter,
              child: const Text("Test getRetryAfter"),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
