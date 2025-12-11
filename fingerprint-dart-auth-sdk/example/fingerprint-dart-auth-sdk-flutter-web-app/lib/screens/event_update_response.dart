import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

class EventsUpdateScreen extends StatefulWidget {
  const EventsUpdateScreen({super.key});

  @override
  State<EventsUpdateScreen> createState() => _EventsUpdateScreenState();
}

class _EventsUpdateScreenState extends State<EventsUpdateScreen> {
  final _eventIdController = TextEditingController(text: "event123");
  final _updatesController = TextEditingController(
    text: '{"status": "resolved", "notes": "Fixed"}',
  );

  String _response = "";
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(apiKey: "YOUR_API_KEY_HERE");
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
      appBar: AppBar(title: const Text("FingerprintJS - Update Event")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _eventIdController,
              decoration: const InputDecoration(
                labelText: "Event ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _updatesController,
              decoration: const InputDecoration(
                labelText: "Updates (JSON)",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _updateEvent,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Update Event"),
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
