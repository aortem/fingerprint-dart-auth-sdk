import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';

// --------- Flutter Web screen ---------

class WebhookSignatureTestScreen extends StatefulWidget {
  const WebhookSignatureTestScreen({super.key});

  @override
  State<WebhookSignatureTestScreen> createState() =>
      _WebhookSignatureTestScreenState();
}

class _WebhookSignatureTestScreenState
    extends State<WebhookSignatureTestScreen> {
  final _payloadController = TextEditingController(
    text: '{"event":"user_signed_in","userId":"abc123"}',
  );
  final _signatureController = TextEditingController();
  final _secretController = TextEditingController(text: 'your_webhook_secret');

  String? _verificationResult;
  String? _computedSignature;

  void _verifySignature() {
    try {
      final payload = _payloadController.text.trim();
      final signature = _signatureController.text.trim();
      final secret = _secretController.text.trim();

      final isValid = isValidWebhookSignature(
        payload: payload,
        signature: signature,
        secret: secret,
      );
      setState(() {
        _verificationResult = isValid
            ? '✅ Webhook signature is valid.'
            : '❌ Invalid webhook signature.';
      });
    } catch (e) {
      setState(() {
        _verificationResult = 'Error: $e';
      });
    }
  }

  void _computeSignature() {
    try {
      final key = utf8.encode(_secretController.text.trim());
      final bytes = utf8.encode(_payloadController.text.trim());
      final hmac = Hmac(sha256, key);
      final digest = hmac.convert(bytes);
      final computed = digest.toString();

      setState(() {
        _computedSignature = computed;
        _signatureController.text = computed; // autofill signature field
      });
    } catch (e) {
      setState(() {
        _computedSignature = 'Error computing signature: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Webhook Signature Test')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Payload:'),
              TextField(
                controller: _payloadController,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter raw webhook body',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Signature:'),
              TextField(
                controller: _signatureController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Signature from webhook header',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Secret:'),
              TextField(
                controller: _secretController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Webhook secret',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _verifySignature,
                    child: const Text('Verify Signature'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _computeSignature,
                    child: const Text('Compute Signature'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_verificationResult != null) ...[
                const Text(
                  'Verification Result:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  _verificationResult!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
              if (_computedSignature != null) ...[
                const SizedBox(height: 20),
                const Text(
                  'Computed Signature:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SelectableText(
                  _computedSignature!,
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
