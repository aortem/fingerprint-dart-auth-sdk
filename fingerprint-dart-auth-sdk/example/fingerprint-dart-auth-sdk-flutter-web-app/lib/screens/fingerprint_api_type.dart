import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class FingerprintWebTestScreen extends StatefulWidget {
  const FingerprintWebTestScreen({super.key});

  @override
  State<FingerprintWebTestScreen> createState() =>
      _FingerprintWebTestScreenState();
}

class _FingerprintWebTestScreenState extends State<FingerprintWebTestScreen> {
  final _queryController = TextEditingController(text: '{"page":1,"limit":5}');
  final _eventIdController = TextEditingController(text: "event123");
  final _updatesController = TextEditingController(
    text: '{"status": "resolved"}',
  );

  String _response = "";
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(
      apiKey: "YOUR_API_KEY_HERE",
      baseUrl: "https://api.fingerprintjs.com",
      region: Region.us,
      // Remove or import http.Client if needed
    );
  }

  Future<void> _fetchEvents() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final queryMap = jsonDecode(_queryController.text);
      if (queryMap is! Map<String, dynamic>) {
        throw Exception("Query parameters must be a JSON object.");
      }

      final queryParams = ExtractQueryParams(params: queryMap);

      final result = await _client.getEvents(queryParams);

      setState(() {
        _response = const JsonEncoder.withIndent("  ").convert(result);
      });
    } catch (e) {
      setState(() {
        _response = "Error fetching events: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateEvent() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final updates = jsonDecode(_updatesController.text);
      if (updates is! Map<String, dynamic>) {
        throw Exception("Updates must be a JSON object.");
      }

      final request = EventsUpdateRequest(
        eventId: _eventIdController.text,
        updates: updates,
      );

      final result = await _client.updateEvent(request);

      setState(() {
        _response = const JsonEncoder.withIndent("  ").convert(result);
      });
    } catch (e) {
      setState(() {
        _response = "Error updating event: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildTextInput({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildButton({required String label, required VoidCallback onTap}) {
    return ElevatedButton(
      onPressed: _isLoading ? null : onTap,
      child: _isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FingerprintJS Web Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fetch Events",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildTextInput(
              label: "Query Params (JSON)",
              controller: _queryController,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            _buildButton(label: "Fetch Events", onTap: _fetchEvents),
            const Divider(height: 32),

            const Text(
              "Update Event",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildTextInput(label: "Event ID", controller: _eventIdController),
            const SizedBox(height: 8),
            _buildTextInput(
              label: "Updates (JSON)",
              controller: _updatesController,
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            _buildButton(label: "Update Event", onTap: _updateEvent),
            const Divider(height: 32),

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
