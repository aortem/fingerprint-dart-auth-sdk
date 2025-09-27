import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

class ErrorResponseTestScreen extends StatefulWidget {
  const ErrorResponseTestScreen({super.key});

  @override
  State<ErrorResponseTestScreen> createState() =>
      _ErrorResponseTestScreenState();
}

class _ErrorResponseTestScreenState extends State<ErrorResponseTestScreen> {
  String _output = "";

  void _testValidJson() {
    final jsonMap = {
      'status': 400,
      'error': 'BadRequest',
      'message': 'Invalid visitorId provided',
    };

    final errorResponse = DefaultErrorResponse.fromJson(jsonMap);

    setState(() {
      _output =
          "✅ Parsed Successfully\n\n"
          "Status: ${errorResponse.status}\n"
          "Error: ${errorResponse.error}\n"
          "Message: ${errorResponse.message}\n\n"
          "JSON: ${jsonEncode(errorResponse.toJson())}";
    });
  }

  void _testInvalidJson() {
    final jsonMap = {
      'status': 500,
      'error': 'InternalError',
      // Missing "message"
    };

    try {
      DefaultErrorResponse.fromJson(jsonMap);
    } catch (e) {
      setState(() {
        _output = "❌ Parsing Failed\n\nException: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ErrorResponse SDK Test")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _testValidJson,
              child: const Text("Test Valid JSON"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _testInvalidJson,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Test Invalid JSON"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style: const TextStyle(fontSize: 14, fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
