import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

class RelatedVisitorsFilterScreen extends StatefulWidget {
  const RelatedVisitorsFilterScreen({super.key});

  @override
  State<RelatedVisitorsFilterScreen> createState() =>
      _RelatedVisitorsFilterScreenState();
}

class _RelatedVisitorsFilterScreenState
    extends State<RelatedVisitorsFilterScreen> {
  final _visitorIdController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _limitController = TextEditingController();
  final _distinctIdController = TextEditingController();

  String _result = '';

  // Initialize your SDK client here
  late FingerprintJsServerApiClient _client;

  @override
  void initState() {
    super.initState();
    _client = FingerprintJsServerApiClient(apiKey: 'YOUR_API_KEY_HERE');
  }

  Future<void> _fetchRelatedVisitors() async {
    final filter = RelatedVisitorsFilter(
      visitorId: _visitorIdController.text.isEmpty
          ? null
          : _visitorIdController.text,
      from: _fromController.text.isEmpty ? null : _fromController.text,
      to: _toController.text.isEmpty ? null : _toController.text,
      distinctId: _distinctIdController.text.isEmpty
          ? null
          : _distinctIdController.text,
      limit: _limitController.text.isEmpty
          ? null
          : int.tryParse(_limitController.text),
    );

    setState(() {
      _result = 'Fetching...';
    });

    try {
      final data = await _client.getRelatedVisitors(filter);
      setState(() {
        _result = data.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FingerprintJS SDK Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _visitorIdController,
              decoration: const InputDecoration(labelText: 'Visitor ID'),
            ),
            TextField(
              controller: _fromController,
              decoration: const InputDecoration(labelText: 'From (ISO Date)'),
            ),
            TextField(
              controller: _toController,
              decoration: const InputDecoration(labelText: 'To (ISO Date)'),
            ),
            TextField(
              controller: _limitController,
              decoration: const InputDecoration(labelText: 'Limit'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _distinctIdController,
              decoration: const InputDecoration(labelText: 'Distinct ID'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchRelatedVisitors,
              child: const Text('Fetch Related Visitors'),
            ),
            const SizedBox(height: 20),
            SelectableText(_result, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _visitorIdController.dispose();
    _fromController.dispose();
    _toController.dispose();
    _limitController.dispose();
    _distinctIdController.dispose();
    super.dispose();
  }
}
