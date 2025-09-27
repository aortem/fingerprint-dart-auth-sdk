import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

class SearchEventsResponseScreen extends StatefulWidget {
  const SearchEventsResponseScreen({super.key});

  @override
  State<SearchEventsResponseScreen> createState() =>
      _SearchEventsResponseScreenState();
}

class _SearchEventsResponseScreenState
    extends State<SearchEventsResponseScreen> {
  final _queryController = TextEditingController(text: "login failure");
  final _limitController = TextEditingController(text: "10");

  String _response = "";
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(apiKey: "YOUR_API_KEY_HERE");
  }

  Future<void> _searchEvents() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final filter = SearchEventsFilter(
        query: _queryController.text.isNotEmpty ? _queryController.text : null,
        limit: int.tryParse(_limitController.text),
      );

      // Call with SearchEventsFilter, not string
      final result = await _client.searchEvents(filter);

      setState(() {
        // Directly encode map
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FingerprintJS - Search Events")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_queryController, "Query"),
            const SizedBox(height: 12),
            _buildTextField(_limitController, "Limit"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _searchEvents,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Search Events"),
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
