import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart'; // For Hmac + sha256

class WebhookTestScreen extends StatefulWidget {
  const WebhookTestScreen({super.key});

  @override
  State<WebhookTestScreen> createState() => _WebhookTestScreenState();
}

class _WebhookTestScreenState extends State<WebhookTestScreen> {
  final _payloadController = TextEditingController();
  final _signatureController = TextEditingController();
  final _secretController = TextEditingController();

  String? _resultMessage;

  bool isValidWebhookSignature({
    required String payload,
    required String signature,
    required String secret,
  }) {
    if (payload.isEmpty) throw ArgumentError('Payload cannot be empty.');
    if (signature.isEmpty) throw ArgumentError('Signature cannot be empty.');
    if (secret.isEmpty) throw ArgumentError('Secret cannot be empty.');

    final hmac = Hmac(sha256, utf8.encode(secret));
    final digest = hmac.convert(utf8.encode(payload)).toString();

    return _secureCompare(digest, signature);
  }

  bool _secureCompare(String a, String b) {
    if (a.length != b.length) return false;
    int result = 0;
    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }

  void _verifySignature() {
    try {
      final isValid = isValidWebhookSignature(
        payload: _payloadController.text,
        signature: _signatureController.text,
        secret: _secretController.text,
      );

      setState(() {
        _resultMessage = isValid
            ? "✅ Webhook signature is VALID"
            : "❌ Webhook signature is INVALID";
      });
    } catch (e) {
      setState(() {
        _resultMessage = "⚠️ Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Webhook Signature Test")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _payloadController,
              decoration: const InputDecoration(
                labelText: "Payload",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _signatureController,
              decoration: const InputDecoration(
                labelText: "Signature",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _secretController,
              decoration: const InputDecoration(
                labelText: "Secret",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifySignature,
              child: const Text("Verify Signature"),
            ),
            const SizedBox(height: 20),
            if (_resultMessage != null)
              Text(
                _resultMessage!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _resultMessage!.contains("VALID")
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
