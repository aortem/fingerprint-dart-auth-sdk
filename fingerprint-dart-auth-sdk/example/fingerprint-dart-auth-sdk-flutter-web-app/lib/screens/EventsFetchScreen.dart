import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class EventsFetchScreen extends StatefulWidget {
  const EventsFetchScreen({super.key});

  @override
  State<EventsFetchScreen> createState() => _EventsFetchScreenState();
}

class _EventsFetchScreenState extends State<EventsFetchScreen> {
  final _queryController = TextEditingController(
    text: '{"page": 1, "limit": 10}',
  );
  String _response = "";
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(apiKey: "YOUR_API_KEY_HERE");
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final paramsMap = Map<String, dynamic>.from(
        jsonDecode(_queryController.text),
      );

      final queryParams = ExtractQueryParams(params: paramsMap);

      // Use your SDK method to fetch events
      // Replace with actual method if implemented
      final result = await _client.getEvents(queryParams);

      setState(() {
        _response = const JsonEncoder.withIndent("  ").convert(result);
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
      appBar: AppBar(title: const Text("FingerprintJS - Fetch Events")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _queryController,
              decoration: const InputDecoration(
                labelText: "Query Params (JSON)",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchEvents,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Fetch Events"),
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
