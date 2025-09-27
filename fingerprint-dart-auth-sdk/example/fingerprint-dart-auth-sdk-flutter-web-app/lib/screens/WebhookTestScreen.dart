import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
import 'dart:convert';

class WebhookTestScreen extends StatefulWidget {
  const WebhookTestScreen({super.key});

  @override
  State<WebhookTestScreen> createState() => _WebhookTestScreenState();
}

class _WebhookTestScreenState extends State<WebhookTestScreen> {
  final TextEditingController _jsonController = TextEditingController(
    text: '''
{
  "id": "wh_12345",
  "event": "visitor.created",
  "timestamp": "2023-04-25T15:30:00Z",
  "visitorId": "visitor_67890",
  "payload": {
    "ip": "192.168.1.1",
    "browser": "Chrome"
  }
}
''',
  );

  String _parsed = "";
  bool _isError = false;

  void _parseWebhook() {
    setState(() {
      try {
        final Map<String, dynamic> jsonData =
            jsonDecode(_jsonController.text) as Map<String, dynamic>;
        final webhook = Webhook.fromJson(jsonData);
        _parsed = const JsonEncoder.withIndent("  ").convert(webhook.toJson());
        _isError = false;
      } catch (e) {
        _parsed = "Error parsing webhook: $e";
        _isError = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Webhook Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Webhook JSON Payload:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 2,
              child: TextField(
                controller: _jsonController,
                expands: true,
                maxLines: null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _parseWebhook,
              child: const Text("Parse Webhook"),
            ),
            const SizedBox(height: 16),
            const Text(
              "Parsed Result:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isError ? Colors.red[50] : Colors.grey[100],
                  border: Border.all(
                    color: _isError ? Colors.red : Colors.grey.shade400,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  _parsed,
                  style: TextStyle(
                    color: _isError ? Colors.red.shade800 : Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
