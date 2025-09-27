import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

import 'package:flutter_application_1/utils/globals.dart';

class VisitorsResponseScreen extends StatefulWidget {
  const VisitorsResponseScreen({super.key});

  @override
  State<VisitorsResponseScreen> createState() => _VisitorsResponseScreenState();
}

class _VisitorsResponseScreenState extends State<VisitorsResponseScreen> {
  late final FingerprintJsServerApiClient _client;

  String _response = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Replace with your real API key
    _client = FingerprintJsServerApiClient(apiKey: SECRET_API_KEY);
  }

  Future<void> _fetchVisitors() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final result = await _client.getVisitors();

      setState(() {
        if (result is VisitorsResponse) {
          // Use toString() for now instead of toJson()
          _response = result.toString();
        } else {
          _response = "Unexpected response type: ${result.runtimeType}";
        }
      });
    } catch (e) {
      setState(() {
        _response = "Error: $e";
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
      appBar: AppBar(title: const Text("FingerprintJS - VisitorsResponse")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchVisitors,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Fetch Visitors"),
            ),
            const SizedBox(height: 20),
            const Text(
              "Response:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(child: SelectableText(_response)),
            ),
          ],
        ),
      ),
    );
  }
}
