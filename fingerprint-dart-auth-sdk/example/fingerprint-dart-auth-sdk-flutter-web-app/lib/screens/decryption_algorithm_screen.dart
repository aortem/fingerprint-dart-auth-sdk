import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fingerprint_dart_auth_sdk/fingerprint_dart_auth_sdk.dart';
// import 'package:flutter_application_1/utils/globals.dart';

/// Request model that includes DecryptionAlgorithm.
class FingerprintRequest {
  final String visitorId;
  final DecryptionAlgorithm decryptionAlgorithm;

  FingerprintRequest({
    required this.visitorId,
    this.decryptionAlgorithm = DecryptionAlgorithm.aes256Gcm,
  });

  Map<String, dynamic> toJson() {
    return {
      'visitorId': visitorId,
      'decryptionAlgorithm': decryptionAlgorithm.toString().split('.').last,
    };
  }
}

/// Screen to test DecryptionAlgorithm enum behavior.
class DecryptionAlgorithmScreen extends StatefulWidget {
  const DecryptionAlgorithmScreen({super.key});

  @override
  State<DecryptionAlgorithmScreen> createState() =>
      _DecryptionAlgorithmScreenState();
}

class _DecryptionAlgorithmScreenState extends State<DecryptionAlgorithmScreen> {
  DecryptionAlgorithm _selectedAlgo = DecryptionAlgorithm.aes256Gcm;
  String _response = "";

  void _sendRequest() async {
    setState(() {
      _response = "Processing...";
    });

    try {
      // // Initialize FingerprintAuth client
      // final fingerprintAuth = FingerprintAuth(
      //   apiKey: SECRET_API_KEY,
      //   baseUrl: BASE_URL,
      // );

      // Build request
      final request = FingerprintRequest(
        visitorId: "visitor-67890",
        decryptionAlgorithm: _selectedAlgo,
      );

      // Mock call: replace with fingerprintAuth.verify(request.toJson()) for real API
      final result = {
        "status": "ok",
        "decryptionAlgorithm": request.decryptionAlgorithm
            .toString()
            .split('.')
            .last,
        "visitorId": request.visitorId,
      };

      setState(() {
        _response =
            "Request JSON:\n${jsonEncode(request.toJson())}\n\nResponse:\n${jsonEncode(result)}";
      });
    } catch (e) {
      setState(() {
        _response = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DecryptionAlgorithm Demo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Decryption Algorithm:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text("AES-256-GCM (default)"),
              leading: Radio<DecryptionAlgorithm>(
                value: DecryptionAlgorithm.aes256Gcm,
                groupValue: _selectedAlgo,
                onChanged: (algo) {
                  setState(() {
                    _selectedAlgo = algo!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("RSA-OAEP"),
              leading: Radio<DecryptionAlgorithm>(
                value: DecryptionAlgorithm.rsaOaep,
                groupValue: _selectedAlgo,
                onChanged: (algo) {
                  setState(() {
                    _selectedAlgo = algo!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendRequest,
              child: const Text("Send Fingerprint Request"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  style: const TextStyle(fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
