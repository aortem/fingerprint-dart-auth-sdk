import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class VisitorHistoryScreen extends StatefulWidget {
  const VisitorHistoryScreen({super.key});

  @override
  State<VisitorHistoryScreen> createState() => _VisitorHistoryScreenState();
}

class _VisitorHistoryScreenState extends State<VisitorHistoryScreen> {
  final _visitorIdController = TextEditingController(text: "visitor_abc123");
  final _fromController = TextEditingController(text: "2023-01-01T00:00:00Z");
  final _toController = TextEditingController(text: "2023-01-31T23:59:59Z");
  final _limitController = TextEditingController(text: "10");
  final _offsetController = TextEditingController(text: "0");

  String _response = "";
  bool _isLoading = false;

  late final FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(apiKey: "YOUR_API_KEY_HERE");
  }

  Future<void> _fetchVisitorHistory() async {
    setState(() {
      _isLoading = true;
      _response = "";
    });

    try {
      final filter = VisitorHistoryFilter(
        visitorId: _visitorIdController.text.isNotEmpty
            ? _visitorIdController.text
            : null,
        from: _fromController.text.isNotEmpty ? _fromController.text : null,
        to: _toController.text.isNotEmpty ? _toController.text : null,
        limit: int.tryParse(_limitController.text),
        offset: int.tryParse(_offsetController.text),
      );

      final result = await _client.getVisitorHistory(filter);

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
      appBar: AppBar(title: const Text("FingerprintJS - Visitor History")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_visitorIdController, "Visitor ID"),
            const SizedBox(height: 12),
            _buildTextField(_fromController, "From (ISO date)"),
            const SizedBox(height: 12),
            _buildTextField(_toController, "To (ISO date)"),
            const SizedBox(height: 12),
            _buildTextField(_limitController, "Limit"),
            const SizedBox(height: 12),
            _buildTextField(_offsetController, "Offset"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchVisitorHistory,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Fetch Visitor History"),
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
